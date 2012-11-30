package com.epologee.util.drawing {
	import flash.display.Graphics;
	import flash.geom.Point;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class Draw {
		public static const NO_COLOR : int = -1;
		public static const CENTER : String = "CENTER";
		public static const NO_OFFSET : Point = new Point();

		public static function square(canvas : *, size : Number = 64, color : int = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawRect(centered ? -size / 2 : 0, centered ? -size / 2 : 0, size, size);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function rectangle(canvas : *, width : Number = 64, height : Number = 32, color : int = 0xFF9900, alpha : Number = 1, offset : * = null) : * {
			if (!canvas || !canvas.graphics)
				return null;

			if (offset == CENTER)
				offset = new Point(-width / 2, height / 2);
			if (!(offset is Point))
				offset = NO_OFFSET;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawRect(offset.x, offset.y, width, height);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function window(canvas : *, width : Number = 64, height : Number = 32, thickness : Number = 4, color : int = 0xFF9900, alpha : Number = 1, offset : Point = null) : * {
			if (!canvas || !canvas.graphics)
				return null;

			offset ||= new Point();

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawRect(offset.x, offset.y, width, height);
			g.drawRect(thickness + offset.x, thickness + offset.y, width - thickness * 2, height - thickness * 2);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function roundedWindow(canvas : *, width : Number = 64, height : Number = 32, thickness : Number = 4, cornerRadius : Number = 4, color : int = 0xFF9900, alpha : Number = 1, offset : Point = null) : * {
			if (!canvas || !canvas.graphics)
				return null;

			offset ||= new Point();

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawRoundRect(offset.x, offset.y, width, height, cornerRadius * 2, cornerRadius * 2);
			g.drawRoundRect(thickness + offset.x, thickness + offset.y, width - thickness * 2, height - thickness * 2, cornerRadius * 2, cornerRadius * 2);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function roundedRectangle(canvas : *, width : Number = 64, height : Number = 32, cornerRadius : Number = 4, color : int = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawRoundRect(centered ? -width / 2 : 0, centered ? -height / 2 : 0, width, height, cornerRadius * 2, cornerRadius * 2);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function circle(canvas : *, inRadius : Number = 16, color : int = 0xFF9900, alpha : Number = 1, centered : Boolean = true) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawCircle(centered ? 0 : inRadius, centered ? 0 : inRadius, inRadius);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function ring(canvas : *, inRadius : Number = 16, thickness : Number = 4, color : int = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawCircle(centered ? 0 : inRadius, centered ? 0 : inRadius, inRadius);
			g.drawCircle(centered ? 0 : inRadius, centered ? 0 : inRadius, inRadius - thickness);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function ellipse(canvas : *, width : Number = 64, height : Number = 32, color : int = 0xFF9900, alpha : Number = 1, centered : Boolean = false) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.drawEllipse(centered ? -width / 2 : 0, centered ? -height / 2 : 0, width, height);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function polygon(canvas : *, inPoints : Array, color : int = 0xFF9900, alpha : Number = 1) : * {
			if (!canvas || !canvas.graphics)
				return null;

			if (!inPoints || inPoints.length < 3)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			var started : Boolean = false;
			for each (var o : Object in inPoints) {
				if (o is Array) o = new Point(o[0], o[1]);

				if (!started) {
					g.moveTo(o.x, o.y);
					started = true;
				} else {
					g.lineTo(o.x, o.y);
				}
			}

			// close polygon
			g.lineTo(inPoints[0].x, inPoints[0].y);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function arrow(canvas : *, length : Number = 7, width : Number = 14, color : int = 0xFF9900, alpha : Number = 1, offset : Point = null) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			offset ||= new Point(0, 0);

			g.moveTo(-length / 2 + offset.x, offset.y - width / 2);
			g.lineTo(length / 2 + offset.x, offset.y);
			g.lineTo(-length / 2 + offset.x, offset.y + width / 2);
			g.lineTo(-length / 2 + offset.x, offset.y - width / 2);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function check(canvas : *, size : Number = 7, taper : Number = 0, color : int = 0xFF9900, alpha : Number = 1) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.beginFill(color, alpha);
			}

			g.lineTo(size, -size);
			g.lineTo(size, -size + taper);
			g.lineTo(0, size / 2);
			g.lineTo(-size / 2, -size / 2 + taper);
			g.lineTo(-size / 2, -size / 2);
			g.lineTo(0, 0);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function cross(canvas : *, width : Number = 7, height : Number = 7, thickness : Number = 1, color : int = 0x000000, alpha : Number = 1) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;

			if (color != NO_COLOR) {
				g.lineStyle(thickness, color, alpha);
				g.beginFill(color, alpha);
			}
			
			g.lineTo(0, 0);
			g.lineTo(width, height);
			g.moveTo(width, 0);
			g.lineTo(0, height);

			if (color != NO_COLOR) {
				g.endFill();
			}

			return canvas;
		}

		public static function plus(canvas : *, width : Number = 7, height : Number = 7, thickness : Number = 1, color : int = 0x000000, alpha : Number = 1) : * {
			if (!canvas || !canvas.graphics)
				return null;

			var g : Graphics = canvas.graphics;
			g.lineStyle(thickness, color, alpha);
			g.beginFill(color, alpha);
			g.moveTo(width / 2, thickness / 2);
			g.lineTo(width / 2, height);
			g.moveTo(thickness / 2, height / 2);
			g.lineTo(width, height / 2);
			g.endFill();

			return canvas;
		}

		/**
		 * Clear the graphics of an untyped object.
		 */
		public static function clear(...canvases : Array) : void {
			try {
				for each (var subcanvas : * in canvases) {
					subcanvas.graphics.clear();
				}
			} catch (ei : Error) {
				error("[i]: " + ei.message);
			}
		}

		public static function lineStyle(canvas : *, thickness : Number = 1, color : int = 0x000000, alpha : Number = 1, pixelHinting : Boolean = false) : void {
			canvas.graphics.lineStyle(thickness, color, alpha, pixelHinting);
		}

		public static function beginFill(canvas : *, color : uint = 0xFF9900, alpha : Number = 1.0) : void {
			canvas.graphics.beginFill(color, alpha);
		}

		public static function endFill(canvas : *) : void {
			canvas.graphics.endFill();
		}
	}
}
