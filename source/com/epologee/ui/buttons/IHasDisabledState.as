package com.epologee.ui.buttons {

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public interface IHasDisabledState extends IHasDrawnStates, IEnableDisable {
		function drawDisabledState() : void;
	}
}
