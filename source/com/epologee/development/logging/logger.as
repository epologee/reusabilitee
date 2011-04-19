package com.epologee.development.logging {
	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 * 
	 * Assign any other ITraceable instance to this variable to enable your own custom logging.
	 */
	public var logger : ITraceable = new LogAll();
}
import logmeister.LogMeister;
import logmeister.NSLogMeister;

import com.epologee.development.logging.ITraceable;

class LogAll implements ITraceable {
	public function LogAll() {
	}

	public function critical(inMessage : * = "") : void {
		LogMeister.NSLogMeister::critical(inMessage);
	}

	public function debug(inMessage : * = "") : void {
		LogMeister.NSLogMeister::debug(inMessage);
	}

	public function error(inMessage : * = "") : void {
		LogMeister.NSLogMeister::error(inMessage);
	}

	public function fatal(inMessage : * = "") : void {
		LogMeister.NSLogMeister::fatal(inMessage);
	}

	public function info(inMessage : * = "") : void {
		LogMeister.NSLogMeister::info(inMessage);
	}

	public function notice(inMessage : * = "") : void {
		LogMeister.NSLogMeister::notice(inMessage);
	}

	public function warn(inMessage : * = "") : void {
		LogMeister.NSLogMeister::warn(inMessage);
	}
}
