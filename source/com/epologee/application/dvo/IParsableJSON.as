package com.epologee.application.dvo {
	/**
	 * @author epologee
	 */
	public interface IParsableJSON extends IDataValueObject {
		function parseJSON(data:*) : void;
	}
}
