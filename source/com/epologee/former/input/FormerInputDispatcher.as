package com.epologee.former.input {
	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class FormerInputDispatcher {
		private var _input : IFormerInput;
		public function FormerInputDispatcher(inInput : IFormerInput) {
			_input = inInput;
		}

		public function dispatchValueChanged() : void {
			_input.dispatchEvent(new FormerInputEvent(FormerInputEvent.VALUE_CHANGED));
		}
	}
}
