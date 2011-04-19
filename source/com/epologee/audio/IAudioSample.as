package com.epologee.audio {
	import flash.events.IEventDispatcher;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public interface IAudioSample extends IEventDispatcher {
		function play() : void;

		function stop() : void;

		function set masterVolume(inMasterVolume : Number) : void;

		function set maxVolume(inMaxVolume : Number) : void;

		function set volume(inVolume : Number) : void;

		function set pan(inPanning : Number) : void;

		function get volume() : Number;

		function get name() : String;

		function get isPlaying() : Boolean;

		function get duration() : Number;
	}
}
