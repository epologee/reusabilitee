package com.epologee.former.validation {
	import com.epologee.former.input.IFormerInput;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class EmailValidator implements IFormerValidator {
		private var _message : String;

		public function EmailValidator(inMessage : String) {
			_message = inMessage;
		}

		public function validate(input : IFormerInput) : Boolean {
			var reg : RegExp = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i;
			return reg.test(input.stringValue);
		}

		public function get message() : String {
			return _message;
		}
	}
}
