package bridge.abstract 
{
	import flash.media.Sound;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * A MovieClip is a simple way to display an animation depicted by a list of textures.
	 * 
	 *   <p>Pass the frames of the movie in a vector of textures to the constructor. The movie clip 
	 * will have the width and height of the first frame. If you group your frames with the help 
	 * of a texture atlas (which is recommended), use the <codeph>getTextures</codeph>-method of the 
	 * atlas to receive the textures in the correct (alphabetic) order.</p><p>You can specify the desired framerate via the constructor. You can, however, manually 
	 * give each frame a custom duration. You can also play a sound whenever a certain frame 
	 * appears.</p><p>The methods <codeph>play</codeph> and <codeph>pause</codeph> control playback of the movie. You
	 * will receive an event of type <codeph>Event.MovieCompleted</codeph> when the movie finished
	 * playback. If the movie is looping, the event is dispatched once per loop.</p><p>As any animated object, a movie clip has to be added to a juggler (or have its 
	 * <codeph>advanceTime</codeph> method called regularly) to run. The movie will dispatch 
	 * an event of type "Event.COMPLETE" whenever it has displayed its last frame.</p>
	 */
	public interface IAbstractMovie extends IAbstractImage
	{
		/**
		 * The index of the frame that is currently displayed.
		 */
		function get currentFrame () : int;
		
		/**
		 * 
		 */
		function set currentFrame (value:int) : void;
		
		/**
		 * The time that has passed since the clip was started (each loop starts at zero).
		 */
		function get currentTime () : Number;
		
		/**
		 * The default number of frames per second. Individual frames can have different 
		 * durations. If you change the fps, the durations of all frames will be scaled 
		 * relatively to the previous value.
		 */
		function get fps () : Number;
		
		/**
		 * 
		 */
		function set fps (value:Number) : void;
		
		/**
		 * Indicates if a (non-looping) movie has come to its end.
		 */
		function get isComplete () : Boolean;
		
		/**
		 * Indicates if the clip is still playing. Returns false when the end 
		 * is reached.
		 */
		function get isPlaying () : Boolean;
		
		/**
		 * Indicates if a (non-looping) movie has come to its end.
		 */
		function get loop () : Boolean;
		
		/**
		 * 
		 */
		function set loop (value:Boolean) : void;
		
		/**
		 * The total number of frames.
		 */
		function get numFrames () : int;
		
		/**
		 * he total duration of the clip in seconds.
		 */
		function get totalTime () : Number;
		
		/**
		 * Adds an additional frame, optionally with a sound and a custom duration. If the 
		 * duration is omitted, the default framerate is used (as specified in the constructor).
		 * @param	texture
		 * @param	sound
		 * @param	duration
		 */
		function addNewFrame(image:IAbstractImage, sound:Sound = null, duration:Number = -1):void
		
		/**
		 * Adds a frame at a certain index, optionally with a sound and a custom duration.
		 * @param	frameID
		 * @param	texture
		 * @param	sound
		 * @param	duration
		 */
		function addNewFrameAt(frameID:uint, image:IAbstractImage, sound:Sound = null, duration:Number = -1):void
		
		/**
		 * Advance the time by a number of seconds.
		 * @param	passedTime
		 */
		function advanceTime (passedTime:Number) : void;
		
		/**
		 * Returns the duration of a certain frame (in seconds).
		 * @param	frameID
		 * @return Number
		 */
		function getFrameDuration (frameID:int) : Number;
		
		/**
		 * Returns the sound of a certain frame.
		 * @param	frameID
		 * @return Sound
		 */
		function getFrameSound (frameID:int) : Sound;
		
		/**
		 * Returns the texture of a certain frame.
		 * @param	frameID
		 * @return IAbstractTexture
		 */
		function getTextureFromFrame(frameID:uint):IAbstractImage
		
		/**
		 * Pauses playback.
		 */
		function pause () : void;
		
		/**
		 *  Starts playback. Beware that the clip has to be added to a juggler, too!
		 */
		function play () : void;
		
		/**
		 * Removes the frame at a certain ID. The successors will move down.
		 * @param	frameID
		 */
		function removeFrameAt (frameID:int) : void;
		
		/**
		 * Sets the duration of a certain frame (in seconds).
		 * @param	frameID
		 * @param	duration
		 */
		function setFrameDuration (frameID:int, duration:Number) : void;
		
		/**
		 * Sets the sound of a certain frame. The sound will be played whenever the frame 
		 * is displayed.
		 * @param	frameID
		 * @param	sound
		 */
		function setFrameSound (frameID:int, sound:Sound) : void;
		
		/**
		 * Sets the texture of a certain frame.
		 * @param	frameID
		 * @param	texture
		 */
		function setTextureToFrame(frameID:uint, image:IAbstractImage):void
		
		/**
		 * 
		 * @param	frame
		 */
		function gotoAndStop(frame:int):void
		
		/**
		 * 
		 * @param	frame
		 */
		 function gotoAndPlay(frame:int):void
		 
		 /**
		  * 
		  */
		 function get frame():Number 
		 function set frame(value:Number):void 

		/**
		 * Stops playback, resetting "currentFrame" to zero.
		 */
		function stop () : void;
	}
	
}