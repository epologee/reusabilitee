package com.epologee.former {
	import flash.utils.Dictionary;

	/**
	 * @author epologee
	 */
	public class FormerGroup extends Former {
		public var _name : String;
		private var _groups : Dictionary;

		public function FormerGroup(inDataClass : Class = null, inName : String = "") {
			super(inDataClass);

			_name = inName;
			_isEnabled = false;
			_groups = new Dictionary();
		}

		public function get name() : String {
			return _name;
		}

		/**
		 * Will return a group with the supplied @param inName and create it if it doesn't exist. 
		 */
		public function getGroupByName(inGroupName : String) : Former {
			return _groups[inGroupName] ||= new FormerGroup(null, name);
		}

		public function enableGroup(inGroupName : String) : void {
			for each (var groupName : String in _groups) {
				var group : Former = _groups[groupName] as Former;
				if (groupName == inGroupName) {
					group.enable();
				} else {
					group.disable();
				}
			}
		}

		override public function get data() : Object {
			var d : Object = super.data;

			for each (var groupName : String in _groups) {
				Former(_groups[groupName]).mergeData(d);
			}
			
			return d;
		}
	}
}
