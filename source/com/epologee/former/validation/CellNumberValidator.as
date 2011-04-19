package com.epologee.former.validation {
	import com.epologee.former.input.IFormerInput;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class CellNumberValidator implements IFormerValidator {
		private var _message : String;

		public function CellNumberValidator(inMessage : String) {
			_message = inMessage;
		}

		public function validate(input : IFormerInput) : Boolean {
			var reg : RegExp = /^(((00|[+]){1}[1-9]{3})|0[1-9])[0-9]{8}$/;
			return reg.test(input.stringValue);
		}

		public function get message() : String {
			return _message;
		}
	}
}
