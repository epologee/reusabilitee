package com.epologee.security {
	import flash.utils.getQualifiedClassName;

	/**
	 * @author Eric-Paul Lecluse | epologee.com � 2009
	 */
	public class ChecksumGenerator {
		private var _key : String;

		public function ChecksumGenerator(inSecretKey : String) {
			_key = inSecretKey;
		}

		public function getChecksum(...inParams:Array) : String {
			// return MD5.hash(inParams.join("")+_key);
			return "Needs an MD5 library";
		}
		
		public function toString():String {
			// com.epologee.security.ChecksumGenerator
			var s:String = "";
			// s = "[ " + name + " ]:";
			return s+getQualifiedClassName(this);
		}
	}
}