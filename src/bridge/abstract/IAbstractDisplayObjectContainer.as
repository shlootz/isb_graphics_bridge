package bridge.abstract 
{
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	
	 /**
	 * A DisplayObjectContainer represents a collection of display objects.
	 * It is the base class of all display objects that act as a container for other objects. By 
	 * maintaining an ordered list of children, it defines the back-to-front positioning of the 
	 * children within the display tree.
	 * 
	 *   <p>A container does not a have size in itself. The width and height properties represent the 
	 * extents of its children. Changing those properties will scale all children accordingly.</p><p>As this is an abstract class, you can't instantiate it directly, but have to 
	 * use a subclass instead. The most lightweight container class is "Sprite".</p><b>Adding and removing children</b><p>The class defines methods that allow you to add or remove children. When you add a child, 
	 * it will be added at the frontmost position, possibly occluding a child that was added 
	 * before. You can access the children via an index. The first child will have index 0, the 
	 * second child index 1, etc.</p>
	 * 
	 *   Adding and removing objects from a container triggers non-bubbling events.
	 * 
	 *   <ul><li><codeph>Event.ADDED</codeph>: the object was added to a parent.</li><li><codeph>Event.ADDED_TO_STAGE</codeph>: the object was added to a parent that is 
	 * connected to the stage, thus becoming visible now.</li><li><codeph>Event.REMOVED</codeph>: the object was removed from a parent.</li><li><codeph>Event.REMOVED_FROM_STAGE</codeph>: the object was removed from a parent that 
	 * is connected to the stage, thus becoming invisible now.</li></ul>
	 * 
	 *   Especially the <codeph>ADDED_TO_STAGE</codeph> event is very helpful, as it allows you to 
	 * automatically execute some logic (e.g. start an animation) when an object is rendered the 
	 * first time.
	 */
	 
	public interface IAbstractDisplayObjectContainer extends IAbstractDisplayObject
	{	
		/**
		 * @return Returns the number of children contained
		 */
		function get numChildren () : int;
		
		/** Adds a new child to the container
		 * 
		 * @param	child
		 * @return IAbstractDisplayObject
		 * @see bridge.abstract.IAbstractDisplayObject
		 */
		function addNewChild (child:Object) : IAbstractDisplayObject;
		
		/** Adds a new child to the container at a specified index
		 * 
		 * @param	child
		 * @param	index
		 * @return IAbstractDisplayObject
		 * @see bridge.abstract.IAbstractDisplayObject
		 */
		function addNewChildAt (child:IAbstractDisplayObject, index:int) : IAbstractDisplayObject;
		
		/** Broadcasts and event
		 * 
		 * @param	type
		 * @param	data
		 */
		function broadcastEventWith (type:String, data:Object = null) : void;
		
		/** Returns true if it contains a certain child or false if it doesn't
		 * 
		 * @param	child
		 * @return Boolean
		 */
		function containsChild (child:IAbstractDisplayObject) : Boolean;
		
		/** Returns a rectangle representing the bounds of the child
		 * 
		 * @param	targetSpace
		 * @param	resultRect
		 * @return Rectangle
		 */
		function getChildBounds (targetSpace:IAbstractDisplayObject, resultRect:Rectangle = null) : Rectangle;
		
		/** Returns the child a specific index
		 * 
		 * @param	index
		 * @return IAbstractDisplayObject
		 * @see bridge.abstract.IAbstractDisplayObject
		 */
		function getChildAtIndex (index:int) : IAbstractDisplayObject;
		
		/** Returns a child by its name
		 * 
		 * @param	name
		 * @return IAbstractDisplayObject
		 * @see bridge.abstract.IAbstractDisplayObject
		 */
		function getChildByNameStr (name:String) : IAbstractDisplayObject;
		
		/**
		 * 
		 */
		//function getChildEventListeners (object:IAbstractDisplayObject, eventType:String, listeners:Vector.<*>) : void;
		/** Returns the index number of a child
		 * 
		 * @param	child 
		 * @see bridge.abstract.IAbstractDisplayObject
		 * @return int
		 */
		function getChildIndexNr (child:IAbstractDisplayObject) : int;
		
		/**
		 * 
		 */
		//function hitTest (localPoint:Point, forTouch:Boolean=false) : IAbstractDisplayObject;
		/** Removes a child from the container.
		 * 
		 * @param	child 
		 * @see bridge.abstract.IAbstractDisplayObject
		 * @param	dispose. Set this to true if you want to completely remove this object from memory
		 * @return 
		 * @see bridge.abstract.IAbstractDisplayObject
		 */
		function removeChildAndDispose (child:IAbstractDisplayObject, dispose:Boolean = false) : IAbstractDisplayObject;
		
		/** Removes a child from the container by specifying its index number
		 * 
		 * @param	index
		 * @param	dispose. Set this to true if you want to completely remove this object from memory
		 * @return IAbstractDisplayObject
		 * @see bridge.abstract.IAbstractDisplayObject
		 */
		function removeChildAtIndex (index:int, dispose:Boolean = false) : IAbstractDisplayObject;
		
		/** Removes all children from beginIndex to endIndex
		 * 
		 * @param	beginIndex
		 * @param	endIndex
		 * @param	dispose. Set this to true if you want to completely remove this object from memory
		 */
		function removeChildrenFromTo (beginIndex:int = 0, endIndex:int = -1, dispose:Boolean = false) : void;
		
		/** Manually set the index number of a child
		 * 
		 * @param	child 
		 * @see bridge.abstract.IAbstractDisplayObject
		 * @param	index
		 */
		function setChildIndexNr (child:IAbstractDisplayObject, index:int) : void;
		
		/** Inject a compare function by witch to sort the children
		 * 
		 * @param	compareFunction
		 */
		function sortChildrenBy (compareFunction:Function) : void;
		
		/** Swaps the child1 with child2
		 * 
		 * @param	child1 
		 * @see bridge.abstract.IAbstractDisplayObject
		 * @param	child2 
		 * @see bridge.abstract.IAbstractDisplayObject
		 */
		function swapChildrenF (child1:IAbstractDisplayObject, child2:IAbstractDisplayObject) : void;
		
		/** Swaps children from the specified indexes
		 * 
		 * @param	index1
		 * @param	index2
		 */
		function swapChildrenAtIndex (index1:int, index2:int) : void;
	}
	
}