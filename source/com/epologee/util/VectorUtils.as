package com.epologee.util {
	/**
	 * @author epologee
	 */
	public class VectorUtils {
		public static function remove(list : *, deleteElement : *) : void {
			var leni : int = list.length;
			for (var i : int = 0; i < leni; i++) {
				if (list[i] == deleteElement) {
					list.splice(i, 1);
					return;
				}
			}
		}
	}
}
