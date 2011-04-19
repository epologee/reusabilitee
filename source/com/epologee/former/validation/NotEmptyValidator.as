package com.epologee.former.validation {
	import com.epologee.former.input.IFormerInput;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class NotEmptyValidator implements IFormerValidator {
		private var _message : String;
		private var _required : int;

		public function NotEmptyValidator(inMessage : String, inRequiredCharacterLength:int = 1) {
			_message = inMessage;
			_required = inRequiredCharacterLength;
		}

		public function validate(input : IFormerInput) : Boolean {
			var reg : RegExp = new RegExp("\\S{" + _required.toString() + ",}", "g");
			return reg.test(input.stringValue);
		}

		public function get message() : String {
			return _message;
		}
	}
}
