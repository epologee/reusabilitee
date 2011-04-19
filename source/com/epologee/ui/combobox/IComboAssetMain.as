package com.epologee.ui.combobox {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.IEventDispatcher;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public interface IComboAssetMain extends IEventDispatcher {
		function get label() : String;

		function set label(inLabel : String) : void;

		function get button() : MovieClip;

		function get shape() : Sprite;
		
		function clearRows() : void;

		function show() : void;

		function hide() : void;

		function addRow(inRow : IComboAssetRow) : void;
	}
}
