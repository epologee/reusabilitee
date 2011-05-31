package com.epologee.util.drawing {
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class SpriteDrawings {
		public static function square(size : Number = 64, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : Sprite {
			return Draw.square(new Sprite(), size, color, alpha, centered);
		}

		public static function rectangle(width : Number = 64, height : Number = 32, color : uint = 0xFF9900, alpha : Number = 1, offset : * = null) : Sprite {
			return Draw.rectangle(new Sprite(), width, height, color, alpha, offset);
		}

		public static function window(width : Number = 64, height : Number = 32, thickness : Number = 4, color : uint = 0xFF9900, alpha : Number = 1, offset : Point = null) : Sprite {
			return Draw.window(new Sprite(), width, height, thickness, color, alpha, offset);
		}

		public static function roundedRectangle(width : Number = 64, height : Number = 32, cornerRadius : Number = 4, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : Sprite {
			return Draw.roundedRectangle(new Sprite, width, height, cornerRadius, color, alpha, centered);
		}

		public static function circle(radius : Number = 64, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = true) : Sprite {
			return Draw.circle(new Sprite(), radius, color, alpha, centered);
		}

		public static function ellipse(width : Number = 64, height : Number = 32, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = true) : Sprite {
			return Draw.ellipse(new Sprite(), width, height, color, alpha, centered);
		}

		public static function arrow(length : Number = 7, width : Number = 14, color : uint = 0xFF9900, alpha : Number = 1):Sprite {
			return Draw.arrow(new Sprite(), length, width, color, alpha);
		}

		public static function check(size : Number = 7, taper:Number = 0, color : uint = 0xFF9900, alpha : Number = 1):Sprite {
			return Draw.check(new Sprite(), size, taper, color, alpha);
		}
	}
}
