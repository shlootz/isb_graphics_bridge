package bridge 
{
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import flash.utils.Dictionary;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractState;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.IAbstractVideo;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.IAbstractTexture;
	import bridge.abstract.IAbstractMask;
	import bridge.abstract.IAbstractBlitMask;
	import bridge.abstract.ui.IAbstractLabel;
	import flash.utils.ByteArray;
	import flash.media.Sound;
	import flash.display.BitmapData;
	
	/**
	 * ...
	 * @author Alex Popescu
	 * @version 1.0.0
	 */
	/**
	 * <p>The BridgeGraphics class represents the linkage between the logic end of the app and the actual
	 * display. The display itself can differ: DisplayList, Stage3D, etc. It uses a collection of abstract
	 * interfaces that make the actual liasion.</p>
	 * 
	 * <p>It is recommended to store the Bridge instance as a member variable, to make sure
     * that the Garbage Collector does not destroy it. This is how to instatiate it:</p>
	 * 
	 * <pre>var bridge:IBridgeGraphics = new BridgeGraphics(GraphicsEngine,AssetManager,SignalsHub,AbstractPool,Juggler,Space);</pre>
	 * 
	 * <p>The first paramater is the class of the actual Graphics Engine. The second paramater is the
	 * class for the assets manager - sometimes the assets manager can be included in the graphics
	 * engine itself, eg. StarlingEngine. The third paramater is the signals manager class that makes
	 * the entire communication throughout the graphics bridge and engine. The forth paramater is the
	 * class for an abstract pool. The fifth paramater is the juggler - it is a container for animations.
	 * The sixth paramater is the space for physics.</p>
	 * 
	 * <p>The bridge is actually injected with the above so that there is no direct connection with the 
	 * engine, making the access to methods allowed only via interfaces</p>
	 * 
	 * <p>The bridge makes all the necessary instantiations and dispatches a native signal when the system
	 * is up and running - e.g. for StarlingEngine: Signals :: trying to dispatch GEstarlingReady</p>
	 * 
	 * <p><b>Examples</b></p>
	 * <p>private var _bridgeGraphics:IBridgeGraphics = new BridgeGraphics(
	 *																	StarlingEngine,
	 *																	starling.utils.AssetManager,
	 *																	signals.SignalsHub,
	 *																	abstract.AbstractPool,
	 *																	starling.animation.Juggler,
	 *																	nape.space.Space
	 *																	);</p>
	 * 
	 * <p><b>Adding it to stage - this will trigger the Stage3D to init and dispatch the ready signal</b></p>
	 * 	addChild(_bridgeGraphics.engine as DisplayObject);
	 *  (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, initEngine);	
	 * private function initEngine(signal:String, obj:Object):void
	 *	{
	 * 		...
	 *  }
	 * 
	 * <p><b>Creating a new button</b></p>
	 * <p>var button:IAbstractButton = _bridgeGraphics.requestButton();</p>
	 * <p>button.addEventListener(BridgeEvents.TRIGGERED, button_triggeredHandler);</p>
	 * private function button_triggeredHandler(e:Object):void
	 * {
	 *   (BridgeEvents.extractCurrentTarget(e) as IAbstractButton)
     *  }  
	 * <p><b>Coupleing a listener to the button</b></p>
	 * <p>(_bridgeGraphics.signalsManager as SignalsHub).addListenerToSignal(Signals.GENERIC_BUTTON_PRESSED, buttonPressed);</p>
	 * private function buttonPressed(type:String, event:Object):void
	 *	{
	 *		trace("Caught signal "+type+" "+event)
	 *	}
	 * 
	 * <p><b>Creating a new textField</b></p>
	 * <p>var t:IAbstractTextField = _bridgeGraphics.requestTextField(150, 30, "Yaaaay", "Times", 30);</p>
	 * 
	 * <p><b>Creating a new Sprite</b></p>
	 * <p>var sprite:IAbstractSprite = _bridgeGraphics.requestSprite();</p>
	 * 
	 * <p><b>Creating a new Image</b></p>
	 * <p>var img:IAbstractImage = _bridgeGraphics.requestImage("Background");</p>
	 * 
	 * <p><b>Creating a new Image using custom bitmap data</b></p>
	 * <p>var s2:flash.display.Shape = new flash.display.Shape();</p>
	 * <p>s2.graphics.beginFill(0xff0000, 1);</p>
	 *	<p>s2.graphics.drawCircle(40, 40, 40);</p>
	 *	<p>s2.graphics.endFill();</p>
	 *	<p>var bmpData:BitmapData = new BitmapData(100,100, true, 0x000000);</p>
	 *	<p>bmpData.draw(s2);</p>
	 * <p>_bridgeGraphics.addChild(_bridgeGraphics.requestImageFromBitmapData(bmpData));</p>
	 * 
	 * <p><b>Creating a new Movie Clip</b></p>
	 * <p>var mc:IAbstractMovie = _bridgeGraphics.requestMovie("Bet", 30);</p>
	 * 
	 * <p><b>Request a stored XML</b></p>
	 * <p>_bridgeGraphics.requestXML("layerLayout");</p>
	 * 
	 * <p><b>Request a new Layer</b></p>
	 * <p>var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();</p>
	 * <p>var newLayer:IAbstractLayer = _bridgeGraphics.requestLayer("Tzeapa", 0, x, true);</p>
	 * <p>inLayers.push(newLayer);</p>
	*	<p>_bridgeGraphics.updateLayers(inLayers, null, null, null);</p>
	* 
	* <p><b>Requesting a new mask</b></p>
	* <p>var m:IAbstractMask = _bridgeGraphics.requestMask(_bridgeGraphics.requestImage("Background"), _bridgeGraphics.requestImage("Auto-Spin-Button-Down"));</p>
	* <p>m.name = "masca";</p>
	* <p>_bridgeGraphics.addChild(m);</p>
	* 
	* <p><b>Requesting a new BlitMask</b></p>
	* <p>private var scroll:IAbstractBlitMask;</p>
	*	
	*	<p>private function testScrollingImage():void</p>
	*	<p>{</p>
	*		
	*	<p>var scrollingImg:IAbstractImage = _bridgeGraphics.requestImage("Numbers");</p>
	*		 
	*	<p>scroll = _bridgeGraphics.requestBlitMask(scrollingImg, 600, 600, 300, 300);</p>
	*		
	*	<p>_bridgeGraphics.addChild(scroll);</p>
	*		
	*	<p>addEventListener(flash.events.Event.ENTER_FRAME, onUpdate);</p>
	*	<p>}</p>
	*	
	*	<p>private function onUpdate(e:flash.events.Event):void</p>
	*	<p>{</p>
	*	<p>scroll.tilesOffsetY --;</p>
	*	<p>scroll.tilesOffsetX ++;</p>
	*	<p>}</p>
	 */
	public interface IBridgeGraphics
	{
		/** Callback from the engine to mark the succesful init of the engine.
		 * It will further dispatch a signal Signals.STARLING_READY
		 */
		function graphicsEngineInited():void
		/**
		 * @return Returns the instance of the engine.
		 */
		
		function get engine():IEngine
		/**
		 * @return Returns a dictionary containing the list of injected classes. The defaults are:
		 * 			<li>graphicsEngine</li>
		 * 			<li>assetsManager</li>
		 * 			<li>signalsManager</li>
		 * 			<li>pool</li>
		 * 			<li>juggler</li>
		 * 			<li>space</li>
		 */
		function get injectedClasses():Dictionary
		
		/**
		 * @return Returns the instance of the assets manager.
		 * 
		 * @TODO Build an interface for the assets manager
		 */
		function get assetsManager():Object
		
		/**
		 * @return Returns the instance of the signals manager.
		 * 
		 * @TODO Build an interface for the signals manager.
		 */
		function get signalsManager():Object
		
		/**
		 * @return Returns the class for the abstract pool.
		 */
		function get poolClass():Class
		
		/**
		 * Sets a new juggler
		 * 
		 * @TODO Build an interface for the juggler
		 */
		function set juggler(val:Object):void
		
		/**
		 * @return Returns the class for the custom juggler
		 * 
		 * @TODO Build an interface for the juggler
		 */
		function get juggler():Object
		
		/**
		 * @return Returns the class for the default juggler
		 * 
		 * @TODO Build an interface for the juggler
		 */
		function get defaultJuggler():Object
		
		/**
		 * @return Returns the class for the physics space.
		 * 
		 * @TODO Build an interface for the space
		 */
		function get space():Object
		
		/** Sets a custom physics space
		 * 
		 * @TODO Build an interface for the space
		 */
		function set space(val:Object):void
		
		/** 
		 * Retrieves a new texture from stored Atlas
		 * @param	name
		 * @return IAbstractTexture
		 * @see bridge.abstract.IAbstractTexture
		 */
		function requestTexture(name:String):IAbstractTexture
		
		/**
		 * 
		 * @param	text
		 * @param	name
		 * @return
		 */
		 function requestLabelFromTextfield(text:IAbstractTextField, name:String = ""):IAbstractLabel
		
		/** 
		 * Creates a new  image
		 * @param	name
		 * @return Returns an IAbstractImage
		 * @see bridge.abstract.IAbstractImage
		 */
		function requestImage(name:String):IAbstractImage
		
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
		 * Draw custom bitmap data onto an image
		 * @param	bitmapData
		 * @return
		 */
		function requestImageFromBitmapData(bitmapData:BitmapData):IAbstractImage
		
		/** Uses a prefix to build an animation from images in an atlas.
		 * 
		 * @param	prefix - retrieves all the images from an atlas using this prefix
		 * @param	fps - sets the frames per second that the movie clip will play at independently
		 * @return Returns an IAbstractMovie
		 * @see bridge.abstract.IAbstractMovie
		 */
		function requestMovie(prefix:String, fps:uint = 24):IAbstractMovie
		
		/**
		 * Creates a new transition animation
		 * @return
		 */
		function requestLayerTransitionIN():IAbstractLayerTransitionIn
		
		/**
		 * Creates a new transition animation
		 * @return
		 */
		function requestLayerTransitionOUT():IAbstractLayerTransitionOut
		
		/**
		 * Creates a new layer.
		 * @param	name
		 * @param	depth
		 * @param	layout
		 * @param	addedToStage
		 * @return IAbstractLayer
		 */
		function requestLayer(name:String, depth:Number, layout:XML, addedToStage:Boolean):IAbstractLayer
		
		/**
		 * Creates a new video.
		 * @return
		 */
		function requestVideo():IAbstractVideo
		
		/**
		 * Registers the bitmap font for further use. The font will be accessible via its name.
		 * @param	textureClass
		 * @param	xml
		 */
		function registerBitmapFont(textureClass:Class, xml:XML):String
		
		/** Build an empty sprite
		 * 
		 * @return Returns an IAbstractSprite
		 * @see bridge.abstract.IAbstractSprite
		 */
		function requestSprite(name:String = ""):IAbstractSprite
		
		/** Build an empty button
		 * 
		 * @return Returns an IAbstractButton
		 * @see bridge.abstract.IAbstractButton
		 */
		function requestButton(name:String = ""):IAbstractButton
		
		/**
		 * Builds a new container that contains both the masked object and the mask itself.
		 * @param	maskedObject
		 * @param	mask
		 * @param	isAnimated
		 * @return
		 */
		function requestMask(maskedObject:IAbstractDisplayObject, mask:IAbstractDisplayObject, isAnimated:Boolean = false):IAbstractMask
		
		/** Builds an empty state
		 * 
		 * @return Returns an IAbstractState
		 * @see bridge.abstract.IAbstractState
		 */
		function requestState():IAbstractState
		
		/** Return a a new textField IAbstractTextField
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
		function requestTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false):IAbstractTextField
		
		/**
		 * Makes a request to build a new IAbstractEngineLayerVO
		 * @return IAbstractEngineLayerVO
		 * @see bridge.abstract.IAbstractEngineLayerVO
		 */
		function requestLayersVO():IAbstractEngineLayerVO
		
		/**
		 * Returns a store XML from the Assets Manager
		 * @param	name
		 * @return XML
		 */
		function getXMLFromAssetsManager(name:String):XML
		
		/** 
		 * Makes the transition to a new state
		 * @param	newState 
		 * @see bridge.abstract.IAbstractState
		 * @param	transitionEffect 
		 * @see bridge.abstract.transitions.IAbstractStateTransition
		 */
		function tranzitionToState(newState:IAbstractState, transitionEffect:IAbstractStateTransition = null):void
		
		/**
		 * Init the layers
		 * @param	inputLayers
		 * @param	inTransition
		 * @param	outTransition
		 */
		function initLayers(inputLayers:Dictionary, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null):void
		
		/** 
		 * Receives 2 vectors of IAbstractLayer and updates the layers in the current state
		 * @param	inLayers
		 * @param	outLayers
		 * @see  bridge.abstract.IAbstractLayer and updates the layers in the current state
		 */
		function updateLayers(inLayers:Vector.<IAbstractLayer> = null, outLayers:Vector.<IAbstractLayer> = null, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null ):void
		
		/** 
		 * Swaps layer1 with layer2
		 * @param	layer1 
		 * @see  bridge.abstract.IAbstractLayer
		 * @param	layer2 
		 * @see  bridge.abstract.IAbstractLayer
		 */
		function swapLayers(layer1:IAbstractLayer, layer2:IAbstractLayer):void
		
		/**
		 * @return Returns a Dictionary containing all the current state layers
		 */
		function get layers():Dictionary
		
		/** 
		 * Adds child to the default Stage. Please note that this will put the child on the top index.
		 * It is preferable to add new children to states or layers.
		 * @param	child
		 */
		function addChild(child:Object):void
		
		/**
		 * Saves a byte array in Assets Manager
		 * @param	name
		 * @param	byteArray
		 */
		function storeByteArray(name:String, byteArray:ByteArray):void
		
		/**
		 * Saves an object in Assets Manager
		 * @param	name
		 * @param	object
		 */
		function storeObject(name:String, object:Object):void
		
		/**
		 * Saves a new sound in Assets Manager
		 * @param	name
		 * @param	sound
		 */
		function storeSound(name:String, sound:Sound):void
		
		/**
		 * Saves a new texture in Assets Manager
		 * @param	name
		 * @param	texture
		 */
		function storeTexture(name:String, texture:IAbstractTexture):void
		
		/**
		 * Saves a new atlas in the Assets Manager
		 * @param	atlasXml
		 * @param	atlasPng
		 */
		function storeAtlas(name:String, atlasXml:XML, atlasPng:Class):void
		
		/**
		 * 
		 */
		function cleanUp():void
	}
	
}