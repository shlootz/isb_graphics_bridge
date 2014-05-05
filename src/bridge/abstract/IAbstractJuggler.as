package bridge.abstract 
{
	
	/** Based on the original Juggler model from Starling
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractJuggler 
	{
		/// The total life time of the juggler (in seconds).
		function get elapsedTime () : Number;

		/// Adds an object to the juggler.
		function add (object:IAbstractAnimatable) : void;

		/// Advances all objects by a certain time (in seconds).
		function advanceTime (time:Number) : void;

		/// Determines if an object has been added to the juggler.
		function contains (object:IAbstractAnimatable) : Boolean;

		/// Figures out if the juggler contains one or more tweens with a certain target.
		function containsTweens (target:Object) : Boolean;

		/// Removes all objects at once.
		function purge () : void;

		/// Removes an object from the juggler.
		function remove (object:IAbstractAnimatable) : void;

		/// Removes all tweens with a certain target.
		function removeTweens (target:Object) : void;

		/**
		 * Utilizes a tween to animate the target object over time seconds. Internally,
		 * this method uses a tween instance (taken from an object pool) that is added to the
		 * juggler right away. This method provides a convenient alternative for creating 
		 * and adding a tween manually.
		 * 
		 *   Fill 'properties' with key-value pairs that describe both the 
		 * tween and the animation target. Here is an example:
		 * juggler.tween(object, 2.0, {
		 * transition: Transitions.EASE_IN_OUT,
		 * delay: 20, // -> tween.delay = 20
		 * x: 50      // -> tween.animate("x", 50)
		 * });
		 */
		function tween (target:Object, time:Number, properties:Object) : void;
	}
	
}