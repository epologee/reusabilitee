package com.epologee.util.drawing {
	import flash.display.Shape;
	import flash.geom.Point;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class ShapeDrawings {
		public static function square(size : Number = 64, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : Shape {
			return Draw.square(new Shape(), size, color, alpha, centered);
		}

		public static function rectangle(width : Number = 64, height : Number = 32, color : uint = 0xFF9900, alpha : Number = 1, offset : * = null) : Shape {
			return Draw.rectangle(new Shape(), width, height, color, alpha, offset);
		}

		public static function window(width : Number = 64, height : Number = 32, thickness : Number = 4, color : uint = 0xFF9900, alpha : Number = 1, offset : Point = null) : Shape {
			return Draw.window(new Shape(), width, height, thickness, color, alpha, offset);
		}

		public static function windowCentered(width : Number = 64, height : Number = 32, thickness:Number = 4, color : uint = 0xFF9900, alpha : Number = 1) : Shape {
			return Draw.window(new Shape(), width, height, thickness, color, alpha, new Point(-width / 2, -height / 2));
		}

		public static function roundedRectangle(width : Number = 64, height : Number = 32, cornerRadius : Number = 4, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : Shape {
			return Draw.roundedRectangle(new Shape, width, height, cornerRadius, color, alpha, centered);
		}

		public static function circle(radius : Number = 64, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = true) : Shape {
			return Draw.circle(new Shape(), radius, color, alpha, centered);
		}

		public static function ellipse(width : Number = 64, height : Number = 32, color : uint = 0xFF9900, alpha : Number = 1, centered : Boolean = true) : Shape {
			return Draw.ellipse(new Shape(), width, height, color, alpha, centered);
		}
		
		public static function arrow(length : Number = 7, width : Number = 14, color : uint = 0xFF9900, alpha : Number = 1):Shape {
			return Draw.arrow(new Shape(), length, width, color, alpha);
		}
	}
}
