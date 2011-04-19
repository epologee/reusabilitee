package com.epologee.security {
	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 * 
	 * This class can be used to protect important user values (scores, answers, etc) from
	 * memory injection hacking.
	 */
	public class AntiMemoryInjectionNumber extends EventDispatcher {
		public static const VALUE_SET : String = "VALUE_SET";
		//
		private var _value : Number;
		private var _injection : Number;
		
		public function AntiMemoryInjectionNumber() {
			_value = 0;
			_injection = 0;
		}

		public function get value() : Number {
			return _value - _injection;
		}

		public function set value(inValue : Number) : void {
			_injection = Math.round(Math.random() * 100000);
			_value = inValue + _injection;
			dispatchEvent(new Event(VALUE_SET));
		}
		
		override public function toString():String {
			return "[Number "+value.toString()+" ]";
		}
	}
}