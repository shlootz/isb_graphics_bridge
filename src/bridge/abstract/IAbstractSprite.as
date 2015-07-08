package bridge.abstract 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * A Sprite is the most lightweight, non-abstract container class.
	 * <p>Use it as a simple means of grouping objects together in one coordinate system, or
	 * as the base class for custom display objects.</p><b>Flattened Sprites</b><p>The <codeph>flatten</codeph>-method allows you to optimize the rendering of static parts of 
	 * your display list.</p><p>It analyzes the tree of children attached to the sprite and optimizes the rendering calls 
	 * in a way that makes rendering extremely fast. The speed-up comes at a price, though: you 
	 * will no longer see any changes in the properties of the children (position, rotation, 
	 * alpha, etc.). To update the object after changes have happened, simply call 
	 * <codeph>flatten</codeph> again, or <codeph>unflatten</codeph> the object.</p><b>Clipping Rectangle</b><p>The <codeph>clipRect</codeph> property allows you to clip the visible area of the sprite
	 * to a rectangular region. Only pixels inside the rectangle will be displayed. This is a very
	 * fast way to mask objects. However, there is one limitation: the <codeph>clipRect</codeph>
	 * only works with stage-aligned rectangles, i.e. you cannot rotate or skew the rectangle.
	 * This limitation is inherited from the underlying "scissoring" technique that is used
	 * internally.</p>
	 */
	public interface IAbstractSprite extends IAbstractDisplayObjectContainer
	{
		/**
		 * The object's clipping rectangle in its local coordinate system.
		 * Only pixels within that rectangle will be drawn. 
		 * Note: clip rects are axis aligned with the screen, so they
		 * will not be rotated or skewed if the Sprite is.
		 */
		function get clipRect () : Rectangle;
		
		/**
		 * 
		 */
		function set clipRect (value:Rectangle) : void;
		
		/**
		 * Indicates if the sprite was flattened.
		 */
		function get isFlattened () : Boolean;
		
		/**
		 * Optimizes the sprite for optimal rendering performance. Changes in the
		 * children of a flattened sprite will not be displayed any longer. For this to happen,
		 * either call flatten again, or unflatten the sprite. 
		 * Beware that the actual flattening will not happen right away, but right before the
		 * next rendering.
		 * 
		 *   When you flatten a sprite, the result of all matrix operations that are otherwise
		 * executed during rendering are cached. For this reason, a flattened sprite can be
		 * rendered with much less strain on the CPU. However, a flattened sprite will always
		 * produce at least one draw call; if it were merged together with other objects, this
		 * would cause additional matrix operations, and the optimization would have been in vain.
		 * Thus, don't just blindly flatten all your sprites, but reserve flattening for sprites
		 * with a big number of children.
		 */
		function flatten (ignoreChildOrder:Boolean = false) : void;
		
		/**
		 * Removes the rendering optimizations that were created when flattening the sprite.
		 * Changes to the sprite's children will immediately become visible again.
		 */
		function unflatten () : void;
	}
	
}