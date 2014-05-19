package bridge.abstract 
{
	import bridge.abstract.transitions.IAbstractStateTransition;
	import flash.events.Event;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import flash.utils.Dictionary
	/**
	 * ...
	 * @author Alex Popescu
	 * 
	 * <p> The IAbstractEngine interface contains all the methods required by the client, except for the tightly coupled ones
	 * that are included in IEngine, an interface extending IAbstractEngine</p>
	 */
	public interface IAbstractEngine 
	{
		/**
		 * Initializes the engine.
		 * <b>Without propor init, the graphics will not be displayed</b>
		 */
		function initEngine():void
		
		/**
		 * Engine step
		 * @param	e
		 */
		function loop(e:Event):void
		
		/**
		 * Adds a new custom juggler. A juggler is an animator for movieclips
		 * @param	newJuggler
		 */
		function addJuggler(newJuggler:Object):void
		
		/**
		 * Removes a juggler
		 * @param	juggler
		 */
		function removeJuggler(juggler:Object):void
		
		
		/**
		 * 
		 * @return @see bridge.abstract.IAbstractSprite
		 */
		function requestSprite():IAbstractSprite
		
		/**
		 * 
		 * @return @see bridge.abstract.IAbstractButton
		 */
		function requestButton():IAbstractButton
		
		/**
		 * 
		 * @param	text
		 * @return IAbstractLabel
		 */
		function requestLabelFromTextfield(text:IAbstractTextField):IAbstractLabel
		
		/**
		 * 
		 * @param	textureClass
		 * @param	xml
		 */
		function registerBitmapFont(textureClass:Class, xml:XML):void
		
		/**
		 * 
		 * @return IAbstractVideo
		 */ 
		function requestVideo():IAbstractVideo
		
		/**
		 * 
		 * @return IAbstractLayerTransitionIn
		 */
		function requestLayerTransitionIN():IAbstractLayerTransitionIn
		
		/**
		 * 
		 * @return IAbstractLayerTransitionOut
		 */
		function requestLayerTransitionOUT():IAbstractLayerTransitionOut
		
		/**
		 * 
		 * @return @see bridge.abstract.IAbstractState
		 */
		function requestState():IAbstractState
		
		/**
		 * 
		 * @param	name
		 * @param	depth
		 * @param	layout
		 * @param	addedToStage
		 * @return IAbstractLayer
		 * @see bridge.abstract.IAbstractLayer
		 */
		function requestLayer (name:String, depth:Number, layout:XML, addedToStage:Boolean) : IAbstractLayer;
		
		/**
		 * 
		 * @param	newState @see bridge.abstract.IAbstractState
		 */
		function tranzitionToState(newState:IAbstractState, transitionEffect:IAbstractStateTransition = null):void
		
		/**
		 * 
		 */
		function get layers():Dictionary
		
		/**
		 * 
		 * @param	inputLayers 
		 * @see bridge.abstract.IAbstractLayerTransitionIn 
		 * @see bridge.abstract.IAbstractLayerTransitionOut 
		 */
		function initLayers(inputLayers:Dictionary, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null):void
		
		/**
		 * 
		 * @param	layer1
		 * @param	layer2
		 * @see bridge.abstract.IAbstractLayer 
		 */
		function swapLayers(layer1:IAbstractLayer, layer2:IAbstractLayer):void
		
		/**
		 * 
		 * @param	inLayers
		 * @param	outLayers
		 * @see bridge.abstract.IAbstractLayer 
		 * @see bridge.abstract.IAbstractLayerTransitionIn 
		 * @see bridge.abstract.IAbstractLayerTransitionOut 
		 */
		function updateLayers(inLayers:Vector.<IAbstractLayer> = null, outLayers:Vector.<IAbstractLayer> = null, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null):void
		
		/**
		 * 
		 * @param	atlasXml
		 * @param	atlasPng
		 */
		function addTextureAtlas(name:String, atlasXml:XML, atlasPng:Class):void
		
	}
	
}