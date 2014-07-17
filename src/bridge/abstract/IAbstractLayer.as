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
	 * 
	 * A layer can be injected with a layout and auto add the the items there. The layout itself is an XML file:
		 * 
	 * <Layout name="Paytable_layout"> <b>The main layout header</b>
	 *<Main> <b>The main contains more sub-layouts, but by default the engine will draw the Main one</b>
	 *<!--Layout Properties--> <b>A few properties, like name and position</b>
	 *		<Element name="props" type="layerProperties" layerX="0" layerY="0" depth="-1"/>
	 *	
	 * 	<!--Layout Background --> <b>A list of elements that will be drawn onto the layer</b>
	 *	<Element name="ui_background" resource="Paytable-Background" type = "image" onStage = "true" x="0" y="0" width="800" height="600" depth="0"/>
	 *	
	 *</Main>
	 *
	 *<!-- Subelement -->  <b>The Sub-layouts must be treated sepparately in your logic </b>
	 *<Pages>
	 *	<Layout name="Page0">
	 *		<Element name="props" type="layerProperties" layerX="0" layerY="0" depth="-1"/>
	 *	</Layout>
	 *</Pages>
	 *</Layout>
	 */
	/**
	 * A layer is basically a state (extending a DisplayObjectContainer) that is not managed by 3rd party engine.
	 */
	public interface IAbstractLayer extends IAbstractState
	{
		/**
		 * 
		 */
		function set redrawEnabled(val:Boolean):void
		function get redrawEnabled():Boolean
		
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