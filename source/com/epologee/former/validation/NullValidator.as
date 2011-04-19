package com.epologee.former.validation {
	import com.epologee.former.input.IFormerInput;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class NullValidator implements IFormerValidator {
		public function validate(input : IFormerInput) : Boolean {
			return true;
		}

		public function get message() : String {
			return "";
		}
	}
}
