package com.epologee.former {
	import com.epologee.development.logging.logger;
	import com.epologee.former.input.IFormerInput;
	import com.epologee.former.validation.IFormerValidator;
	import com.epologee.former.validation.NullValidator;

	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 * 
	 * TODO: Improvements:
	 * 1)	Introduce form steps
	 * 2)	Enable optional (yet validatable) inputs
	 */
	[Event(name="SUBMIT_KEY_PRESSED", type="com.epologee.former.FormerEvent")]
	public class Former extends EventDispatcher {
		protected var _tabIndex : int;
		protected var _isEnabled : Boolean;
		protected var _DataClass : Class;
		//
		private var _elements : Array;
		private var _messages : Array;
		private var _invalids : Array;

		public function Former(inDataClass : Class = null) {
			DataClass = inDataClass;
			
			// reset the tabindex
			_tabIndex = 0;

			// enabled by default
			_isEnabled = true;
		}

		public function set DataClass(inDataClass : Class) : void {
			_DataClass = inDataClass ? inDataClass : FormerData;
		}

		public function addInput(inName : String, inInput : IFormerInput, inValidator : IFormerValidator = null) : void {
			inValidator ||= new NullValidator();

			_elements ||= [];

			var element : FormElement = new FormElement(inName, inInput, inValidator);

			// if (inInput.focusElement) {
			// inInput.focusElement.tabEnabled = true;
			// inInput.focusElement.tabIndex = ++_tabIndex;
			// notice("Adding tab index " + _tabIndex + " to " + inInput);
			// }

			_elements.push(element);

			if (!_isEnabled) element.disable();
		}

		public function removeInput(inInput : IFormerInput) : void {
			var leni : int = _elements.length;
			for (var i : int = 0; i < leni; i++) {
				if (FormElement(_elements[i]).input == inInput) {
					_elements.splice(i, 1);
					return;
				}
			}
		}

		public function validate() : Boolean {
			// reset messages
			_messages = [];
			_invalids = [];

			for each (var element : FormElement in _elements) {
				if (!element.isValid()) {
					_messages.push(element.message);
					_invalids.push(element.input);
				}

				element.updateVisual();
			}

			return (_invalids.length == 0);
		}

		public function disable() : void {
			if (!_isEnabled) return;
			_isEnabled = false;

			for each (var element : FormElement in _elements) {
				element.disable();
			}
		}

		public function enable() : void {
			if (_isEnabled) return;
			_isEnabled = true;

			for each (var element : FormElement in _elements) {
				element.enable();
			}
		}

		public function get data() : Object {
			var d : Object = new _DataClass();

			mergeData(d);

			return d;
		}

		public function set data(inData : Object) : void {
			for each (var element : FormElement in _elements) {
				if (inData.hasOwnProperty(element.name)) {
					element.input.stringValue = inData[element.name];
					logger.info("Prefilled " + element.name + " with " + element.input.stringValue);
				} else {
					logger.warn("Can't find a value to prefill" + element.name);
				}
			}
		}

		internal function mergeData(inByReference : Object) : void {
			for each (var element : FormElement in _elements) {
				// This will throw a runtime error if the data class does not accept the element's name:
				inByReference[element.name] = element.input.stringValue;
			}
		}

		public function get messages() : Array {
			return _messages;
		}

		public function get invalids() : Array {
			return _invalids;
		}

		public function submitOnEnter(inEnabled : Boolean, inStage : Stage) : void {
			if (inEnabled) {
				inStage.addEventListener(KeyboardEvent.KEY_DOWN, checkSubmitKey);
			} else {
				inStage.removeEventListener(KeyboardEvent.KEY_DOWN, checkSubmitKey);
			}
		}

		private function checkSubmitKey(event : KeyboardEvent) : void {
			if (event.keyCode == Keyboard.ENTER) {
				dispatchEvent(new FormerEvent(FormerEvent.SUBMIT_KEY_PRESSED));
			}
		}
	}
}