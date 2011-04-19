package com.epologee.audio {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public class AudioTrack extends EventDispatcher implements IAudioTrack {
		public static const SEAMLESS_MODE : String = "seamless tracks";
		public static const EXCLUSIVE_MODE : String = "exclusive tracks";
		//
		private var _tracks : Array;
		private var _mode : String;
		private var _name : String;
		private var _band : Number = 0;
		private var _panning : Number = 0;
		private var _volume : Number = 1;
		private var _masterVolume : Number;
		private var _maxVolume : Number = 1;
		private var _loops : Boolean;

		public function get name() : String {
			return _name;
		}

		public function AudioTrack(inName : String, inSounds : Array, inLoops : Boolean = false, inMode : String = SEAMLESS_MODE) {
			_tracks = [];
			_mode = inMode;
			_name = inName;
			_loops = inLoops;
			
			var leni : int = inSounds.length;
			for (var i : int = 0;i < leni;i++) {
				var s : Sound = inSounds[i] as Sound;
				if (s) {
					var ms : AudioSample = new AudioSample(s, inName);
					// we will use the onsoundcomplete event to loop sounds.
					ms.loops = false;
					_tracks.push(ms);
				}
			}
			
			masterVolume = 1;
		}

		public function get isPlaying() : Boolean {
			var t : IAudioSample = _tracks[0] as IAudioSample;
			if (!t) return false;
			return t.isPlaying;
		}

		public function play() : void {
			var leni : int = _tracks.length;
			for (var i : int = 0;i < leni;i++) {
				var track : IAudioSample = _tracks[i] as IAudioSample;
				track.play();
				// will be reset in setBand()
				track.volume = 0;
			}
			
			if (_loops) {
				getLongestSample().addEventListener(Event.SOUND_COMPLETE, handleLoopMoment);
			}
			
			band = _band;
		}

		public function get duration() : Number {
			var max : IAudioSample = getLongestSample();
			if (!max) return 0;
			return max.duration;
		}			

		private function getLongestSample() : IAudioSample {
			if (!_tracks.length) return null;
			
			var max : IAudioSample = _tracks[0] as IAudioSample;
			var leni : int = _tracks.length;
			for (var i : int = 0;i < leni;i++) {
				var track : IAudioSample = _tracks[i] as IAudioSample;
				if (track.duration > max.duration) {
					max = track;
				}
			}
			return max;
		}

		public function stop() : void {
			var leni : int = _tracks.length;
			for (var i : int = 0;i < leni;i++) {
				var track : AudioSample = _tracks[i] as AudioSample;
				track.stop();
			}
		}

		public function set masterVolume(inMasterVolume : Number) : void {
			_masterVolume = inMasterVolume;
			volume = _volume;
		}

		public function get maxVolume() : Number {
			return _maxVolume;
		}

		public function set maxVolume(inMaxVolume : Number) : void {
			_maxVolume = inMaxVolume;
			
			band = _band;
		}

		public function set volume(inVolume : Number) : void {
			_volume = inVolume;
			band = _band;
		}

		public function get volume() : Number {
			return _volume;
		}

		public function get panning() : Number {
			return _panning;
		}

		public function set pan(inPanning : Number) : void {
			_panning = inPanning;

			var leni : int = _tracks.length;
			for (var i : int = 0;i < leni;i++) {
				var track : AudioSample = _tracks[i] as AudioSample;
				track.pan = _panning;
			}
		}

		public function set band(inBandPosition : Number) : void {
			_band = inBandPosition;
			var vs : Array = [];
			
			var leni : int = _tracks.length;
			for (var i : int = 0;i < leni;i++) {
				var mapped : Number = inBandPosition * (leni - 1);
				var factor : Number = Math.max(1 - Math.abs(i - mapped), 0);
				
				vs.push(Math.round(factor * 100));
				
				var track : AudioSample = _tracks[i] as AudioSample;
				track.volume = factor * _volume * _masterVolume * _maxVolume;
			}
		}

		public function get band() : Number {
			return _band;
		}

		private function handleLoopMoment(event : Event) : void {
			play();
		}

		override public function toString() : String {
			var s : String = "";
			// s = "[ " + name + " ]:";
			return s + getQualifiedClassName(this);
		}
	}
}
