package bridge.abstract 
{
	import flash.net.NetStream;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/** A Video is a Quad with a texture mapped onto it.
	 *
	 *  <p>The Video class is more or less a Starling equivalent of Flash's Video class with attached <em>NetStream</em>.
	 *  The texture is written automatically if not specified otherwise. Never the less you can use other DisplayObjects
	 *  for rendering as well and or handle the drawing and uploading yourself if you want to.</p>
	 * 
	 *  <p><strong>Note:</strong><em>There are no controls for starting/stopping the video source in this class. This has to be done by controlling the
	 *  netStream. If you start/stop the netStream, the video will recieve the Events of the netStream and handle the rest.</em></p>
	 *
	 *  <p>As "Video" inherits from "Quad", you can give it a color. For each pixel, the resulting
	 *  color will be the result of the multiplication of the color of the texture with the color of
	 *  the quad. That way, you can easily tint textures with a certain color. Furthermore flipping is simply done by
	 *  adjusting the vertexData.</p>
	 *
	 *  <p>Uploading textures to the GPU is very expensive. This may be no problem on desktop computers
	 *  but it is a big problem on most mobile devices. Therefore it is very important to chose the right
	 *  resolution and texture size, as well as the method for drawing and uploading.
	 *  If you use Flash 11.8 / AIR 3.8 (-swf-version=21) RectangleTextures are supported if necessary. Versions below will
	 *  always fall back to Textue, so make sure to use the cropping rect parameter to avoid the upload of unused bytes.</p>
	 *
	 *  <p>Read more about performance of POT/NPOT Textures here:
	 *  <ul>
	 *  <li><a href="http://www.flintfabrik.de/blog/camera-performance-with-stage3d">Webcam Performance with Stage3D – Part I (desktop/mobile)</a></li>
	 *  <li><a href="http://www.flintfabrik.de/blog/webcam-performance-with-stage3d-part-ii-rectangletextures-in-air-3-8-beta">Webcam Performance with Stage3D – Part II RectangleTextures in AIR 3.8 Beta (desktop)</a></li>
	 *  <li><a href="http://www.flintfabrik.de/blog/webcam-performance-with-stage3d-part-iii-rectangletextures-in-air-3-8-beta-mobile">Webcam Performance with Stage3D – Part III RectangleTextures in AIR 3.8 Beta (mobile)</a></li>
	 *  </ul>
	 *  </p>
	 *
	 *  @see starling.textures.Texture
	 *  @see starling.display.Quad
	 *
	 *  @see starlingEngine.video.display.Video
	 */
	public interface IAbstractVideo extends IAbstractSprite
	{
		/**
		 * 
		 * @param	path
		 */
		function addVideoPath(path:String):void
		
		/**
		 * 
		 * @param	stream
		 */
		function addVideoStream(stream:NetStream):void
		
		/** Pauses the Video EventListeners (drawing/uploading) but the NetStream will not be affected.
		 *  @see start()
		 *  @see stop()
		 */
		function pause():void
		
		/**
		 * 
		 */
		function resume():void
		
		/** Stopping the video recording and EventListeners.
		 *  @see pause()
		 *  @see start()
		 */
		function stop():void
		
		/**
		 * Starting/Resuming the video.
		 * @param	forceRecording
		 * Starts the video recording, even if the Video has not been added to stage. E.g. to use the texture
		 * in multiple Images, a ParticleSystem, with a custom renderer or whatever, instead of the Video itself.
		 *  @see pause()
		 *  @see stop()
		 */
		function start(forceRecording:Boolean = false):void
		
		/**
		 * @see flash.net.NetStream
		 */
		function get stream():NetStream
		
		/**
		 * 
		 */
		 function get loop():Boolean 
		 function set loop(value:Boolean):void 
	}
	
}