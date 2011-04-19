package com.epologee.time {
	import com.epologee.development.logging.logger;

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/**
	 * @author Eric-Paul Lecluse
	 */
	public class Stopwatch extends EventDispatcher {
		public static const SPEED_FACTOR : uint = 1;
		// 
		private var _isRunning : Boolean;
		private var _startTime : int;
		private var _stopTime : int;
		private var _logTimer : Timer;
		private var _progressTimer : Timer;

		public function Stopwatch() {
			reset();
		}

		/**
		 * @return -1 when reset or not yet started. If already running or paused, 
		 * will return the amount of milliseconds watched.
		 */
		public function get time() : int {
			if (_isRunning) {
				return SPEED_FACTOR * (getTimer() - _startTime);
			}
			if (_stopTime > _startTime) {
				return SPEED_FACTOR * (_stopTime - _startTime);
			}
			return -1;
		}

		public function get seconds() : Number {
			return time / 1000;
		}

		public function reset() : void {
			_startTime = 0;
			_stopTime = 0;
			_isRunning = false;

			if (_progressTimer) {
				_progressTimer.stop();
			}
		}

		public function start() : int {
			if (_isRunning) return time;

			_isRunning = true;
			if (_stopTime) {
				_startTime += getTimer() - _stopTime;
			} else {
				_startTime = getTimer();
			}

			if (_progressTimer) {
				_progressTimer.start();
			}

			return time;
		}

		public function jumpStart(inToTimeMS : int) : void {
			_isRunning = true;
			
			jump(inToTimeMS);

			if (_progressTimer) {
				_progressTimer.start();
			}
		}

		public function jump(inToTimeMS : int) : void {
			_stopTime = _startTime = getTimer() - inToTimeMS;
		}

		public function stop() : int {
			if (!_isRunning) return time;

			_isRunning = false;
			_stopTime = getTimer();

			if (_progressTimer) {
				_progressTimer.stop();
			}

			return time;
		}

		override public function addEventListener(type : String, listener : Function, useCapture : Boolean = false, priority : int = 0, useWeakReference : Boolean = false) : void {
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);

			if (type == TimerEvent.TIMER) {
				if (!_progressTimer) {
					_progressTimer = new Timer(100);
				}
				if (_isRunning) {
					_progressTimer.start();
				}

				_progressTimer.addEventListener(TimerEvent.TIMER, dispatchEvent);
			}
		}

		override public function removeEventListener(type : String, listener : Function, useCapture : Boolean = false) : void {
			super.removeEventListener(type, listener, useCapture);

			if (type == TimerEvent.TIMER && _progressTimer) {
				_progressTimer.removeEventListener(TimerEvent.TIMER, dispatchEvent);

				if (!_progressTimer.hasEventListener(type)) {
					_progressTimer.stop();
					_progressTimer = null;
				}
			}
		}

		public function log(inTraceLog : Boolean = true) : void {
			if (inTraceLog) {
				_logTimer = new Timer(100, 0);
				_logTimer.addEventListener(TimerEvent.TIMER, handleLogTick);
				_logTimer.start();
				handleLogTick();
			} else {
				_logTimer.removeEventListener(TimerEvent.TIMER, handleLogTick);
				_logTimer.stop();
			}
		}

		private function handleLogTick(e : Event = null) : void {
			if (!_isRunning) return;
			logger.debug(".... " + time);
		}

		public function isRunning() : Boolean {
			return _isRunning;
		}

		override public function toString() : String {
			return "[Stopwatch " + time + "]";
		}
	}
}
