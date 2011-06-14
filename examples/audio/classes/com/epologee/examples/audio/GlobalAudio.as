package com.epologee.examples.audio {
	import com.epologee.audio.AudioLoader;
	import com.epologee.audio.IAudioController;

	import flash.events.Event;
	import flash.events.EventDispatcher;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public class GlobalAudio extends EventDispatcher {
		private static const INSTANCE : GlobalAudio = new GlobalAudio();
		//
		private var _audio : IAudioController;
		private var _loader : AudioLoader;

		public static function getInstance() : GlobalAudio {
			return INSTANCE;
		}

		public function get audio() : IAudioController {
			return _audio;
		}

		public function GlobalAudio() {
			if (INSTANCE) throw new Error("singleton: use GlobalAudio.getInstance()");
			
			_loader = new AudioLoader();
			_loader.addEventListener(Event.COMPLETE, handleAudioComplete);
		}
		
		public function loadAudio() : void {
			if (isLoaded()) {
				dispatchEvent(new Event(Event.COMPLETE));
				return; 
			}
			
			_loader.load("AudioLibrary.swf");
		}

		public function isLoaded() : Boolean {
			return _audio is IAudioController;
		}

		private function handleAudioComplete(event : Event) : void {
			_loader.removeEventListener(Event.COMPLETE, handleAudioComplete);
			_audio = AudioLoader(event.target).audioController;
			dispatchEvent(event);
		}
	}
}
