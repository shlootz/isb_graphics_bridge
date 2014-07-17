package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractImage;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Contains all the logic of a Button.
	 */
	public interface IAbstractToggle extends IAbstractButton
	{
		/**
			 * 
			 * @param	val
			 */
			function toggle(val:Boolean):void
			
			/**
			 * 
			 */
			function get state():Boolean
			
			/**
			 * 
			 */
			function set toggleTrueImage(val:IAbstractImage):void
			
			/**
			 * 
			 */
			function set toggleFalseImage(val:IAbstractImage):void
		
	}

}