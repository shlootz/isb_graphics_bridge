package bridge.abstract 
{
	import flash.geom.Rectangle;
	import flash.geom.Matrix;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractDisplayObject 
	{
	/**
	 * The DisplayObject class is the base class for all objects that are rendered on the 
	 * screen.
	 * 
	 *   <p><b>The Display Tree</b></p><p>In Bridge, all displayable objects are organized in a display tree. Only objects that
	 * are part of the display tree will be displayed (rendered).</p><p>The display tree consists of leaf nodes (Image, Quad) that will be rendered directly to
	 * the screen, and of container nodes (subclasses of "DisplayObjectContainer", like "Sprite").
	 * A container is simply a display object that has child nodes - which can, again, be either
	 * leaf nodes or other containers.</p><p>At the base of the display tree, there is the Stage, which is a container, too. To create
	 * a bridged  application, you create a custom Sprite subclass, and the Bridge will add an
	 * instance of this class to the stage.</p><p>A display object has properties that define its position in relation to its parent
	 * (x, y), as well as its rotation and scaling factors (scaleX, scaleY). Use the 
	 * <codeph>alpha</codeph> and <codeph>visible</codeph> properties to make an object translucent or 
	 * invisible.</p><p>Every display object may be the target of touch events. If you don't want an object to be
	 * touchable, you can disable the "touchable" property. When it's disabled, neither the object
	 * nor its children will receive any more touch events.</p><b>Transforming coordinates</b><p>Within the display tree, each object has its own local coordinate system. If you rotate
	 * a container, you rotate that coordinate system - and thus all the children of the 
	 * container.</p><p>Sometimes you need to know where a certain point lies relative to another coordinate 
	 * system. That's the purpose of the method <codeph>getTransformationMatrix</codeph>. It will  
	 * create a matrix that represents the transformation of a point in one coordinate system to 
	 * another.</p><b>Subclassing</b><p>Since DisplayObject is an abstract class, you cannot instantiate it directly, but have 
	 * to use one of its subclasses instead. There are already a lot of them available, and most 
	 * of the time they will suffice.</p><p>However, you can create custom subclasses as well. That way, you can create an object
	 * with a custom render function. You will need to implement the following methods when you 
	 * subclass DisplayObject:</p><ul><li><codeph>function render(support:RenderSupport, parentAlpha:Number):void</codeph></li><li><codeph>function getBounds(targetSpace:DisplayObject, 
	 * resultRect:Rectangle=null):Rectangle</codeph></li></ul><p>Have a look at the Quad class for a sample implementation of the 'getBounds' method.
	 * The Bridge is based on Starling Architecture.
	 * For a sample on how to write a custom render function, you can have a look at this
	 * <xref href="http://wiki.starling-framework.org/manual/custom_display_objects">article</xref>
	 * in the Starling Wiki.</p><p>When you override the render method, it is important that you call the method
	 * 'finishQuadBatch' of the support object. This forces Starling to render all quads that 
	 * were accumulated before by different render methods (for performance reasons). Otherwise, 
	 * the z-ordering will be incorrect.</p>
	 */
		
		/**
		 * Setting x coordinate
		 */
		function set x(val:Number):void
		/**
		 * Getting x coordinate
		 */
		function get x():Number
		/**
		 * Setting y coordinate
		 */
		function set y(val:Number):void
		/**
		 * Getting y coordinate
		 */
		function get y():Number
		/**
		 * 
		 */
		function set rotation(val:Number):void
		/**
		 * 
		 */
		function get rotation():Number
		/**
		 * 
		 */
		function set alpha(val:Number):void
		/**
		 * 
		 */
		function get alpha():Number
		/**
		 * 
		 */
		function set scaleX(val:Number):void
		/**
		 * 
		 */
		function get scaleX():Number
		/**
		 * 
		 */
		function set scaleY(val:Number):void
		/**
		 * 
		 */
		function get scaleY():Number
		/**
		 * 
		 */
		function get blendMode () : String;
		/**
		 * 
		 */
		function set blendMode (value:String) : void;
		/**
		 * 
		 */
		function get bounds () : Rectangle;
		/**
		 * 
		 */
		function get height () : Number;
		/**
		 * 
		 */
		function set height (value:Number) : void;
		/**
		 * 
		 */
		function get name () : String;
		/**
		 * 
		 */
		function set name (value:String) : void;
		/**
		 * 
		 */
		//function get parent () : DisplayObjectContainer;
		/**
		 * 
		 */
		function get pivotX () : Number;
		/**
		 * 
		 */
		function set pivotX (value:Number) : void;
		/**
		 * 
		 */
		function get pivotY () : Number;
		/**
		 * 
		 */
		function set pivotY (value:Number) : void;
		/**
		 * 
		 */
		//function get root () : IAbstractDisplayObject;
		/**
		 * 
		 */
		function get skewX () : Number;
		/**
		 * 
		 */
		function set skewX (value:Number) : void;
		/**
		 * 
		 */
		function get skewY () : Number;
		/**
		 * 
		 */
		function set skewY (value:Number) : void;
		/**
		 * 
		 */
		function get touchable () : Boolean;
		/**
		 * 
		 */
		function set touchable (value:Boolean) : void;
		/**
		 * 
		 */
		function get transformationMatrix () : Matrix;
		/**
		 * 
		 */
		function set transformationMatrix (matrix:Matrix) : void;
		/**
		 * 
		 */
		function get useHandCursor () : Boolean;
		/**
		 * 
		 */
		function set useHandCursor (value:Boolean) : void;
		/**
		 * 
		 */
		function get visible () : Boolean;
		/**
		 * 
		 */
		function set visible (value:Boolean) : void;
		/**
		 * 
		 */
		function get width () : Number;
		/**
		 * 
		 */
		function set width (value:Number) : void;
		/**
		 * 
		 * @param	type
		 * @param	listener
		 */
		function addEventListener (type:String, listener:Function) : void;
		/**
		 * 
		 * @param	hAlign
		 * @param	vAlign
		 */
		function alignPivot (hAlign:String="center", vAlign:String="center") : void;
		/**
		 * 
		 */
		function dispose () : void;
		/**
		 * 
		 */
		//function getBounds (targetSpace:IAbstractDisplayObject, resultRect:Rectangle=null) : Rectangle;
		/**
		 * 
		 */
		//function getTransformationMatrix (targetSpace:IAbstractDisplayObject, resultMatrix:Matrix=null) : Matrix;
		/**
		 * 
		 * @param	globalPoint
		 * @param	resultPoint
		 * @return Point
		 */
		function globalToLocal (globalPoint:Point, resultPoint:Point=null) : Point;
		/**
		 * 
		 */
		//function hitTest (localPoint:Point, forTouch:Boolean=false) : IAbstractDisplayObject;
		/**
		 * 
		 * @param	localPoint
		 * @param	resultPoint
		 * @return Point
		 */
		function localToGlobal (localPoint:Point, resultPoint:Point=null) : Point;
		/**
		 * 
		 * @param	type
		 * @param	listener
		 */
		function removeEventListener (type:String, listener:Function) : void;
		/**
		 * 
		 * @param	type
		 */
		function removeEventListeners (type:String=null) : void;
		/**
		 * 
		 * @param	dispose
		 */
		function removeFromParent (dispose:Boolean=false) : void;
		/**
		 * 
		 */
		//function setParent (value:DisplayObjectContainer) : void;
	}
	
}