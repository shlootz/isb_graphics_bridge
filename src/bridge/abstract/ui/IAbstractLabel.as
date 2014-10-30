package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractTextField;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Creates a label using a String. Main purpose is usage within buttons.
	 */
	public interface IAbstractLabel extends IAbstractSprite
	{
		 function updateLabel(text:String):void
		 
		 function get textField():IAbstractTextField
	}
	
}