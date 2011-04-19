package com.epologee.util {
	import com.epologee.development.logging.logger;

	import flash.display.Stage;
	import flash.events.KeyboardEvent;
	import flash.utils.getQualifiedClassName;

	/**	 * @author Eric-Paul Lecluse | epologee.com � 2008	 */
	public class EasterBunny {
		private static const INSTANCE : EasterBunny = new EasterBunny();
		private var mStrokes : Array;
		private var mEggs : Array;

		public static function getInstance() : EasterBunny {
			return INSTANCE;
		}

		public static function setStage(inStage : Stage) : void {
			inStage.addEventListener(KeyboardEvent.KEY_DOWN, getInstance().handleKeyDown);
		}

		public static function addEgg(inKeyStroke : String, inDelegate : Function, ...inArguments : Array) : void {
			getInstance().createEgg(inKeyStroke, inDelegate, inArguments);
		}

		public function EasterBunny() {
			if (INSTANCE) throw new Error("private singleton: use EasterBunny.addEgg()");
			mStrokes = [];
			mEggs = [];
			createEgg("hello", logger.fatal, ["EasterBunny says: Hello World!"]);
		}

		private function createEgg(inKeyStroke : String, inDelegate : Function, inArguments : Array) : void {
			var egg : Object = new Object();
			egg.keyStroke = inKeyStroke;
			egg.delegate = inDelegate;
			egg.args = inArguments;
			// ((inArguments is Array || inArguments == null) ? inArguments : [inArguments]);
			mEggs.push(egg);
		}

		private function handleKeyDown(event : KeyboardEvent) : void {
			mStrokes.push(String.fromCharCode(event.charCode));
			mStrokes = mStrokes.slice(-32);
			var leni : int = mEggs.length;
			for (var i : int = 0;i < leni;i++) {
				var egg : Object = mEggs[i];
				var stroke : String = egg.keyStroke;
				if (stroke.length) {
					var recorded : String = mStrokes.slice(-stroke.length).join("");
					if (stroke == recorded) {
						var delegate : Function = egg.delegate as Function;
						var args : Array = egg.args as Array;
						try {
							if (args) {
								delegate.apply(null, egg.args);
							} else {
								delegate.apply(null);
							}
						} catch (e : Error) {
							logger.error(e.message);
						}
						return;
					}
				}
			}
		}

		public function toString() : String {
			// com.epologee.util.EasterBunny
			return getQualifiedClassName(this);
		}
	}
}