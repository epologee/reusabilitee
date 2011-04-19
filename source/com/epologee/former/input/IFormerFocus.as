package com.epologee.former.input {
	import flash.display.InteractiveObject;
	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public interface IFormerFocus extends IFormerInput {
		function get focusElement() : InteractiveObject;
	}
}
