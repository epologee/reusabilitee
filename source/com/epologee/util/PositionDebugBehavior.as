package com.epologee.util {
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.ui.Keyboard;
	import flash.utils.Timer;

	/**
	 * @author Jankees van Woezik | Base42.nl
	 * 
	 * Usage:
	 * new PositionDebugBehavior(_arrow);
	 *
	 */
	public class PositionDebugBehavior {
		private var _displayObject : DisplayObject;
		private var _prefix : String;
		//
		private var _up : Boolean;
		private var _right : Boolean;
		private var _down : Boolean;
		private var _left : Boolean;
		private var _plus : Boolean;
		private var _minus : Boolean;
		//
		private var _shift : Boolean;
		private var _control : Boolean;
		//
		private var _timer : Timer;
		private var _rotate : Boolean;
		private var _moved : Boolean;

		public function PositionDebugBehavior(inDisplayObject : DisplayObject, inPrefix : String = "") {
			_prefix = inPrefix;
			_displayObject = inDisplayObject;
			if (_displayObject.stage) {
				initialize();
			} else {
				_displayObject.addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			}
		}

		private function handleAddedToStage(event : Event) : void {
			_displayObject.removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
			initialize();
		}

		private function initialize() : void {
			error("POSITION BEHAVIOUR INITIALIZED, REMOVE WHEN READY");
			_displayObject.stage.addEventListener(KeyboardEvent.KEY_DOWN, handleKeyDown);
			_displayObject.stage.addEventListener(KeyboardEvent.KEY_UP, handleKeyUp);

			_timer = new Timer(75);
			_timer.addEventListener(TimerEvent.TIMER, move);
		}

		private function handleKeyDown(event : KeyboardEvent) : void {
			if (setKeyCode(event, true)) {
				_moved = false;
			}

			if (_left || _right || _up || _down || _plus || _minus) {
				_timer.start();
			}
		}

		private function handleKeyUp(event : KeyboardEvent) : void {
			if (!_moved) {
				move(null);
			}

			if (event.keyCode == Keyboard.SPACE) {
				_rotate = !_rotate;
			}

			setKeyCode(event, false);

			copyToClipboard();

			if (!(_left || _right || _up || _down || _plus || _minus)) {
				_timer.stop();
			}
		}

		private function copyToClipboard() : void {
			var prefix : String = _prefix != "" ? _prefix + "." : "";
			var toClipboard : String = "";

			if (_displayObject.x) toClipboard += prefix + "x = " + _displayObject.x + "; \n";
			if (_displayObject.y) toClipboard += prefix + "y = " + _displayObject.y + "; \n";
			if (_displayObject.rotation) toClipboard += prefix + "rotation = " + _displayObject.rotation + ";";
			if (_displayObject.scaleX != 1) toClipboard += prefix + "scaleX = " + prefix + "scaleY = " + _displayObject.scaleX + ";";

			try {
				System.setClipboard(toClipboard);
			} catch(e : Error) {
				// ignore
			} finally {
				debug("Copying to clipboard: \n" + toClipboard);
			}
		}

		private function setKeyCode(inEvent : KeyboardEvent, inValue : Boolean) : Boolean {
			_shift = inEvent.shiftKey;
			_control = inEvent.ctrlKey;

			switch (inEvent.keyCode) {
				case Keyboard.LEFT:
					_left = inValue;
					break;
				case Keyboard.RIGHT:
					_right = inValue;
					break;
				case Keyboard.UP:
					_up = inValue;
					break;
				case Keyboard.DOWN:
					_down = inValue;
					break;
				case 187:
					_plus = inValue;
					break;
				case 189:
					_minus = inValue;
					break;
				default:
					return false;
			}

			return true;
		}

		private function move(event : Event = null) : void {
			_moved = true;

			var x : Number = 0;
			var y : Number = 0;
			var r : Number = 0;
			var s : Number = 1;

			if (_left) {
				if (_rotate) {
					r -= 1;
				} else {
					x -= 1;
				}
			}

			if (_right) {
				if (_rotate) {
					r += 1;
				} else {
					x += 1;
				}
			}

			if (_up) {
				if (_rotate) {
					r -= 1;
				} else {
					y -= 1;
				}
			}

			if (_down) {
				if (_rotate) {
					r += 1;
				} else {
					y += 1;
				}
			}

			if (_plus) {
				s *= 1.01;
			} else if (_minus) {
				s *= 0.99;
			}

			if (_shift) {
				x *= 10;
				y *= 10;
				r *= 10;
			}

			if (_control) {
				x *= 0.5;
				y *= 0.5;
				r *= 0.5;
			}

			_displayObject.x += x;
			_displayObject.y += y;
			_displayObject.rotation += r;
			_displayObject.scaleX *= s;
			_displayObject.scaleY *= s;
		}
	}
}
