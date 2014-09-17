package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractSprite;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractComboBox extends IAbstractSprite
	{
		function get currentSelection():String
		
		function get currentSelectedIData():Object
		
		function addItem(item:IAbstractComboBoxItemRenderer):void
		
		function removeItem(item:IAbstractComboBoxItemRenderer):void
		
		function clearList():void
	}
	
}