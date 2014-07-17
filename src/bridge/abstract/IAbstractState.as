package bridge.abstract 
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Alex Popescu
	 * 
	 * A state is a display for the Bridge. There is only one active state at a time.
	 * <p>States are managed by the engine IEngine that manages the transitions between states and the current active state.</p>
	 * <p><b>Once the transition to a state is complete, the previous state is disposed and the memory is cleared</b></p>
	 * @see bridge.IEngine
	 */
	/**
	 * A state is a display for the Bridge. There is only one active state at a time.
	 */
	public interface IAbstractState extends IAbstractSprite 
	{
		/**
		 * Well what do you think this does?!
		 * @param	...rest
		 */
		function killAll (...rest) : void
	}
	
}