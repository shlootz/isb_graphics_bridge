package bridge.abstract.events 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractSignalEvent
	{
		function set eventName(val:String):void
		function get eventName():String 
		
		function set engineEvent(val:Object):void
		function get engineEvent():Object 
		 
		function set params(val:Object):void
		function get params():Object
	}
	
}