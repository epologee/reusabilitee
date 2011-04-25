package com.epologee.examples.audio {
	import com.epologee.sound_library.MusicTrackClose;
	import com.epologee.sound_library.MusicTrackMediumClose;
	import com.epologee.sound_library.MusicTrackMediumFar;
	import com.epologee.sound_library.MusicTrackFar;
	import com.epologee.audio.BaseAudioController;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public class AudioLibrary extends BaseAudioController {
		override protected function initializeSounds() : void {
			engine.addSound(AudioNames.GAME_MUSIC, [new MusicTrackFar(), new MusicTrackMediumFar(), new MusicTrackMediumClose(), new MusicTrackClose()]);
		}
	}
}
