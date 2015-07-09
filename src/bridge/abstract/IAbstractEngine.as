package bridge.abstract 
{
	import bridge.abstract.console.IConsoleCommands;
	import bridge.abstract.effects.IAbstractParticleSystem;
	import bridge.abstract.filters.IAbstractBlurFilter;
	import bridge.abstract.filters.IAbstractDropShadowFilter;
	import bridge.abstract.filters.IAbstractGlowFilter;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import bridge.abstract.ui.IAbstractComboBox;
	import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
	import bridge.abstract.ui.IAbstractInputText;
	import bridge.abstract.ui.IAbstractSlider;
	import bridge.abstract.ui.IAbstractToggle;
	import flash.display.Sprite;
	import flash.display3D.Context3D;
	import flash.events.Event;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.ui.IAbstractLabel;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	/**
	 * ...
	 * @author Alex Popescu
	 * 
	 * <p> The IAbstractEngine interface contains all the methods required by the client, except for the tightly coupled ones
	 * that are included in IEngine, an interface extending IAbstractEngine</p>
	 */
	/**
	 * All the methods required by the client, except for the tightly coupled ones
	 * that are included in IEngine, an interface extending IAbstractEngine
	 */
	public interface IAbstractEngine 
	{
		/**
		 * 
		 * @param	assetsManager
		 */
		function injectAssetsManager(assetsManager:Object):void
		
		/**
		 * 
		 * @param	signalsHub
		 */
		function injectSignalsHub(signalsHub:Object):void
		 
		/**
		 * Inits the default signals for outter communication
		 */
		function initSignals():void
		
		/**
		 * 
		 */
		function set alwaysVerbose(val:Boolean):void
		
		/**
		 * 
		 */
		function get is3D():Boolean 
		function set is3D(value:Boolean):void 
		
		/**
		 * Returns a Flare scene3D object(Eg. bridgeGraphics.scene3D as scene3D)
		 */
		function get scene3D():Object 
		
		/**
		 * Returns a IConsoleCommands
		 */
		function get consoleCommands():IConsoleCommands 
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		function requestTexture(name:String):IAbstractTexture
		
		/**
		 * 
		 * @param	texture
		 * @return IAbstractImage
		 * @see bridge.abstract.IAbstractImage
		 */
		function requestImage(texture:Object, name:String = ""):IAbstractImage
		
		/**
		 * 
		 * @param	image
		 * @param	color
		 */
		 function colorizeImage(image:IAbstractImage, color:uint):void
		
		/**
		 * 
		 * @param	scrollImage
		 * @param	width
		 * @param	height
		 * @param	centerX
		 * @param	centerY
		 * @param	useBaseTexture
		 * @return
		 */
		function requestBlitMask(scrollImage:IAbstractImage, width:Number, height:Number, centerX:Number, centerY:Number, useBaseTexture:Boolean  = false):IAbstractBlitMask
		
		/**
		 * 
		 * @param	bitmapData
		 * @return
		 */
		function requestImageFromBitmapData(bitmapData:BitmapData):IAbstractImage
		
		/**
		 * 
		 * @param	vec
		 * @param	atlasName
		 */
		function batchBitmapData(vec:Vector.<BitmapData>,  names:Vector.<String>, atlasName:String):void
		
		/**
		 * 
		 * @param	prefix
		 * @param	fps
		 * @return 	a movie clip
		 * @see bridge.abstract.IAbstractMovie
		 */
		function requestMovie(prefix:String, fps:uint = 24):IAbstractMovie
		
		/**
		 * 
		 * @param	frames
		 * @param	fps
		 * @return
		 */
		function requestMovieFromFrames(frames:Vector.<IAbstractImage>, fps:uint = 24):IAbstractMovie
		
		/**
		 * 
		 * @param	width
		 * @param	height
		 * @param	text
		 * @param	fontName
		 * @param	fontSize
		 * @param	color
		 * @param	bold
		 * @return IAbstractTextField
		 * @see bridge.abstract.IAbstractTextField
		 */
		function requestTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false,  nativeFiltersArr:Array = null):IAbstractTextField
		
		/**
		 * 
		 * @param	width
		 * @param	height
		 * @param	text
		 * @param	fontName
		 * @param	fontSize
		 * @param	color
		 * @return
		 */
		function requestInputTextField(signalsManager:Object, width:int, height:int, text:String = "", fontName:String="Verdana", fontSize:Number=12, color:uint=0):IAbstractInputText
		
		/**
		 * 
		 * @param	maskedObject
		 * @param	mask
		 * @param	isAnimated
		 * @return IAbstractMask
		 * @see bridge.abstract.IAbstractMask
		 */
		function requestMask(maskedObject:IAbstractDisplayObject, mask:IAbstractDisplayObject, isAnimated:Boolean = false):IAbstractMask
		
		/**
		 * 
		 * @return IAbstractEngineLayerVO
		 * @see bridge.abstract.IAbstractEngineLayerVO
		 */
		function requestLayersVO():IAbstractEngineLayerVO;
		
		/**
		 * @TODO build a abstractization for Juggler
		 * @return Returns the engine Juggler
		 */
		function get juggler_():Object
		
		/**
		 * Returns the instance of the default stage used by the engine.
		 * <b>!warning! this will add children on top of any existing state or layer, including the performance stats</b>
		 * @TODO build a abstractization for Stage
		 * @return Returns the engine stage
		 */
		function get engineStage():Object
		
		/**
		 * 
		 */
		function cleanUp():void
		
		/**
		 * Initializes the engine.
		 * <b>Without propor init, the graphics will not be displayed</b>
		 */
		function initEngine(sharedContext:Context3D = null):void
		
		/**
		 * 
		 * @param	obj
		 */
		function returnToPool(obj:Object):void
		
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
		function requestSprite(name:String = ""):IAbstractSprite
		
		/**
		 * 
		 * @param	target
		 * @return
		 */
		function requestGraphics(target:IAbstractDisplayObjectContainer):IAbstractGraphics
		
		/**
		 * 
		 * @return @see bridge.abstract.IAbstractButton
		 */
		function requestButton(name:String = ""):IAbstractButton
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		function requestToggleButton(name:String = ""):IAbstractToggle
		
		/**
		 * 
		 * @param	dataProvider
		 * @param	width
		 * @param	height
		 * @param	backgroundImage
		 * @param	font
		 * @return
		 */
		function requestComboBox(dataProvider:Vector.<IAbstractComboBoxItemRenderer>, width:Number, height:Number, backgroundImage:IAbstractImage, font:String):IAbstractComboBox
		
		/**
		 * 
		 * @param	name
		 * @param	thumbUpSkin
		 * @param	thumbDownSkin
		 * @param	trackUpSkin
		 * @param	trackDownSkin
		 * @param	backgroundSkin
		 * @param	label
		 * @return
		 */
		 function requestSlider(			thumbUpSkin:IAbstractImage,
														thumbDownSkin:IAbstractImage, 
														trackUpSkin:IAbstractImage, 
														trackDownSkin:IAbstractImage,
														backgroundSkin:IAbstractImage,
														label:IAbstractLabel,
														name:String = ""):IAbstractSlider
		
		/**
		 * 
		 * @param	text
		 * @return IAbstractLabel
		 */
		function requestLabelFromTextfield(text:IAbstractTextField, name:String=""):IAbstractLabel
		
		/**
		 * 
		 * @param	textureClass
		 * @param	xml
		 */
		function registerBitmapFont(textureBitmap:Bitmap, xml:XML, fontName:String = ""):String
		
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
		function set layers(val:Dictionary):void
		
		/**
		 * 
		 * @param	inputLayers 
		 * @see bridge.abstract.IAbstractLayerTransitionIn 
		 * @see bridge.abstract.IAbstractLayerTransitionOut 
		 */
		function initLayers(container:IAbstractDisplayObjectContainer, inputLayers:Dictionary, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null):void
		
		/**
		 * 
		 * @param	layer
		 */
		function drawLayerLayout(layer:IAbstractLayer):void
		
		/**
		 * 
		 * @return
		 */
		function requestDropShadowFilter():IAbstractDropShadowFilter
		
		/**
		 * 
		 * @return
		 */
		function requestGlowFilter():IAbstractGlowFilter
		
		/**
		 * 
		 * @return
		 */
		function requestBlurFilter():IAbstractBlurFilter
		
		/**
		 * 
		 * @param	rect
		 * @param	scale
		 * @return
		 */
		function requestScreenshot(rect:Rectangle, scale:Number=1.0):BitmapData
		
		/**
		 * 
		 * @param	target
		 * @param	filter
		 */
		function addFragmentFilter(target:IAbstractDisplayObject, filter:Object):void
		/**
		 * 
		 * @param	target
		 * @param	vo
		 */
		function addDropShadowFilter(target:IAbstractDisplayObject, vo:IAbstractDropShadowFilter):void
		
		/**
		 * 
		 * @param	target
		 * @param	vo
		 */
		function addGlowFilter(target:IAbstractDisplayObject, vo:IAbstractGlowFilter):void
		
		/**
		 * 
		 * @param	target
		 * @param	vo
		 */
		function addBlurFilter(target:IAbstractDisplayObject, vo:IAbstractBlurFilter):void
		
		/**
		 * 
		 * @param	target
		 * @param	pixelSize
		 */
		function addPixelationFilter(target:IAbstractDisplayObject, pixelSize:int):void
		
		/**
		 * 
		 * @param	target
		 * @param	size
		 * @param	scale
		 * @param	angleInRadians
		 */
		function addNewsPaperFilter(target:IAbstractDisplayObject, size:int, scale:int, angleInRadians:Number):void
		
		/**
		 * 
		 * @param	target
		 */
		 function clearFilter(target:IAbstractDisplayObject):void
		
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
		function updateLayers(container:IAbstractDisplayObjectContainer, inLayers:Vector.<IAbstractLayer> = null, outLayers:Vector.<IAbstractLayer> = null, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null):void
		
		/**
		 * 
		 */
		function get nativeDisplay():Sprite
		
		/**
		 * 
		 */
		function get currentContainer():IAbstractState
		
		/**
		 * 
		 * @param	atlasXml
		 * @param	atlasPng
		 */
		function addTextureAtlas(name:String, atlasXml:XML, atlasPng:Class):void
		
		/**
		 * 
		 * @param	name
		 * @param	atlasXml
		 * @param	ATFByteArray
		 */
		function addATFAtlasByteArray(name:String, atlasXml:XML, ATFByteArray:ByteArray):void
		
		/**
		 * 
		 * @param	localPoint
		 * @param	forTouch
		 * @return
		 */
		function isHit (localPoint:Point, forTouch:Boolean = false) : Boolean
		
		/**
		 * 
		 * @param	configXML
		 * @param	imageSource
		 * @return
		 */
		 function requestParticleSystem(configXML:XML, imageSource:IAbstractImage):IAbstractParticleSystem
		 
		 /**
		  * 
		  * @param	configXML
		  * @param	imageSource
		  * @param	atlasXML
		  * @return
		  */
		 function requestAdvancedParticleSystem(configXML:XML, imageSource:IAbstractImage, atlasXML:XML = null):IAbstractParticleSystem
		 
		 /**
		  * 
		  */
		 function pauseRender():void
		 
		 /**
		  * 
		  */
		 function resumeRender():void
		 
		 /**
		  * 
		  * @return
		  */
		 function  contextStatus():Boolean
		
	}
	
}