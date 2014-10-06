package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractSprite;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractInputText extends IAbstractDisplayObject
	{
		function get text () : String;
		function set text (value:String) : void;
		function set restriction(val:String):void
		function set backgroundBitmap(val:Bitmap):void
	}
	
}