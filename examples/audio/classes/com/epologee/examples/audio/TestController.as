package com.epologee.examples.audio {
	import com.bit101.components.Label;
	import com.bit101.components.PushButton;
	import com.bit101.components.Slider;
	import com.epologee.audio.IAudioController;
	import com.epologee.audio.IAudioSample;
	import com.epologee.audio.IAudioTrack;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public class TestController extends Sprite {
		public static const ACTION_PLAY:String = "Play";
		public static const ACTION_STOP:String = "Stop";
		//
		private var _audio : IAudioController;
		private var _sliders : Dictionary;
		private var _muted : Boolean;

		public function TestController() {
			_sliders = new Dictionary();
			
			GlobalAudio.getInstance().addEventListener(Event.COMPLETE, handleAudioLoaded);
			GlobalAudio.getInstance().loadAudio();
		}

		private function handleAudioLoaded(event : Event) : void {
			_audio = GlobalAudio.getInstance().audio;
			
			new Label(this, 10, 10, "Master Volume");
			new PushButton(this, 120, 10, "Toggle Mute", toggleMute).toggle = true;
			var vsl : Slider = new Slider(Slider.HORIZONTAL, this, 240, 10, handleVolumeChange);
			vsl.setSliderParams(0, 1, 1);

			var names : Array = _audio.getSoundNames();
			var sounds : Dictionary = _audio.getSounds();
			
			var leni : int = names.length;
			for (var i : int = 0;i < leni; i++) {
				var s : IAudioSample = sounds[names[i]] as IAudioSample;
				new PushButton(this, 10, 40 + 25 * i, [ACTION_PLAY, s.name].join(" "), handleClick);
				new PushButton(this, 120, 40 + 25 * i, [ACTION_STOP, s.name].join(" "), handleClick);

				var t : IAudioTrack = s as IAudioTrack;
				
				if (t) {
					var sl : Slider = new Slider(Slider.HORIZONTAL, this, 240, 40 + 25 * (i), handleBandChange);
					sl.setSliderParams(0, 1, 0);
					_sliders[sl] = t.name;
				}
			}
		}
		
		private function toggleMute(e:Event) : void {
			_muted = !_muted;
			_audio.setMuted(_muted);
		}

		private function handleClick(e : Event) : void {
			var chunks : Array = String(PushButton(e.target).label).split(" ");		
			var action : String = chunks[0];
			var soundName : String = chunks[1];
			
			switch (action) {
				case ACTION_PLAY:
					_audio.play(soundName);
					break;
				case ACTION_STOP:
					_audio.stop(soundName);
					break;
			}
		}

		private function handleBandChange(e : Event) : void {
			var slider : Slider = Slider(e.target);
			var soundName : String = _sliders[slider];
			
			_audio.setTrackBand(soundName, slider.value);
		}	

		private function handleVolumeChange(e : Event) : void {
			var slider : Slider = Slider(e.target);
			
			_audio.setMasterVolume(slider.value);
		}	
	}
}
