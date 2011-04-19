package com.epologee.ui.text {
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class FormattedInputField extends FormattedTextField {
		public function FormattedInputField(font : String, fontSize : Number = 12, color : uint = 0x000000, bold : Boolean = false, italic : Object = false) {
			super(font, fontSize, color, bold, italic);

			autoSize = TextFieldAutoSize.NONE;
			width = 100;
			height = fontSize + 6 + leading;
			
			enable();
		}

		public function disable() : void {
			selectable = false;
			type = TextFieldType.DYNAMIC;
		}

		public function enable() : void {
			selectable = true;
			type = TextFieldType.INPUT;
		}
	}
}
