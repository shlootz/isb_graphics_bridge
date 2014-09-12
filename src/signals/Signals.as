package signals 
{
	import flash.utils.getQualifiedClassName;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Some default signals already used within the engine
	 */
	public class Signals 
	{
		//General signals
		public static const CHANGE_GRAPHICS_STATE:String = "GEchangeGraphicsState"
		
		//Layer tranzition in complete
		public static const LAYER_TRANSITION_IN_COMPLETE:String = "GElayerTransitionInComplete"
		
		//Layer tranzition out complete
		public static const LAYER_TRANSITION_OUT_COMPLETE:String = "GElayerTransitionOutComplete"
		
		//Init signals
		public static const STARLING_READY:String = "GEstarlingReady"
		
		//Generic button
		public static const GENERIC_BUTTON_PRESSED:String = "GEbuttonPressed"
		
		//Generic slider changed
		public static const GENERIC_SLIDER_CHANGE:String = "GEsliderChanged"
		
		//Generic toggle Button
		public static const GENERIC_TOGGLE_BUTTON_PRESSED:String = "GEtoggleButtonPressed"
		
		//Generic movieclip ended
		public static const MOVIE_CLIP_ENDED:String = "GEmovieClipEnded"
		
		//Some display object has been touched, either by a touch event or mouse event
		public static const DISPLAY_OBJECT_TOUCHED:String = "GEdisplayObjectTouched"
		
		//Generic list item signal
		public static const LIST_ITEM_TOUCHED:String = "GElistItemTouched";
		
	}

}