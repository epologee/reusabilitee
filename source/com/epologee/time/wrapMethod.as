package com.epologee.time {
	public function wrapMethod(callback : Function, ...params : Array) : Function {
		return new WrappedCall(callback, params).execute;
	}
}
import com.epologee.development.logging.logger;

import org.osflash.signals.SignalBinding;

class WrappedCall {
	private var _callback : Function;
	private var _parameters : Array;
	private var _stack : String;

	/**
	 * Stores a call for later execution.
	 * @param callback: the callback function to be called when done waiting
	 * @param params: list of parameters to pass to the callback function
	 */
	public function WrappedCall(callback : Function, params : Array) {
		_stack = new Error().getStackTrace();
		_callback = callback;
		_parameters = params;
	}

	public function execute(...ignoreParameters : Array) : void {
		SignalBinding.throwArgumentLengthError = false;
		if (_parameters == null) {
			try {
				_callback();
			} catch(e : Error) {
				logger.error("Wrapped method error (no arguments): " + e.message + (_stack ? "\n" + _stack.split("\n").slice(2).join("\n") : ""));
			}
		} else {
			try {
				_callback.apply(null, _parameters);
			} catch(e : Error) {
				logger.error("Wrapped method error (with arguments): " + e.message + "\n" +e.getStackTrace() +"\n\n"+ (_stack ? "\n" + _stack.split("\n").slice(2).join("\n") : ""));
			}
		}
		SignalBinding.throwArgumentLengthError = true;

		die();
	}

	/**
	Release reference to creating object.
	Use this to remove a TimeDelay object that is still running when the creating object will be removed.
	 */
	public function die() : void {
		_callback = null;
		_parameters = null;
		_stack = null;
	}
}