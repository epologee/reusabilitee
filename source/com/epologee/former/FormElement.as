package com.epologee.former {
	import com.epologee.former.input.FormerInputEvent;
	import com.epologee.former.input.IFormerErrorInput;
	import com.epologee.former.input.IFormerInput;
	import com.epologee.former.validation.IFormerValidator;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	internal class FormElement {
		public var name : String;
		public var input : IFormerInput;
		public var validator : IFormerValidator;
		private var _valid : Boolean;

		public function FormElement(inName : String, inInput : IFormerInput, inValidator : IFormerValidator) {
			validator = inValidator;
			input = inInput;
			name = inName;
		}

		public function get message():String {
			return validator.message;
		}

		public function updateVisual() : void {
			if (input is IFormerErrorInput) {
				if (_valid) {
					IFormerErrorInput(input).clearError();
					input.removeEventListener(FormerInputEvent.VALUE_CHANGED, revalidate);
				} else {
					IFormerErrorInput(input).displayError(message);
					input.addEventListener(FormerInputEvent.VALUE_CHANGED, revalidate);
				}
			}
		}

		private function revalidate(event : FormerInputEvent) : void {
			var i : IFormerErrorInput = input as IFormerErrorInput;

			if (isValid()) {
				i.clearError();
			}
		}

		public function isValid() : Boolean {
			_valid = validator.validate(input);
			return _valid;
		}

		public function toString():String {
			return "[FormElement " + name + ", " + validator + "]";
		}

		public function disable() : void {
			input.disable();
		}

		public function enable() : void {
			input.enable();
		}
	}
}
