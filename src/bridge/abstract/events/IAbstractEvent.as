package bridge.abstract.events 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Abstractization of Event
	 */
	public interface IAbstractEvent 
	{
		/// Indicates if event will bubble.
		function get bubbles () : Boolean;

		/// The object the event is currently bubbling at.
		function get currentTarget_ () : IAbstractEventDispatcher;

		/// Arbitrary data that is attached to the event.
		function get data () : Object;

		/// The object that dispatched the event.
		function get target_ () : IAbstractEventDispatcher;

		/// A string that identifies the event.
		function get type () : String;

		/// Prevents any other listeners from receiving the event.
		function stopImmediatePropagation () : void;

		/// Prevents listeners at the next bubble stage from receiving the event.
		function stopPropagation () : void;

		/// Returns a description of the event, containing type and bubble information.
		function toString () : String;
	}
	
}