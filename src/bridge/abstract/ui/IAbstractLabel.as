package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractTextField;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Creates a label using a String. Main purpose is usage within buttons.
	 */
	public interface IAbstractLabel extends IAbstractDisplayObjectContainer
	{
		 function updateLabel(text:String):void
		 
		 function get textField():IAbstractTextField
	}
	
}