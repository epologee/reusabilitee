package com.epologee.ui.scrolling {
	import com.epologee.ui.buttons.IEnableDisable;
	import com.epologee.ui.mouse.MouseFilter;
	import com.epologee.ui.mouse.MouseFilterEvent;
	import com.epologee.util.NumberUtils;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	[Event(name="SLIDE", type="com.epologee.ui.scrolling.SliderBehaviorEvent")]
	//
	public class SliderBehavior extends EventDispatcher {
		public static const LAYOUT_VERTICAL : String = "LAYOUT_VERTICAL";
		public static const LAYOUT_HORIZONTAL : String = "LAYOUT_HORIZONTAL";
		//
		private var _track : Sprite;
		private var _thumb : Sprite;
		private var _minValue : Number;
		private var _maxValue : Number;
		private var _limitValue : Number = 1;
		private var _layout : String;
		private var _enabled : Boolean;
		private var _isScrolling : Boolean;
		private var _filter : MouseFilter;
		private var _bounds : Rectangle;
		private var _normalizedValue : Number;
		private var _lastNormalizedValue : Number;

		public function SliderBehavior(inTrack : Sprite, inThumb : Sprite) {
			_track = inTrack;
			_thumb = inThumb;
			_thumb.mouseChildren = false;
		}

		public function get maxValue() : Number {
			return _maxValue;
		}

		public function get minValue() : Number {
			return _minValue;
		}

		public function get value() : Number {
			return NumberUtils.map(_normalizedValue, 0, 1, _minValue, _maxValue);
		}

		public function set value(inValue : Number) : void {
			normalizedValue = NumberUtils.map(inValue ? inValue : 0, _minValue, _maxValue, 0, 1);
		}

		public function get normalizedValue() : Number {
			return _normalizedValue;
		}

		public function set normalizedValue(inValue : Number) : void {
			_normalizedValue = NumberUtils.limit(inValue ? inValue * _limitValue : 0, 0, 1);
		}

		public function updateThumbPosition() : void {
			if (isVertical()) {
				_thumb.y = _bounds.top + _normalizedValue * _bounds.height / (_limitValue * _limitValue);
			} else {
				_thumb.x = _bounds.left + _normalizedValue * _bounds.width  / (_limitValue * _limitValue);
				if (_thumb.x < _bounds.left) _thumb.x = _bounds.left;
			}
		}

		public function reset(inNormalizedValue : Number) : void {
			normalizedValue = inNormalizedValue;

			if (isVertical()) {
				_thumb.y = NumberUtils.map(normalizedValue, 0, 1, _bounds.top, _bounds.bottom);
			} else {
				_thumb.x = NumberUtils.map(normalizedValue, 0, 1, _bounds.left, _bounds.right);
			}

			dispatchScroll(true);
		}

		public function initialize(inMinValue : Number, inMaxValue : Number, inSubtractThumb : Boolean = false, inLimitSlide:Number = 1, inLayout : String = LAYOUT_HORIZONTAL) : void {
			_minValue = inMinValue;
			_maxValue = inMaxValue;
			_limitValue = inLimitSlide;
			_layout = inLayout;

			if (isVertical()) {
				_bounds = new Rectangle(_thumb.x, _track.y, 0, Math.ceil(_track.height * _limitValue));
				_bounds.height -= inSubtractThumb ? _thumb.height : 0;
			} else {
				_bounds = new Rectangle(_track.x, _thumb.y, Math.ceil(_track.width * _limitValue), 0);
				_bounds.width -= inSubtractThumb ? _thumb.width : 0;
			}

			enable();
		}

		public function isVertical() : Boolean {
			return _layout == LAYOUT_VERTICAL;
		}

		public function disable() : void {
			if (_enabled === false)
				return;

			_enabled = false;
			_thumb.buttonMode = _enabled;
			_thumb.removeEventListener(MouseEvent.MOUSE_DOWN, handleThumbDown);

			if (_thumb is IEnableDisable) {
				IEnableDisable(_thumb).disable();
			}

			if (_track is IEnableDisable) {
				IEnableDisable(_track).disable();
			}
		}

		public function enable() : void {
			if (_enabled === true)
				return;

			_enabled = true;
			_thumb.buttonMode = _enabled;
			_thumb.addEventListener(MouseEvent.MOUSE_DOWN, handleThumbDown);

			if (_thumb is IEnableDisable) {
				IEnableDisable(_thumb).enable();
			}

			if (_track is IEnableDisable) {
				IEnableDisable(_track).enable();
			}
		}

		private function handleThumbDown(event : MouseEvent) : void {
			_isScrolling = true;

			dispatchEvent(new SliderBehaviorEvent(SliderBehaviorEvent.START_SLIDING, normalizedValue, value));

			if (!_filter) {
				_filter = new MouseFilter(_thumb.stage);
			}

			_filter.addEventListener(MouseFilterEvent.INACTIVITY_TIMEOUT, handleThumbUp);
			_filter.addEventListener(MouseEvent.MOUSE_MOVE, handleThumbScroll);
			_filter.addEventListener(Event.MOUSE_LEAVE, handleThumbUp);

			_thumb.stage.addEventListener(MouseEvent.MOUSE_UP, handleThumbUp);
			_thumb.startDrag(false, _bounds);
		}

		private function handleThumbUp(event : Event = null) : void {
			_isScrolling = false;

			_filter.removeEventListener(MouseFilterEvent.INACTIVITY_TIMEOUT, handleThumbUp);
			_filter.removeEventListener(MouseEvent.MOUSE_MOVE, handleThumbScroll);
			_filter.removeEventListener(Event.MOUSE_LEAVE, handleThumbUp);
			_thumb.stage.removeEventListener(MouseEvent.MOUSE_UP, handleThumbUp);
			_thumb.stopDrag();

			dispatchEvent(new SliderBehaviorEvent(SliderBehaviorEvent.STOP_SLIDING, normalizedValue, value));
		}

		private function handleThumbScroll(event : MouseEvent = null) : void {
			var ds : Number;
			if (isVertical()) {
				ds = _thumb.y - _track.y;
				normalizedValue = ds / _bounds.height;
			} else {
				ds = _thumb.x - _track.x;
				normalizedValue = ds / _bounds.width;
			}

			dispatchScroll();
		}

		private function dispatchScroll(inForceDispatch : Boolean = false) : void {
			if (inForceDispatch || _lastNormalizedValue != normalizedValue) {
				dispatchEvent(new SliderBehaviorEvent(SliderBehaviorEvent.SLIDE, normalizedValue, value));
			}

			_lastNormalizedValue = normalizedValue;
		}
	}
}
