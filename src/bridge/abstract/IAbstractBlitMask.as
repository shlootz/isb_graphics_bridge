package bridge.abstract 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Emulates the GreenSock blitmask. Enjoy.
	 */
	public interface IAbstractBlitMask 
	{
		 function addLayerOnTop(layer:IAbstractScrollTile):IAbstractScrollTile
		 
		 /**
		 * The horizontal scale factor. '1' means no scale, negative values flip the tiles.
		 */
		function get tilesScaleX():Number

		/**
		 * The horizontal scale factor. '1' means no scale, negative values flip the tiles.
		 */
		function set tilesScaleX(value:Number):void

		/**
		 * The vertical scale factor. '1' means no scale, negative values flip the tiles.
		 */
		function get tilesScaleY():Number

		/**
		 * The vertical scale factor. '1' means no scale, negative values flip the tiles.
		 */
		function set tilesScaleY(value:Number):void

		/**
		 * The x offet of the tiles.
		 */
		function get tilesOffsetX():Number

		/**
		 * The x offet of the tiles.
		 */
		function set tilesOffsetX (value:Number):void

		/**
		 * The y offet of the tiles.
		 */
		function get tilesOffsetY():Number

		/**
		 * The y offet of the tiles.
		 */
		function set tilesOffsetY(value:Number):void

		/**
		 * The rotation of the tiles in radians.
		 */
		function get tilesRotation():Number

		/**
		 * The rotation of the tiles in radians.
		 */
		function set tilesRotation (value:Number):void

		/**
		 * The x pivot for rotation and scale the tiles.
		 */
		function get tilesPivotX():Number

		/**
		 * The x pivot for rotation and scale the tiles.
		 */
		function set tilesPivotX (value:Number):void

		/**
		 * The y pivot for rotation and scale the tiles.
		 */
		function get tilesPivotY ():Number

		/**
		 * The y pivot for rotation and scale the tiles.
		 */
		function set tilesPivotY (value:Number):void

		/**
		 * Determinate parlax for offset.
		 */
		function get paralaxOffset():Boolean

		/**
		 * Determinate parlax for offset.
		 */
		function set paralaxOffset (value:Boolean):void

		/**
		 * Determinate parlax for scale.
		 */
		function get paralaxScale():Boolean

		/**
		 * Determinate parlax for scale.
		 */
		function set paralaxScale(value:Boolean):void
		
		/**
		 * Determinate parlax for all transformations.
		 */
		function get paralax():Boolean

		/**
		 * Determinate parlax for all transformations.
		 */
		function set paralax(value:Boolean):void 

		/**
		 * Avoid all tiles transformations - for better performance matrixes are not calculate.
		 */
		function get freez():Boolean

		/**
		 * Avoid all tiles transformations - for better performance matrixes are not calculate.
		 */
		function set freez(value:Boolean):void 

		/**
		 * Return number of layers
		 */
		function get numLayers():int

		/**
		 * The smoothing filter that is used for the texture.
		 */
		function get smoothing():String

		/**
		 * The smoothing filter that is used for the texture.
		 */
		function set smoothing (value:String):void

		/**
		 * Determinate mipmapping for the texture - default set to false to avoid borders artefacts.
		 */
		function get mipMapping():Boolean

		/**
		 * Determinate mipmapping for the texture - default set to false to avoid borders artefacts.
		 */
		function set mipMapping (value:Boolean):void 
		
	}
	
}