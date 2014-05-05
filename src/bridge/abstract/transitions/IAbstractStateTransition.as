package bridge.abstract.transitions 
{
	import bridge.abstract.IAbstractDisplayObject;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractStateTransition 
	{
		function doTransition(object1:IAbstractDisplayObject, object2:IAbstractDisplayObject):void
		function injectOnTransitionComplete(fct:Function):void
	}
	
}