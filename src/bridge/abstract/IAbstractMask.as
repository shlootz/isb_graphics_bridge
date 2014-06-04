package bridge.abstract 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractMask extends IAbstractDisplayObjectContainer
	{
		/**
		 * 
		 */
		function get isAnimated():Boolean
		
		/**
		 * 
		 */
		function set isAnimated(value:Boolean):void

		/**
		 * 
		 */
		function get inverted():Boolean
		
		/**
		 * 
		 */
		function set inverted(value:Boolean):void
		
		/**
		 * 
		 */
		function set newMask(mask:IAbstractDisplayObject) : void
	}
	
}