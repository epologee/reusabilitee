package com.epologee.application.loaders {
	import flash.events.EventDispatcher;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	[Event(name="QUEUE_EMPTY", type="com.epologee.application.loaders.LoaderEvent")]
	[Event(name="COMPLETE", type="com.epologee.application.loaders.LoaderEvent")]
	[Event(name="ERROR", type="com.epologee.application.loaders.LoaderEvent")]
	//
	public class LoaderQueue extends EventDispatcher {
		private static const STATUS_READY : uint = 0;
		private static const STATUS_IN_PROGRESS : uint = 1;
		//
		private var _queue : Array;
		private var _status : uint;
		private var _autoStart : Boolean;
		private var _completed : Number;

		public function LoaderQueue(inAutoStart : Boolean = true) {
			inAutoStart = inAutoStart;
			_queue = [];
			_status = STATUS_READY;
			_completed = 0;
		}

		/**
		 * @param inName: is used to distinguish what request completes/fails/progresses etc.
		 * @param inURL: is the complete URL (may contain GET-parameters)
		 * @param inRequestData (optional): may contain several types of data. XML will be sent as raw request data. URLVariables will be passed as POST data. 
		 */
		public function addXMLRequest(inURL : String, inName : String = "", inPostData : * = null) : void {
			var item : XMLLoaderItem = new XMLLoaderItem(inURL);
			item.name = inName;

			if (inPostData is XML || inPostData is URLVariables) {
				item.method = URLRequestMethod.POST;
				item.request = inPostData;
			}

			_queue.push(item);
			loadNext();
		}

		public function addSWFRequest(inURL : String, inName : String = "") : void {
			var item : SWFLoaderItem = new SWFLoaderItem(inURL);
			item.name = inName;

			_queue.push(item);
			if (!_autoStart)
				return;
			loadNext();
		}

		public function addBMPRequest(inURL : String, inName : String = "") : void {
			var item : ImageLoaderItem = new ImageLoaderItem(inURL);
			item.name = inName;

			_queue.push(item);
			if (!_autoStart)
				return;
			loadNext();
		}

		public function addRequest(inLoaderItem : LoaderItem) : void {
			_queue.push(inLoaderItem);

			if (!_autoStart)
				return;
			loadNext();
		}

		public function start() : void {
			loadNext();
		}

		private function loadNext() : void {
			if (_queue.length == 0) {
				dispatchEvent(new LoaderEvent(LoaderEvent.QUEUE_EMPTY));
				return;
			}

			if (_status != STATUS_READY)
				return;

			_status = STATUS_IN_PROGRESS;

			var item : LoaderItem = _queue.shift() as LoaderItem;
			item.addEventListener(LoaderEvent.COMPLETE, handleComplete);
			item.addEventListener(LoaderEvent.ERROR, handleError);
			item.execute();
		}

		private function handleError(event : LoaderEvent) : void {
			dispatchEvent(event);
			_status = STATUS_READY;
			loadNext();
		}

		private function handleComplete(event : LoaderEvent) : void {
			dispatchEvent(event);

			_completed++;
			_status = STATUS_READY;
			loadNext();
		}

		public function get progress() : Number {
			if (!_queue.length)
				return 1;

			var chunkSize : Number = 1 / (_queue.length + _completed);

			var p : Number = _completed * chunkSize;

			for each (var item : LoaderItem in _queue) {
				p += item.progress * chunkSize;
			}

			return p;
		}
	}
}