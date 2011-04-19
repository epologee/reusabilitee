package com.epologee.audio {
	import flash.events.Event;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class AudioEvent extends Event {
		public static const PLAY:String = "PLAY";
		public static const STOP:String = "STOP";
		//
		// public properties:
		public var name:String;
		
		public function AudioEvent(inType:String, inName:String) {
			super(inType, true);
			name = inName;
		}

		override public function clone():Event {
			var c:AudioEvent = new AudioEvent(type, name);
			return c;
		}
		
		override public function toString():String {
			// nl.rocketsciencestudios.game.SoundEvent
			return getQualifiedClassName(this);
		}
	}
}
