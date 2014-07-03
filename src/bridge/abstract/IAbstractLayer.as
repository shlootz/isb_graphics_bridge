package bridge.abstract 
{
	import flash.utils.Dictionary
	/**
	 * ...
	 * @author Alex Popescu
	 * 
	 * A layer is basically a state that is not managed by 3rd party engine.
	 * <p>Layers are managed internally and the engine bridge has depth sorting and swaping methods</p>
	 * <p>Use layers to organise the display tree</p>
	 * <p>At its core, the Layer is a Sprite </p>
	 * @see bridge.abstract.IAbstractSprite
	 */
	/**
	 * A layer is basically a state (extending a DisplayObjectContainer) that is not managed by 3rd party engine.
	 */
	public interface IAbstractLayer extends IAbstractState
	{
		/**
		 * @param name Sets the layer name by witch it can be later identified
		 */
		function set layerName(name:String):void
		
		/**
		 * @return Returns the layer name
		 */
		function get layerName():String
		
		/**
		 * @return the layer depth.
		 */
		function get layerDepth():uint
		
		/**
		 * @param val set the depth of the layer. The bigger the val, the highest the Layer will be in the display tree.
		 */
		function set layerDepth(val:uint ):void
		
		/**
		 * Returns a dictionary containing the stored VOs
		 * @return
		 */
		function get layout():Dictionary
		
		/**
		 * Returns a specific IAbstractDisplayObject child
		 * @param	name
		 * @return
		 */
		function getElement(name:String):IAbstractDisplayObject
		
		/**
		 * Inserts the XML layout of the elements
		 * @param	layout
		 * @param	applyNow
		 */
		function injectLayout(layout:XML, applyNow:Boolean = false):void
		
		/**
		 * 
		 */
		 function set addToStage(val:Boolean ):void
		 function get addToStage():Boolean
		
		/**
		 * 
		 */
		 function destroyAll():void
	}
	
}