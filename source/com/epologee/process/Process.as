package com.epologee.process {
	import com.epologee.time.TimeDelay;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class Process {
		public static const FAILURE : int = -1;
		public static const WAITING : int = 0;
		public static const BUSY : int = 1;
		public static const SUCCESS : int = 2;
		//
		private var _status : int;
		private var _callbacks : Array;
		private var _name : String;

		/**
		 * The name is only used for logging purposes
		 */
		public function Process(name : String = "") {
			_status = WAITING;
			_name = name;
		}

		public function get name() : String {
			return _name;
		}

		/**
		 * If you want to retrieve the FAILED/SUCCESS state after completing, use this accessor.
		 */
		public function get status() : int {
			return _status;
		}

		/**
		 * The start() method will return a boolean value indicating whether it started (true) or was already busy or completed (false).
		 * This way you can use the start call in your flow, to decide whether to execute the processing code or not.
		 * When the process has already finished, the callbacks will be executed in a new thread, just in case you just added a new callback. 
		 * 
		 * Example:
		 * 
		 * 		_encodeProcess ||= new Process();
		 * 		_encodeProcess.addCallback(inCallback);
		 * 		if (!_encodeProcess.start()) return;
		 * 
		 * 		_encoder = new AsyncJPGEncoder(75);
		 * 		_encoder.addEventListener(Event.COMPLETE, handleEncoderComplete);
		 * 		
		 */
		public function start() : Boolean {
			switch(_status) {
				case WAITING:
					_status = BUSY;
					return true;
				case BUSY:
					break;
				case FAILURE:
					new TimeDelay(executeCallbacks, 0, [false]);
					break;
				case SUCCESS:
					new TimeDelay(executeCallbacks, 0, [true]);
					break;
			}

			return false;
		}

		/**
		 * Pass the inSuccess flag to state whether the process succeeded or failed.
		 * The callbacks will be called either way.
		 */
		public function finish(success : Boolean = true) : void {
			if (_status == FAILURE)
				throw new Error("Process.finish(): Can't set status to success when already failed. Use reset() first.");

			_status = success ? SUCCESS : FAILURE;

			executeCallbacks(success);
		}

		public function reset() : void {
			_status = WAITING;
			_callbacks = null;
		}

		/**
		 * This callback will fire when the process finishes, no matter success or failure.
		 * If you provide the same callback twice, it will not be added the second time, regardless of the other arguments.
		 */
		public function addCallback(callback : Function, ...arguments : Array) : void {
			if (!validateCallback(callback))
				return;

			_callbacks ||= [];

			var c : Callback = new Callback(callback, arguments);
			_callbacks.push(c);
		}

		/**
		 * This callback will fire when the process finishes with success
		 * If you provide the same callback twice, it will not be added the second time, regardless of the other arguments.
		 */
		public function addSuccessCallback(callback : Function, ...arguments : Array) : void {
			if (!validateCallback(callback))
				return;

			_callbacks ||= [];

			var c : Callback = new Callback(callback, arguments);
			c.onlyExecuteOn = Callback.SUCCESS;
			_callbacks.push(c);
		}

		/**
		 * This callback will fire when the process finishes with failure
		 * If you provide the same callback twice, it will not be added the second time, regardless of the other arguments.
		 */
		public function addFailureCallback(callback : Function, ...arguments : Array) : void {
			if (!validateCallback(callback))
				return;
			_callbacks ||= [];

			var c : Callback = new Callback(callback, arguments);
			c.onlyExecuteOn = Callback.FAILURE;
			_callbacks.push(c);
		}

		private function validateCallback(callback : Function) : Boolean {
			if (!(callback is Function))
				return false;
			if (!_callbacks)
				return true;

			for each (var existingCallback : Callback in _callbacks) {
				if (existingCallback.method == callback)
					return false;
			}

			return true;
		}

		private function executeCallbacks(success : Boolean) : void {
			if (!_callbacks)
				return;

			while (_callbacks.length) {
				var cb : Callback = Callback(_callbacks.shift());
				cb.execute(success, _name);
			}

			_callbacks = null;
		}

		public function toString() : String {
			var s : String;
			switch(_status) {
				case FAILURE:
					s = "FINISHED, FAILED";
					break;
				case WAITING:
					s = "WAITING";
					break;
				case BUSY:
					s = "BUSY";
					break;
				case SUCCESS:
					s = "FINISHED, SUCCESS";
					break;
			}

			if (!_callbacks)
				return "[Process " + name + " status: " + s + " no callbacks]";
			return "[Process " + name + " status: " + s + " callbacks: " + _callbacks.length + "]";
		}
	}
}
import com.epologee.development.logging.logger;
class Callback {
	public static const SUCCESS : String = "success";
	public static const FAILURE : String = "failure";
	//
	public var method : Function;
	public var args : Array;
	public var onlyExecuteOn : String;

	public function Callback(method : Function, arguments : Array) {
		this.method = method;
		this.args = arguments;
	}

	public function execute(success : Boolean, name : String) : void {
		if (!(method is Function))
			return;

		var go : Boolean = !onlyExecuteOn || (onlyExecuteOn == SUCCESS && success) || (onlyExecuteOn == FAILURE && !success);

		if (go) {
			if (args && args.length) {
				try {
					method.apply(null, args);
				} catch(e : Error) {
					logger.error(name + " error: " + e.message + " --> "+e.getStackTrace());
				}
			} else {
				method.apply();
			}
		}

		method = null;
		args = null;
	}
}
