package com.epologee.former {
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class FormerEvent extends Event {
		public static const SUBMIT_KEY_PRESSED : String = "SUBMIT_KEY_PRESSED";

		//
		// public properties:
		public function FormerEvent(inType : String) {
			super(inType, true);
		}

		override public function clone():Event {
			var c : FormerEvent = new FormerEvent(type);
			return c;
		}

		override public function toString():String {
			return getQualifiedClassName(this);
		}
	}
}
