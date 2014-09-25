package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractImage;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractComboBoxItemRenderer 
	{
		function get text():String 
		
		function set text(value:String):void 
		
		function get data():Object 
		
		function set data(value:Object):void 
		
	}
	
}