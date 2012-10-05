package com.epologee.designer {
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author Eric-Paul Lecluse (c) epologee.com
	 */
	public class Designer extends Sprite {
		public static const ALIGN_LEFT : String = "ALIGN_LEFT";
		public static const ALIGN_RIGHT : String = "ALIGN_RIGHT";
		public var pixelSnapping : Boolean = false;
		//
		private var _spacing : Point;
		private var _origin : Point;
		private var _offset : Point;
		private var _maxWidth : Number;

		public function Designer(originX : Number = 10, originY : Number = 10, spacingX : Number = 10, spacingY : Number = 10, maxWidth : Number = 0) {
			_origin = new Point(originX, originY);
			_spacing = new Point(spacingX, spacingY);
			_offset = new Point(0, 0);
			_maxWidth = maxWidth;
		}

		public function addRow(...rowElements : Array) : void {
			addRowAt(rowElements);
		}

		public function addRowBehind(...rowElements : Array) : void {
			addRowAt(rowElements, 0);
		}

		public function addRowAligned(align : String, alignWidth : Number, ...rowElements : Array) : void {
			addRowAt(rowElements, NaN, align, alignWidth);
		}

		private function addRowAt(rowElements : Array, depth : Number = NaN, align : String = ALIGN_LEFT, alignWidth : Number = 0) : void {
			var width : Number = 0;
			var height : Number = 0;
			var obj : *;

			for each (obj in rowElements) {
				width += obj.width + _spacing.x;
				height = Math.max(obj.height, height);

				if (obj is Space) {
					_offset.x += obj.width + _spacing.x;
				} else {
					var displayObj : DisplayObject = DisplayObject(obj);
					displayObj.x = nextX;
					displayObj.y = nextY;
					if (isNaN(depth)) {
						addChild(displayObj);
					} else {
						addChildAt(displayObj, depth);
					}

					_offset.x += displayObj.width + _spacing.x;
				}
			}

			switch(align) {
				case ALIGN_RIGHT:
					for each (obj in rowElements) {
						if (obj is DisplayObject) {
							obj.x += (alignWidth - width);
						}
					}
					break;
				default:
			}

			_offset.x = 0;
			_offset.y += height + _spacing.y;
		}

		public function reset(inOriginX : Number = NaN, inOriginY : Number = NaN, inSpacingX : Number = NaN, inSpacingY : Number = NaN) : void {
			_origin.x = isNaN(inOriginX) ? _origin.x : inOriginX;
			_origin.y = isNaN(inOriginY) ? _origin.y : inOriginY;

			_spacing.x = isNaN(inSpacingX) ? _spacing.x : inSpacingX;
			_spacing.y = isNaN(inSpacingY) ? _spacing.y : inSpacingY;

			_offset.x = 0;
			_offset.y = 0;
		}

		public function get spacingX() : Number {
			return _spacing.x;
		}

		public function set spacingX(inPixels : Number) : void {
			_spacing.x = inPixels;
		}

		public function get spacingY() : Number {
			return _spacing.y;
		}

		public function set spacingY(inPixels : Number) : void {
			_spacing.y = inPixels;
		}

		public function get nextX() : Number {
			if (pixelSnapping) return Math.round(_origin.x + _offset.x);
			return _origin.x + _offset.x;
		}

		public function get nextY() : Number {
			if (pixelSnapping) return Math.round(_origin.y + _offset.y);
			return _origin.y + _offset.y;
		}
	}
}
