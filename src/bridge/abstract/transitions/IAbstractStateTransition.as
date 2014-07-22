package bridge.abstract.transitions 
{
	import bridge.abstract.IAbstractDisplayObject;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Generic Transition between states that uses a custom animation and custom completion.
	 */
	public interface IAbstractStateTransition 
	{
		/**
		 * 
		 * @param	object1
		 * @param	object2
		 */
		function doTransition(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		
		/**
		 * 
		 * @param	func
		 */
		function injectAnimation(func:Function):void
		
		/**
		 * INTERNAL USE ONLY
		 * @param	fct
		 */
		function injectOnTransitionComplete(fct:Function):void
		
		/**
		 * Call this function at the end of a transition animation
		 * @param	object1
		 * @param	object2
		 * @param	customParams
		 */
		function onTransitionComplete(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject, customParams:Object = null):void
	}
	
}