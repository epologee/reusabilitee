package com.epologee.util.drawing {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Point;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class Draw {
		public static const NO_COLOR : int = -1;
		public static const CENTER : String = "CENTER";
		public static const NO_OFFSET : Point = new Point();

		public static function square(inCanvas : *, inSize : Number = 64, inColor : int = 0xFF9900, inAlpha : Number = 1, inCentered : Boolean = false) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.drawRect(inCentered ? -inSize / 2 : 0, inCentered ? -inSize / 2 : 0, inSize, inSize);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function rectangle(inCanvas : *, inWidth : Number = 64, inHeight : Number = 32, inColor : int = 0xFF9900, inAlpha : Number = 1, inOffset : * = null) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			if (inOffset == CENTER)
				inOffset = new Point(-inWidth / 2, inHeight / 2);
			if (!(inOffset is Point))
				inOffset = NO_OFFSET;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.drawRect(inOffset.x, inOffset.y, inWidth, inHeight);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function window(inCanvas : *, inWidth : Number = 64, inHeight : Number = 32, inThickness : Number = 4, inColor : int = 0xFF9900, inAlpha : Number = 1, inCentered : Boolean = false) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.drawRect(inCentered ? -inWidth / 2 : 0, inCentered ? -inHeight / 2 : 0, inWidth, inHeight);
			g.drawRect(inThickness + (inCentered ? -inWidth / 2 : 0), inThickness + (inCentered ? -inHeight / 2 : 0), inWidth - inThickness * 2, inHeight - inThickness * 2);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function roundedRectangle(inCanvas : *, inWidth : Number = 64, inHeight : Number = 32, inCornerRadius : Number = 4, inColor : int = 0xFF9900, inAlpha : Number = 1, inCentered : Boolean = false) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.drawRoundRect(inCentered ? -inWidth / 2 : 0, inCentered ? -inHeight / 2 : 0, inWidth, inHeight, inCornerRadius * 2, inCornerRadius * 2);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function circle(inCanvas : *, inRadius : Number = 16, inColor : int = 0xFF9900, inAlpha : Number = 1, inCentered : Boolean = false) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.drawCircle(inCentered ? 0 : inRadius, inCentered ? 0 : inRadius, inRadius);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function ring(inCanvas : *, inRadius : Number = 16, inThickness : Number = 4, inColor : int = 0xFF9900, inAlpha : Number = 1, inCentered : Boolean = false) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.drawCircle(inCentered ? 0 : inRadius, inCentered ? 0 : inRadius, inRadius);
			g.drawCircle(inCentered ? 0 : inRadius, inCentered ? 0 : inRadius, inRadius - inThickness);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function ellipse(inCanvas : *, inWidth : Number = 64, inHeight : Number = 32, inColor : int = 0xFF9900, inAlpha : Number = 1, inCentered : Boolean = false) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.drawEllipse(inCentered ? -inWidth / 2 : 0, inCentered ? -inHeight / 2 : 0, inWidth, inHeight);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function polygon(inCanvas : *, inPoints : Array, inColor : int = 0xFF9900, inAlpha : Number = 1) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			if (!inPoints || inPoints.length < 3)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
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

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function arrow(inCanvas : *, inLength : Number = 7, inWidth : Number = 14, inColor : int = 0xFF9900, inAlpha : Number = 1, inOffset : Point = null) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			var offset : Point = inOffset || new Point(0, 0);

			g.moveTo(-inLength / 2 + offset.x, offset.y - inWidth / 2);
			g.lineTo(inLength / 2 + offset.x, offset.y);
			g.lineTo(-inLength / 2 + offset.x, offset.y + inWidth / 2);
			g.lineTo(-inLength / 2 + offset.x, offset.y - inWidth / 2);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function check(inCanvas : *, inSize : Number = 7, inTaper : Number = 0, inColor : int = 0xFF9900, inAlpha : Number = 1) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;

			if (inColor != NO_COLOR) {
				g.beginFill(inColor, inAlpha);
			}

			g.lineTo(inSize, -inSize);
			g.lineTo(inSize, -inSize + inTaper);
			g.lineTo(0, inSize / 2);
			g.lineTo(-inSize / 2, -inSize / 2 + inTaper);
			g.lineTo(-inSize / 2, -inSize / 2);
			g.lineTo(0, 0);

			if (inColor != NO_COLOR) {
				g.endFill();
			}

			return inCanvas;
		}

		public static function cross(inCanvas : *, inWidth : Number = 7, inHeight : Number = 7, inThickness : Number = 1, inColor : int = 0x000000, inAlpha : Number = 1) : * {
			if (!inCanvas || !inCanvas.graphics)
				return null;

			var g : Graphics = inCanvas.graphics;
			g.lineStyle(inThickness, inColor, inAlpha);
			g.beginFill(inColor, inAlpha);
			g.lineTo(0, 0);
			g.lineTo(inWidth, inHeight);
			g.moveTo(inWidth, 0);
			g.lineTo(0, inHeight);
			g.endFill();

			return inCanvas;
		}
		
		/**
		 * Clear the graphics of an untyped object.
		 */
		public static function clear(inCanvas : *) : void {
			inCanvas.graphics.clear();
		}

		public static function lineStyle(inCanvas : Shape, inThickness : Number = 1, inColor : int = 0x000000, inAlpha : Number = 1, inPixelHinting : Boolean = false) : void {
			inCanvas.graphics.lineStyle(inThickness, inColor, inAlpha, inPixelHinting);
		}
	}
}
