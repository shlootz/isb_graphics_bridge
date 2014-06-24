package bridge.abstract.filters 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractGlowFilter 
	{
		function set color(val:uint):void
		
		function get color():uint
		
		function set alpha(val:Number):void
		
		function get alpha():Number
		
		function set blur(val:Number):void
		
		function get blur():Number
		
		function set resolution(val:Number):void
		
		function get resolution():Number
		
	}
	
}