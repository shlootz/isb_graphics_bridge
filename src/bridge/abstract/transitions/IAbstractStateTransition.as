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
		function doTransition(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		function injectAnimation(func:Function):void
		function injectOnTransitionComplete(fct:Function):void
		function onTransitionComplete(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
	}
	
}