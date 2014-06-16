package bridge.abstract.events 
{
	import bridge.abstract.IAbstractDisplayObject;
	/**
	 * ...
	 * @author Eu
	 */
	/**
	 * Keeps track of the Bridge events and 
	 */
	public class BridgeEvents
	{
		
		/// Event type for a display object that is added to a parent.
		public static const ADDED : String = "added";

		/// Event type for a display object that is added to the stage
		public static const ADDED_TO_STAGE : String = "addedToStage";

		/// An event type to be utilized in custom events. Not used by Starling right now.
		public static const CANCEL : String = "cancel";

		/// An event type to be utilized in custom events. Not used by Starling right now.
		public static const CHANGE : String = "change";

		/// An event type to be utilized in custom events. Not used by Starling right now.
		public static const CLOSE : String = "close";

		/// Event type that may be used whenever something finishes.
		public static const COMPLETE : String = "complete";

		/// Event type for a (re)created stage3D rendering context.
		public static const CONTEXT3D_CREATE : String = "context3DCreate";

		/// Event type for a display object that is entering a new frame.
		public static const ENTER_FRAME : String = "enterFrame";

		/// Event type for a display object that is being flattened.
		public static const FLATTEN : String = "flatten";

		/// An event type to be utilized in custom events. Not used by Starling right now.
		public static const OPEN : String = "open";

		/// Event type for an animated object that requests to be removed from the juggler.
		public static const REMOVE_FROM_JUGGLER : String = "removeFromJuggler";

		/// Event type for a display object that is removed from its parent.
		public static const REMOVED : String = "removed";

		/// Event type for a display object that is removed from the stage.
		public static const REMOVED_FROM_STAGE : String = "removedFromStage";

		/// Event type for a resized Flash Player.
		public static const RESIZE : String = "resize";

		/// Event type that indicates that the root DisplayObject has been created.
		public static const ROOT_CREATED : String = "rootCreated";

		/// An event type to be utilized in custom events. Not used by Starling right now.
		public static const SCROLL : String = "scroll";

		/// An event type to be utilized in custom events. Not used by Starling right now.
		public static const SELECT : String = "select";

		/// Event type that is dispatched by the AssetManager after a context loss.
		public static const TEXTURES_RESTORED : String = "texturesRestored";

		/// Event type for a triggered button.
		public static const TRIGGERED : String = "triggered";
		
		/**
		 * Extracts the event target from the response object
		 * @param	eventTarget
		 * @return
		 */
		public static function extractCurrentTarget(eventTarget:Object):IAbstractDisplayObject
		{
			return eventTarget.currentTarget as IAbstractDisplayObject
		}
		
		/**
		 * Extracts the data from the response object
		 * @param	eventTarget
		 * @return
		 */
		public static function extractData(eventTarget:Object):Object
		{
			return eventTarget.data as Object
		}
		
		/**
		 * Extracts the type from the respinse object
		 * @param	eventTarget
		 * @return
		 */
		public static function extractType(eventTarget:Object):String
		{
			return eventTarget.type as String
		}
		
	}

}