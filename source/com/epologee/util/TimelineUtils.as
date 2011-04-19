package com.epologee.util {
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**	 * @author Eric-Paul Lecluse | epologee.com (c) 2009	 */
	public class TimelineUtils {
		public static function reparentSprite(inNewClip : Sprite, inTimelineClip : Sprite) : void {
			var parent : DisplayObjectContainer = inTimelineClip.parent;
			if (parent) {
				var index : Number = parent.getChildIndex(inTimelineClip);
				inNewClip.x = inTimelineClip.x;
				inTimelineClip.x = 0;
				inNewClip.y = inTimelineClip.y;
				inTimelineClip.y = 0;
				inNewClip.rotation = inTimelineClip.rotation;
				inTimelineClip.rotation = 0;
				inNewClip.scaleX = inTimelineClip.scaleX;
				inTimelineClip.scaleX = 1;
				inNewClip.scaleY = inTimelineClip.scaleY;
				inTimelineClip.scaleY = 1;
				inNewClip.name = inTimelineClip.name;
				parent.addChildAt(inNewClip, index);
			}
			inNewClip.addChild(inTimelineClip);
		}

		/**
		 * Clean the MovieClip (removes its children)
		 * @param inMovieClip
		 * @return MovieClip
		 */
		public static function clean(inSprite : Sprite) : Sprite {
			var i : int = inSprite.numChildren;
			while ( i-- ) inSprite.removeChildAt(i);
			return inSprite;
		}

		public static function centerToStage(inDisplayObject : DisplayObject, inStage : Stage, inCenterAnchorOnly : Boolean = false) : void {
			inDisplayObject.x = inStage.stageWidth / 2 - (inCenterAnchorOnly ? 0 : inDisplayObject.width / 2);
			inDisplayObject.y = inStage.stageHeight / 2 - (inCenterAnchorOnly ? 0 : inDisplayObject.height / 2);
		}

		public static function getVisibleBounds(source : DisplayObject) : Rectangle {
			try {
				var data : BitmapData = new BitmapData(source.width, source.height, true, 0x00000000);
				data.draw(source);
				var bounds : Rectangle = data.getColorBoundsRect(0xFFFFFFFF, 0x000000, false);
				data.dispose();
				return bounds;
			} catch(e : Error) {
			}
			return source.getBounds(source.parent);
		}

		/**         * Similar to LocalToGlobal but instead it converts from local to local         */
		public static function localToLocal(containerFrom : DisplayObject, containerTo : DisplayObject, origin : Point = null) : Point {
			var point : Point = origin ? origin : new Point();
			point = containerFrom.localToGlobal(point);
			point = containerTo.globalToLocal(point);
			return point;
		}

		public static function centerToDimensions(inTarget : DisplayObject, inToWidth : Number, inToHeight : Number, inCenterAnchorOnly : Boolean = false) : void {
			inTarget.x = inToWidth / 2 - (inCenterAnchorOnly ? 0 : inTarget.width / 2);
			inTarget.y = inToHeight / 2 - (inCenterAnchorOnly ? 0 : inTarget.height / 2);
		}

		public static function alignCenter(inTargetObject : DisplayObject, inAlignToObject : DisplayObject) : void {
			inTargetObject.x = inAlignToObject.x + inAlignToObject.width / 2 - inTargetObject.width / 2;
			inTargetObject.y = inAlignToObject.y + inAlignToObject.height / 2 - inTargetObject.height / 2;
		}

		public static function gotoPercentage(inTimeline : MovieClip, inPercentage : Number) : void {
			var frame : uint = Math.floor(inPercentage * (inTimeline.totalFrames - 1) + 1);
			inTimeline.gotoAndStop(frame);
		}

		public static function mouseEnabled(inInteractiveObjectList : Array, inEnabled : Boolean = true) : void {
			var i : uint;
			var leni : uint = inInteractiveObjectList.length;
			for (i = 0;i < leni; i++) {
				InteractiveObject(inInteractiveObjectList[i]).mouseEnabled = inEnabled;
			}
		}

		public static function testMouseHit(inStage : Stage) : Boolean {
			if (0 <= inStage.mouseX && inStage.mouseY <= inStage.stageHeight) {
				if (0 <= inStage.mouseY && inStage.mouseY <= inStage.stageHeight) {
					return true;
				}
			}
			return false;
		}
	}
}