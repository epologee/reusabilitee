package com.epologee.application {
	import com.greensock.loading.ImageLoader;
	import com.epologee.application.preloader.indicator.SpinnerIcon;
	import com.epologee.util.drawing.Draw;
	import com.epologee.util.drawing.ShapeDrawings;
	import com.greensock.events.LoaderEvent;
	import com.greensock.loading.LoaderMax;
	import com.greensock.loading.SelfLoader;
	import com.greensock.loading.VideoLoader;
	import com.greensock.loading.XMLLoader;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;

	/**
	 * @author Ralph Kuijpers @ Rocket Science Studios
	 */
	public class AbstractPreloader extends Sprite {
		protected var _preloadUrl : String;
		//
		private var _timeline : DisplayObjectContainer;
		private var _spinner : DisplayObject;
		private var _bar : DisplayObject;
		private var _progress : Number;
		private var _queue : LoaderMax;

		public function AbstractPreloader(preloadUrl : String = null) {
			LoaderMax.activate([SelfLoader, XMLLoader, VideoLoader, ImageLoader]);
			_preloadUrl = preloadUrl ? preloadUrl : "../xml/preload.xml";
		}

		public function set timeline(timeline : DisplayObjectContainer) : void {
			_timeline = timeline;
		}

		public function get timeline() : DisplayObjectContainer {
			return _timeline;
		}

		public function get progress() : Number {
			return _progress;
		}

		public function start() : void {
			prepare();

			_queue = new LoaderMax({name:"mainQueue", auditSize:true, onProgress:handleProgress, onComplete:handleComplete, onError:handleError});

			if (_preloadUrl) {
				var xmlLoader : XMLLoader = new XMLLoader(_preloadUrl);
				_queue.append(xmlLoader);
			}
			
			var applicationLoader : SelfLoader = new SelfLoader(_timeline);
			_queue.append(applicationLoader);

			_queue.load();
		}

		/**
		 * Override when you want to create a custom loading/progress visual.
		 */
		protected function prepare() : void {
			if (!_timeline) throw new Error("Set the timeline before calling prepare()");

			_spinner = _timeline.addChild(new SpinnerIcon(0xFFFFFF, 10, 5, 2));
			_spinner.x = _timeline.stage.stageWidth / 2;
			_spinner.y = _timeline.stage.stageHeight / 2;

			_bar = _timeline.addChild(ShapeDrawings.windowCentered(64, 6, 1, 0xFFFFFF, 1));
			_bar.x = Math.round(_spinner.x);
			_bar.y = Math.round(_spinner.y + _spinner.height);
			_bar.filters = [new DropShadowFilter(4, 45, 0, 1, 4, 4)];
		}

		protected function updateProgress() : void {
			if (!_bar) return;

			Draw.clear(_bar);
			Draw.window(_bar, 64, 6, 1, 0xFFFFFF, 1, new Point(-32, -3));
			Draw.rectangle(_bar, 60 * progress, 2, 0xFFFFFF, 1, new Point(-30, -1));
		}

		protected function finish() : void {
			_spinner.parent.removeChild(_spinner);
			_bar.parent.removeChild(_bar);

			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function handleProgress(event : LoaderEvent) : void {
			_progress = LoaderMax(LoaderMax.getLoader("mainQueue")).progress;
			updateProgress();
		}

		private function handleComplete(event : LoaderEvent) : void {
			finish();
		}

		private function handleError(event : LoaderEvent) : void {
			fatal(event.text);
		}
	}
}
