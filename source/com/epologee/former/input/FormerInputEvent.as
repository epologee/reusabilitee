package com.epologee.former.input {
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class FormerInputEvent extends Event {
		public static const VALUE_CHANGED:String = getQualifiedClassName(FormerInputEvent)+":VALUE_CHANGED";
		//
		// public properties:
		
		public function FormerInputEvent(inType:String) {
			super(inType, true);
		}
		
		override public function clone():Event {
			var c:FormerInputEvent = new FormerInputEvent(type);
			return c;
		}
		
		override public function toString():String {
			return getQualifiedClassName(this);
		}
	}
}
