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
		public static const CHANGE_GRAPHICS_STATE:String = "GEchangeGraphicsState";
		
		//
		public static const LAYER_TRANSITION_IN_COMPLETE:String = "GELayerTransitionInComplete"
		
		//
		public static const LAYER_TRANSITION_OUT_COMPLETE:String = "GELayerTransitionOutComplete"
		
		//Init signals
		public static const STARLING_READY:String = "GEstarlingReady";
		
		//Generic button
		public static const GENERIC_BUTTON_PRESSED:String = "GEbuttonPressed";
		
		//Generic movieclip ended
		public static const MOVIE_CLIP_ENDED:String = "GEMovieClipEnded"
		
	}

}