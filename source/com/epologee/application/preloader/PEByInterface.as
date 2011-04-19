package com.epologee.application.preloader {
	import flash.events.Event;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class PEByInterface extends AbstractPreloadElement {
		private var _preloadable : IPreloadable;

		public function PEByInterface(inPreloadable : IPreloadable) {
			_preloadable = inPreloadable;
			super(_preloadable.bytesToPreload);
		}

		override public function start() : void {
			_preloadable.initialize(callbackComplete);
		}

		private function callbackComplete(e : Event = null) : void {
			progress = 1;
			dispatchReady();
		}
		
		public function get preloadable() : IPreloadable {
			return _preloadable;
		}	
	}
}
