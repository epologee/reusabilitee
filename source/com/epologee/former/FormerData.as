package com.epologee.former {
	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	dynamic public class FormerData {
		public function toString():String {
			var list:Array = [];
			
			for (var prop : String in this) {
				list.push(prop+": "+this[prop]);
			}
			
			return "[FormerData \n\t\t"+list.join("\n\t\t")+"\n\t]";
		}
	}
}
