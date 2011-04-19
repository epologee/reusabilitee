package com.epologee.former.input {
	import com.epologee.ui.buttons.IEnableDisable;

	import flash.events.IEventDispatcher;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	[Event(name="VALUE_CHANGED", type="com.epologee.former.input.FormerInputEvent")]
	public interface IFormerInput extends IEventDispatcher, IEnableDisable {
		function get stringValue() : String;

		function set stringValue(value : String) : void;
	}
}
