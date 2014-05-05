package bridge.abstract 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * The IAnimatable interface describes objects that are animated depending on the passed time. 
	 * Any object that implements this interface can be added to a juggler.
	 * 
	 *   <p>When an object should no longer be animated, it has to be removed from the juggler. 
	 * To do this, you can manually remove it via the method <codeph>juggler.remove(object)</codeph>,
	 * or the object can request to be removed by dispatching a Starling event with the type
	 * <codeph>Event.REMOVE_FROM_JUGGLER</codeph>. The "Tween" class is an example of a class that
	 * dispatches such an event; you don't have to remove tweens manually from the juggler.</p>
	 */
	public interface IAbstractAnimatable 
	{
		/**
		 * Advance the time by a number of seconds.
		 * @param	time	in seconds.
		 */
		function advanceTime (time:Number) : void;
	}
	
}