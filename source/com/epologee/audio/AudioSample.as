package com.epologee.audio {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public class AudioSample extends EventDispatcher implements IAudioSample {
		public var loops : Boolean = false;
		public var voiceCancelling : Boolean = false;
		//
		private var _name : String;	
		private var _sound : Sound;
		private var _channels : Array;
		private var _position : Number = 0;
		private var _maxVolume : Number = 1;
		private var _masterVolume : Number;
		private var _currentVolume : Number;
		private var _panning : Number = 0;

		public function get name() : String {
			return _name;
		}

		public function get isPlaying() : Boolean {
			return _channels.length > 0;
		}

		public function get position() : Number {
			return _position;
		}

		public function get duration() : Number {
			return _sound.length;
		}

		public function AudioSample(inSound : Sound, inName : String) {
			_sound = inSound;
			_name = inName;
			_channels = [];
			
			masterVolume = 1;
			volume = 1;
		}

		public function set masterVolume(inMasterVolume : Number) : void {
			_masterVolume = inMasterVolume;
			
			volume = _currentVolume;
		}

		public function get maxVolume() : Number {
			return _maxVolume;
		}

		public function set maxVolume(inMaxVolume : Number) : void {
			_maxVolume = inMaxVolume;
			
			volume = _currentVolume;
		}

		public function set volume(inVolume : Number) : void {
			_currentVolume = inVolume;
			
			var leni : int = _channels.length;
			for (var i : int = 0;i < leni;i++) {
				var channel : SoundChannel = SoundChannel(_channels[i]);
				var adjustedVolume : SoundTransform = channel.soundTransform;
				adjustedVolume.volume = _currentVolume * _masterVolume * _maxVolume;
				channel.soundTransform = adjustedVolume;
			}
		}

		public function get volume() : Number {
			return _currentVolume;
		}

		public function get pan() : Number {
			return _panning;
		}

		/**
		 * @param inPanning -1 full pan left, 0 center, 1 full pan right.
		 */
		public function set pan(inPanning : Number) : void {
			_panning = inPanning;

			var leni : int = _channels.length;
			for (var i : int = 0;i < leni;i++) {
				var channel : SoundChannel = SoundChannel(_channels[i]);
				var adjustedVolume : SoundTransform = channel.soundTransform;
				adjustedVolume.pan = _panning;
				channel.soundTransform = adjustedVolume;
			}
		}

		public function play() : void {
			startSound(0);
		}

		public function resume() : void {
			startSound(position);
		}

		public function stop() : void {
			var channel : SoundChannel;
			while (channel = _channels.shift() as SoundChannel) {
				channel.stop();
				removeChannel(channel);
			}
		}

		private function startSound(inPosition : Number) : void {
			if (voiceCancelling) stop();
			
			// yes, it's weak, but we're just passing a very high number into the loops parameter if it's supposed to loop.
			var channel : SoundChannel = _sound.play(inPosition, loops ? 0xFFFFFF : 1);
			_position = channel.position;
			channel.addEventListener(Event.SOUND_COMPLETE, handleSoundComplete);

			_channels.push(channel);
			
			volume = _currentVolume;
			pan = _panning;
		}

		private function handleSoundComplete(event : Event) : void {
			var channel : SoundChannel = SoundChannel(event.target);
			_position = channel.position;
			removeChannel(channel);
			
			dispatchEvent(event);
		}

		private function removeChannel(inChannel : SoundChannel) : void {
			inChannel.removeEventListener(Event.SOUND_COMPLETE, handleSoundComplete);

			var leni : int = _channels.length;
			for (var i : int = 0;i < leni;i++) {
				if (_channels[i] == inChannel) {
					_channels.splice(i, 1);
					return;
				}
			}
		}

		override public function toString() : String {
			var s : String = "";
			s = "[ " + name + " ]:";
			return s + getQualifiedClassName(this);
		}
	}
}
