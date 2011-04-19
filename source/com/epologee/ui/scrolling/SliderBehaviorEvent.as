package com.epologee.ui.scrolling {
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class SliderBehaviorEvent extends Event {
		public static const SLIDE : String = "SLIDE";
		public static const START_SLIDING : String = "START_SLIDING";
		public static const STOP_SLIDING : String = "STOP_SLIDING";
		//
		// public properties:
		public var normalizedValue : Number;
		public var value : Number;

		public function SliderBehaviorEvent(inType : String, inNormalizedValue : Number, inValue : Number) {
			value = inValue;
			normalizedValue = inNormalizedValue;
			super(inType, true);
		}

		override public function clone() : Event {
			var c : SliderBehaviorEvent = new SliderBehaviorEvent(type, normalizedValue, value);
			return c;
		}

		override public function toString() : String {
			// com.epologee.ui.scrolling.SlideBehavior
			return getQualifiedClassName(this);
		}
	}
}
