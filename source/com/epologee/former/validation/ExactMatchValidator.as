package com.epologee.former.validation {
	import com.epologee.former.input.IFormerInput;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class ExactMatchValidator implements IFormerValidator {
		private var _message : String;
		private var _matchValue : String;

		public function ExactMatchValidator(inMessage : String, inMatchValue : String) {
			_message = inMessage;
			_matchValue = inMatchValue;
		}

		public function validate(input : IFormerInput) : Boolean {
			return input.stringValue == _matchValue;
		}

		public function get message() : String {
			return _message;
		}
	}
}
