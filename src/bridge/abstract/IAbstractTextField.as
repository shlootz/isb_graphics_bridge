package bridge.abstract 
{
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Creates a new text field.
	 */
	public interface IAbstractTextField
	{
		/**
		 * Indicates whether the font size is scaled down so that the complete text fits
		 * into the text field.
		 */
		function get autoScale () : Boolean;
		function set autoScale (value:Boolean) : void;

		/**
		 * Specifies the type of auto-sizing the TextField will do.
		 * Note that any auto-sizing will make auto-scaling useless. Furthermore, it has 
		 * implications on alignment: horizontally auto-sized text will always be left-, 
		 * vertically auto-sized text will always be top-aligned.
		 */
		function get autoSize () : String;
		function set autoSize (value:String) : void;

		/**
		 * Indicates if TextField should be batched on rendering. This works only with bitmap
		 * fonts, and it makes sense only for TextFields with no more than 10-15 characters.
		 * Otherwise, the CPU costs will exceed any gains you get from avoiding the additional
		 * draw call.
		 */
		function get batchable () : Boolean;
		function set batchable (value:Boolean) : void;

		/// Indicates whether the text is bold.
		function get bold () : Boolean;
		function set bold (value:Boolean) : void;

		/// Draws a border around the edges of the text field. Useful for visual debugging.
		function get border () : Boolean;
		function set border (value:Boolean) : void;

		/**
		 * The color of the text. For bitmap fonts, use Color.WHITE to use the
		 * original, untinted color.
		 */
		function get color () : uint;
		function set color (value:uint) : void;

		/// The name of the font (true type or bitmap font).
		function get fontName () : String;
		function set fontName (value:String) : void;

		/**
		 * The size of the font. For bitmap fonts, use BitmapFont.NATIVE_SIZE for 
		 * the original size.
		 */
		function get fontSize () : Number;
		function set fontSize (value:Number) : void;

		/// The horizontal alignment of the text.
		function get hAlign () : String;
		function set hAlign (value:String) : void;

		/// The height of the object in pixels.
		function set height (value:Number) : void;

		/// Indicates whether the text is italicized.
		function get italic () : Boolean;
		function set italic (value:Boolean) : void;

		/// Indicates whether kerning is enabled.
		function get kerning () : Boolean;
		function set kerning (value:Boolean) : void;

		/**
		 * The native Flash BitmapFilters to apply to this TextField. 
		 * Only available when using standard (TrueType) fonts!
		 */
		function get nativeFilters () : Array;
		function set nativeFilters (value:Array) : void;

		/// The displayed text.
		function get text () : String;
		function set text (value:String) : void;

		/// Returns the bounds of the text within the text field.
		function get textBounds () : flash.geom.Rectangle;

		/// Indicates whether the text is underlined.
		function get underline () : Boolean;
		function set underline (value:Boolean) : void;

		/// The vertical alignment of the text.
		function get vAlign () : String;
		function set vAlign (value:String) : void;

		/// The width of the object in pixels.
		function set width (value:Number) : void;

		/// Disposes the underlying texture data.
		function dispose () : void;
		
		/**
		 * Forces the text field to be constructed right away. Normally, 
		 * it will only do so lazily, i.e. before being rendered.
		 */
		function redraw () : void;
	}

}