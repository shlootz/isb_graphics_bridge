package  bridge
{
	import bridge.abstract.IAbstractEngine;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractState;
	import bridge.abstract.IAbstractTexture;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	/**
	 * ...
	 * @author Alex Popescu
	 * 
	 * IEngine interface contains only the tight coupled methods.
	 * All the generic methods are in the IAbstractEngine
	 * <p>In order to implement a new graphics engine, follow these steps:
	 * <li>build an IEngine containing the coupled methods</li> 
	 * <li>extend the IAbstractEngine</li> 
	 * <li>build the business logig implementing IEngine</li> 
	 * </p>
	 * @see bridge.abstract.IAbstractEngine
	 */
	public interface IEngine extends IAbstractEngine
	{
		//add custom IEngine behaviour here. 
		//moved to IAbstractEngine
	}
	
}