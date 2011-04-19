package com.epologee.former.input {
	import com.epologee.ui.buttons.IHasDisabledState;
	import com.epologee.ui.buttons.IHasSelectedState;

	import org.osflash.signals.Signal;
	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public interface IFormerRadioInput extends IFormerInput, IFormerErrorInput, IHasDisabledState, IHasSelectedState {
		// Cross package dependencies of this interface demand a new form setup in the next project!
		function get selected() : Signal;

		function set selected(inSignal : Signal) : void;
		
		function isSelected():Boolean;
	}
}
