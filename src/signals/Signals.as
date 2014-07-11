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
		public static const LAYER_TRANSITION_IN_COMPLETE:String = "GELayerTransitionInComplete"
		
		//Layer tranzition out complete
		public static const LAYER_TRANSITION_OUT_COMPLETE:String = "GELayerTransitionOutComplete"
		
		//Init signals
		public static const STARLING_READY:String = "GEstarlingReady"
		
		//Generic button
		public static const GENERIC_BUTTON_PRESSED:String = "GEbuttonPressed"
		
		//Generic movieclip ended
		public static const MOVIE_CLIP_ENDED:String = "GEMovieClipEnded"
		
		//Some display object has been touched, either by a touch event or mouse event
		public static const DISPLAY_OBJECT_TOUCHED:String = "DisplayOjectTouched"
		
	}

}