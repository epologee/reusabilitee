package com.epologee.former.validation {
	import com.epologee.former.input.IFormerInput;
	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public interface IFormerValidator {
		function validate(input : IFormerInput) : Boolean;
		function get message():String;
	}
}
