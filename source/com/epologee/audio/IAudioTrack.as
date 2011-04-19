package com.epologee.audio {

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public interface IAudioTrack extends IAudioSample {
		function set band(inPosition : Number) : void;
		function get band():Number;
	}
}
