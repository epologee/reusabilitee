package com.epologee.former.input {

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public interface IFormerErrorInput extends IFormerInput {
		function displayError(inMessage : String):void;
		function clearError():void;
	}
}
