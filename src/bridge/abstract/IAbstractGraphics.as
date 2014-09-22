package bridge.abstract 
{
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractGraphics 
	{
		function clear():void
		function beginFill( color:uint, alpha:Number = 1.0 ):void
		function endFill():void
		function lineStyle( thickness:Number = NaN, color:uint = 0, alpha:Number = 1.0 ):void
		function moveTo( x:Number, y:Number ):void
		function lineTo( x:Number, y:Number ):void
		function curveTo( cx:Number, cy:Number, a2x:Number, a2y:Number, error:Number = 0.75):void
		function cubicCurveTo( c1x:Number, c1y:Number, c2x:Number, c2y:Number, a2x:Number, a2y:Number, error:Number = 0.75):void
		function drawCircle( x:Number, y:Number, radius:Number ):void
		function drawEllipse( x:Number, y:Number, width:Number, height:Number ):void
		function drawRect( x:Number, y:Number, width:Number, height:Number ):void
		function drawRoundRect( x:Number, y:Number, width:Number, height:Number, radius:Number ):void
		function drawRoundRectComplex( x:Number, y:Number, width:Number, height:Number, 
											  topLeftRadius:Number, topRightRadius:Number, 
											  bottomLeftRadius:Number, bottomRightRadius:Number ):void
		 function set precisionHitTest(value:Boolean):void
		 function get precisionHitTest():Boolean 
		 function set precisionHitTestDistance(value:Number):void
		 function get precisionHitTestDistance() : Number
		 function beginGradientFill(gradientType:String, colours:Array, alphaValues:Array, ratio:Array):void
		 function drawLineTexture(thickness:Number, texture:Bitmap):void
		 function updateLineTexture(newTexture:Bitmap):void
		 function animateTexture(uSpeed:Number, vSpeed:Number, thickness:Number, texture:Bitmap):void
		 function updateAnimateTexture(newTexture:Bitmap):void
	}
	
}