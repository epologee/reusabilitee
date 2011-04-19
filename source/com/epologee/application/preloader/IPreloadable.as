package com.epologee.application.preloader {

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public interface IPreloadable {
		function initialize(inCallback:Function) : void;
		function get bytesToPreload():Number;
		function get classReference() : Class;
	}
}
