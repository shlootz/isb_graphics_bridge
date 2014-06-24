package bridge.abstract.filters 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractBlurFilter 
	{
		function set blurX(val:Number):void
		
		function get blurX():Number
		
		function set blurY(val:Number):void
		
		function get blurY():Number
		
		function set resolution(val:Number):void
	
		function get resolution():Number
		
	}
	
}