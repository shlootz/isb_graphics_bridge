package bridge.abstract 
{
	import flash.geom.Rectangle;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * <b>The following is based on Starling architecture and will be used as referecne.</b>
	 * <p>A texture stores the information that represents an image. It cannot be added to the
	 * display list directly; instead it has to be mapped onto a display object. In Starling, 
	 * that display object is the class "Image".</p><b>Texture Formats</b><p>Since textures can be created from a "BitmapData" object, Starling supports any bitmap
	 * format that is supported by Flash. And since you can render any Flash display object into
	 * a BitmapData object, you can use this to display non-Starling content in Starling - e.g.
	 * Shape objects.</p><p>Starling also supports ATF textures (Adobe Texture Format), which is a container for
	 * compressed texture formats that can be rendered very efficiently by the GPU. Refer to 
	 * the Flash documentation for more information about this format.</p><b>Mip Mapping</b><p>MipMaps are scaled down versions of a texture. When an image is displayed smaller than
	 * its natural size, the GPU may display the mip maps instead of the original texture. This
	 * reduces aliasing and accelerates rendering. It does, however, also need additional memory;
	 * for that reason, you can choose if you want to create them or not.</p><b>Texture Frame</b><p>The frame property of a texture allows you let a texture appear inside the bounds of an
	 * image, leaving a transparent space around the texture. The frame rectangle is specified in 
	 * the coordinate system of the texture (not the image):</p><codeblock>
	 * var frame:Rectangle = new Rectangle(-10, -10, 30, 30); 
	 * var texture:Texture = Texture.fromTexture(anotherTexture, null, frame);
	 * var image:Image = new Image(texture);</codeblock><p>This code would create an image with a size of 30x30, with the texture placed at 
	 * <codeph>x=10, y=10</codeph> within that image (assuming that 'anotherTexture' has a width and 
	 * height of 10 pixels, it would appear in the middle of the image).</p><p>The texture atlas makes use of this feature, as it allows to crop transparent edges
	 * of a texture and making up for the changed size by specifying the original texture frame.
	 * Tools like <xref href="http://www.texturepacker.com/">TexturePacker</xref> use this to  
	 * optimize the atlas.</p><b>Texture Coordinates</b><p>If, on the other hand, you want to show only a part of the texture in an image
	 * (i.e. to crop the the texture), you can either create a subtexture (with the method 
	 * 'Texture.fromTexture()' and specifying a rectangle for the region), or you can manipulate 
	 * the texture coordinates of the image object. The method 'image.setTexCoords' allows you 
	 * to do that.</p><b>Context Loss</b><p>When the current rendering context is lost (which can happen e.g. on Android and
	 * Windows), all texture data is lost. If you have activated "Starling.handleLostContext", 
	 * however, Starling will try to restore the textures. To do that, it will keep the bitmap
	 * and ATF data in memory - at the price of increased RAM consumption. To save memory,
	 * however, you can restore a texture directly from its source (e.g. an embedded asset):</p><codeblock>
	 * var texture:Texture = Texture.fromBitmap(new EmbeddedBitmap());
	 * texture.root.onRestore = function():void 
	 * { 
	 * texture.root.uploadFromBitmap(new EmbeddedBitmap());
	 * };</codeblock><p>The "onRestore"-method will be called when the context was lost and the texture has
	 * been recreated (but is still empty). If you use the "AssetManager" class to manage
	 * your textures, this will be done automatically.</p>
	 */
	public interface IAbstractTexture 
	{
		/**
		 * The texture frame (see class description).
		 */
		function get frame () : Rectangle;
//
		/**
		 * The height of the texture in points.
		 */
		function get height () : Number;
//
		/**
		 * Indicates if the texture contains mip maps.
		 */
		function get mipMapping () : Boolean;
//
		/**
		 * The height of the texture in pixels (without scale adjustment).
		 */
		function get nativeHeight () : Number;
//
		/**
		 * The height of the texture in pixels (without scale adjustment).
		 */
		function get nativeWidth () : Number;
//
		/**
		 * Indicates if the alpha values are premultiplied into the RGB values.
		 */
		function get premultipliedAlpha () : Boolean;
//
		/**
		 * Indicates if the texture should repeat like a wallpaper or stretch the outermost pixels.
		 * Note: this only works in textures with sidelengths that are powers of two and 
		 * that are not loaded from a texture atlas (i.e. no subtextures).
		 */
		function get repeat () : Boolean;
		/**
		 * 
		 */
		function set repeat (value:Boolean) : void;
//
		/**
		 * The scale factor, which influences width and height properties.
		 */
		function get scale () : Number;
//
		/**
		 * The width of the texture in points.
		 */
		function get width () : Number;
//
		/**
		 * Converts texture coordinates into the format required for rendering. While the texture
		 * coordinates of an image always use the range [0, 1], the actual
		 * coordinates could be different: you might be working with a SubTexture. This method
		 * adjusts the coordinates accordingly.
		 * @param	texCoords	a vector containing UV coordinates (optionally, among other data).
		 *   U and V coordinates always have to come in pairs. The vector is
		 *   modified in place.
		 * @param	startIndex	the index of the first U coordinate in the vector.
		 * @param	stride	the distance (in vector elements) of consecutive UV pairs.
		 * @param	count	the number of UV pairs that should be adjusted, or "-1" for all of them.
		 */
		function adjustTexCoords (texCoords:Vector.<Number>, startIndex:int=0, stride:int=0, count:int=-1) : void;
//
		/**
		 * Disposes the underlying texture data. Note that not all textures need to be disposed: 
		 * SubTextures (created with 'Texture.fromTexture') just reference other textures and
		 * and do not take up resources themselves; this is also true for textures from an 
		 * atlas.
		 */
		function dispose () : void;

	}
	
}