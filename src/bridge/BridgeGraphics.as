package bridge 
{
	import bridge.abstract.filters.IAbstractBlurFilter;
	import bridge.abstract.filters.IAbstractDropShadowFilter;
	import bridge.abstract.filters.IAbstractGlowFilter;
	import bridge.abstract.IAbstractBlitMask;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractImage;
	import bridge.abstract.IAbstractLayer;
	import bridge.abstract.IAbstractMask;
	import bridge.abstract.IAbstractMovie;
	import bridge.abstract.IAbstractSprite;
	import bridge.abstract.IAbstractState;
	import bridge.abstract.IAbstractTexture;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.IAbstractVideo;
	import bridge.abstract.transitions.IAbstractLayerTransitionIn;
	import bridge.abstract.transitions.IAbstractLayerTransitionOut;
	import bridge.abstract.transitions.IAbstractStateTransition;
	import bridge.abstract.ui.IAbstractButton;
	import bridge.abstract.IAbstractTextField;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.IAbstractSlider;
	import bridge.abstract.ui.IAbstractToggle;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
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
	 *  <p><b>Adding it to stage - this will trigger the Stage3D to init and dispatch the ready signal</b></p>
	 * 	addChild(_bridgeGraphics.engine as DisplayObject);
	 *  (_bridgeGraphics.signalsManager as ISignalsHub).addListenerToSignal(Signals.STARLING_READY, initEngine);	
	 * private function initEngine(signal:String, obj:Object):void
	 *	{
	 * 		...
	 *  }
	 * <p><b>Creating a new button</b></p>
	 * <p>var button:IAbstractButton = _bridgeGraphics.requestButton();</p>
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
	 * <p><b>Creating a new Movie Clip</b></p>
	 * <p>var mc:IAbstractMovie = _bridgeGraphics.requestMovie("Bet", 30);</p>
	 * 
	 * <p><b>Request a stored XML</b></p>
	 * <p>_bridgeGraphics.requestXML("layerLayout");</p>
	 * 
	 * <p><b>Request a new Layer</b></p>
	 * <p>var layersVO:IAbstractEngineLayerVO = _bridgeGraphics.requestLayersVO();</p>
	 * 
	 * E:\flex_sdk\bin>asdoc  -doc-sources "C:\Users\user 51\Documents\GitHub\isb_graph
	 * ics_bridge\src" -doc-sources "C:\Users\user 51\Documents\GitHub\isb_graphics_bri
	 * dge\lib" -main-title "ISBGraphicsBridge" -output "C:\Users\user 51\Desktop\test"
	  */
	public class BridgeGraphics implements IBridgeGraphics
	{
		
		public static const GRAPHICS_ENGINE:String = getQualifiedClassName+"graphicsEngine";
		public static const ASSETS_MANAGER:String = getQualifiedClassName+"assetsManager";
		public static const SIGNALS_MANAGER:String = getQualifiedClassName+"signalsManager";
		public static const POOL:String = getQualifiedClassName+"pool";
		public static const JUGGLER:String = getQualifiedClassName+"juggler";
		public static const SPACE:String = getQualifiedClassName+"space";
			
		public var display:Object;
		
		public var imageClass:Class;
		public var movieclipClass:Class;
		
		private var _injectedClasses:Dictionary = new Dictionary();
		private var _graphicsEngine:Object;
		private var _assetsManager:Object;
		private var _signalsManager:Object;
		private var _poolClass:Class;
		private var _juggler:Object;
		private var _space:Object;
		
		private var _pools:Dictionary = new Dictionary(true);
		
		/** Creates a new BridgeGraphics instance
		 * 
		 * @param	graphicsEngineClass		Entry Point of the actual graphics engine.
		 * @param	assetsManagerClass		Class for assets management. Sometimes the graphicsEngineClass
		 * 									may already contain such system
		 * @param	signalsManagerClass		Manager for signals
		 * @param	poolClass				Abstract pool for any kind of objects
		 * @param	juggler					Animator for different graphics engine
		 * 									<li>Pass null should the engine already have an animator,
		 * 									- e.g. display list </li>
		 * @param	space					Physics space
		 * 									<li>Pass null should the engine already have a physics space
		 * 									or you don't need physics in your project</li>
		 */
		public function BridgeGraphics( 
										canvasSize:Point,
										graphicsEngineClass:Class,
										assetsManagerClass:Class, 
										signalsManagerClass:Class, 
										poolClass:Class,
										juggler:Class = null,
										space:Class = null,
										debugMode:Boolean = false
									    ) 
		{
			_injectedClasses[GRAPHICS_ENGINE] = graphicsEngineClass;
			_injectedClasses[ASSETS_MANAGER] = assetsManagerClass;
			_injectedClasses[SIGNALS_MANAGER] = signalsManagerClass;
			_injectedClasses[POOL] = poolClass;
			_injectedClasses[JUGGLER] = juggler;
			_injectedClasses[SPACE] = space;
			
			_graphicsEngine = new graphicsEngineClass(graphicsEngineInited, canvasSize.x, canvasSize.y, "FULLSCREEN", debugMode) as IEngine;
			_assetsManager = new assetsManagerClass();
			_signalsManager = new signalsManagerClass();
			(_graphicsEngine as IEngine).injectAssetsManager(_assetsManager);
			(_graphicsEngine as IEngine).injectSignalsHub(_signalsManager);
			_poolClass = poolClass;
			_juggler = new juggler();
			_space = new space();
		}
		
		/** Callback from the engine to mark the succesful init of the engine.
		 * It will further dispatch a signal Signals.STARLING_READY
		 */
		public function graphicsEngineInited():void
		{	
			display = (_graphicsEngine as IEngine).engineStage;
			
			if (_juggler != null)
			{
				(_graphicsEngine as IEngine).addJuggler(_juggler)
			}
			
			if (space != null)
			{
				
			}
		}
		
		/**
		 * @return Returns the instance of the engine.
		 */
		public function get engine():IEngine
		{
			return _graphicsEngine as IEngine;
		}
		
		/**
		 * @return Returns a dictionary containing the list of injected classes. The defaults are:
		 * 			<li>graphicsEngine</li>
		 * 			<li>assetsManager</li>
		 * 			<li>signalsManager</li>
		 * 			<li>pool</li>
		 * 			<li>juggler</li>
		 * 			<li>space</li>
		 */
		public function get injectedClasses():Dictionary
		{
			return _injectedClasses
		}
		
		/**
		 * @return Returns the instance of the assets manager.
		 * 
		 * @TODO Build an interface for the assets manager
		 */
		public function get assetsManager():Object
		{
			return _assetsManager;
		}
		
		/**
		 * @return Returns the instance of the signals manager.
		 * 
		 * @TODO Build an interface for the signals manager.
		 */
		public function get signalsManager():Object
		{
			return _signalsManager;
		}
		
		/**
		 * @return Returns the class for the abstract pool.
		 */
		public function get poolClass():Class
		{
			return _poolClass;
		}
		
		/**
		 * @return Returns the class for the custom juggler
		 * 
		 * @TODO Build an interface for the juggler
		 */
		public function get juggler():Object
		{
			return _juggler;
		}
		
		/**
		 * @return Returns the class for the default juggler
		 * 
		 * @TODO Build an interface for the juggler
		 */
		public function get defaultJuggler():Object
		{
			return (_graphicsEngine as IEngine).juggler;
		}
		
		/**
		 * @return Returns the class for the physics space.
		 * 
		 * @TODO Build an interface for the space
		 */
		public function get space():Object
		{
			return _space;
		}
		
		/** Set a custom juggler.
		 * @param	val a generic object as juggler
		 * @TODO Build an interface for the juggler
		 */
		public function set juggler(val:Object):void
		{
			_juggler = juggler;
		}
		
		/** Set a custom space
		 * @param	val a generic object as space
		 * @TODO Build an interface for the space
		 */
		public function set space(val:Object):void
		{
			_space = space;
		}
		
		/** Retrieves a new texture from stored Atlas
		 * 
		 * @param	name
		 * @return IAbstractTexture
		 * @see bridge.abstract.IAbstractTexture
		 */
		public function requestTexture(name:String):IAbstractTexture
		{
			return (_graphicsEngine as IEngine).requestTexture(name) as IAbstractTexture;
		}
		
		/** Request an image
		 * 
		 * @param	name
		 * @return Returns an IAbstractImage
		 * @see bridge.abstract.IAbstractImage
		 */
		public function requestImage(name:String):IAbstractImage
		{
			return (_graphicsEngine as IEngine).requestImage(_assetsManager.getTexture(name), name) as IAbstractImage;
		}
		
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
		public function requestBlitMask(scrollImage:IAbstractImage, width:Number, height:Number, centerX:Number, centerY:Number, useBaseTexture:Boolean  = false):IAbstractBlitMask
		{
			return (_graphicsEngine as IEngine).requestBlitMask(scrollImage, width, height, centerX, centerY, useBaseTexture) as IAbstractBlitMask;
		}
		
		/**
		 * 
		 * @param	bitmapData
		 * @return
		 */
		public function requestImageFromBitmapData(bitmapData:BitmapData):IAbstractImage
		{
			return(_graphicsEngine as IEngine).requestImageFromBitmapData(bitmapData) as IAbstractImage;
		}
		
		/** Uses a prefix to build an animation from images in an atlas.
		 * 
		 * @param	prefix - retrieves all the images from an atlas using this prefix
		 * @param	fps - sets the frames per second that the movie clip will play at independently
		 * @return Returns an IAbstractMovie
		 * @see bridge.abstract.IAbstractMovie
		 */
		public function requestMovie(prefix:String, fps:uint = 24):IAbstractMovie
		{
			return (_graphicsEngine as IEngine).requestMovie(prefix, fps) as IAbstractMovie;
		}
		
		/**
		 * 
		 * @return IAbstractLayerTransitionIn
		 * @see bridge.abstract.transitions.IAbstractLayerTransitionIn
		 */
		public function requestLayerTransitionIN():IAbstractLayerTransitionIn
		{
			var inTransition:IAbstractLayerTransitionIn = (_graphicsEngine as IEngine).requestLayerTransitionIN();
			return inTransition;
		}
		
		/**
		 * 
		 * @return IAbstractVideo
		 * @see bridge.abstract.IAbstractVideo
		 */
		public function requestVideo():IAbstractVideo
		{
			var video:IAbstractVideo = (_graphicsEngine as IEngine).requestVideo();
			return video
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestDropShadowFilter():IAbstractDropShadowFilter
		{
			var obj:IAbstractDropShadowFilter = (_graphicsEngine as IEngine).requestDropShadowFilter();
			return obj
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestGlowFilter():IAbstractGlowFilter
		{
			var obj:IAbstractGlowFilter = (_graphicsEngine as IEngine).requestGlowFilter();
			return obj
		}
		
		/**
		 * 
		 * @return
		 */
		public function requestBlurFilter():IAbstractBlurFilter
		{
			var obj:IAbstractBlurFilter = (_graphicsEngine as IEngine).requestBlurFilter();
			return obj
		}
		
		/**
		 * 
		 * @param	textureClass
		 * @param	xml
		 */
		public function registerBitmapFont(textureBitmap:Bitmap, xml:XML, fontName:String = ""):String
		{
			return (_graphicsEngine as IEngine).registerBitmapFont(textureBitmap, xml);
		}
		
		/**
		 * 
		 * @param	text
		 * @return IAbstractLabel
		 * @see bridge.abstract.ui.IAbstractLabel
		 */
		public function requestLabelFromTextfield(text:IAbstractTextField, name:String = ""):IAbstractLabel
		{
			var label:IAbstractLabel = (_graphicsEngine as IEngine).requestLabelFromTextfield(text, name);
			return label;
		}
		
		/**
		 * 
		 * @return IAbstractLayerTransitionOut
		 * @see bridge.abstract.transitions.IAbstractLayerTransitionOut
		 */
		public function requestLayerTransitionOUT():IAbstractLayerTransitionOut
		{
			var outTransition:IAbstractLayerTransitionOut = (_graphicsEngine as IEngine).requestLayerTransitionOUT();
			return outTransition;
		}
		
		/** Build an empty sprite
		 * 
		 * @return Returns an IAbstractSprite
		 * @see bridge.abstract.IAbstractSprite
		 */
		public function requestSprite(name:String = ""):IAbstractSprite
		{
			return (_graphicsEngine as IEngine).requestSprite() as IAbstractSprite;
		}
		
		/** 
		 * Builds an empty button
		 * @return Returns IAbstractButton
		 * @see bridge.abstract.IAbstractButton
		 */
		public function requestButton(name:String = ""):IAbstractButton
		{
			return(_graphicsEngine as IEngine).requestButton(name) as IAbstractButton;
		}
		
		/**
		 * 
		 * @param	name
		 * @return
		 */
		public function requestToggleButton(name:String = ""):IAbstractToggle
		{
				return(_graphicsEngine as IEngine).requestToggleButton(name) as IAbstractToggle;
		}
		
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
		public function requestSlider(	thumbUpSkin:IAbstractImage,
														thumbDownSkin:IAbstractImage, 
														trackUpSkin:IAbstractImage, 
														trackDownSkin:IAbstractImage,
														backgroundSkin:IAbstractImage,
														label:IAbstractLabel,
														name:String = ""):IAbstractSlider
		{
			return (_graphicsEngine as IEngine).requestSlider(thumbUpSkin, thumbDownSkin, trackUpSkin, trackDownSkin, backgroundSkin, label)
		}
		
		/** Builds an empty state
		 * 
		 * @return Returns an IAbstractState
		 * @see bridge.abstract.IAbstractState
		 */
		public function requestState():IAbstractState
		{
			return (_graphicsEngine as IEngine).requestState() as IAbstractState;
		}
		
		/**
		 * Returns a new IAbstractTextField
		 * @param	width
		 * @param	height
		 * @param	text
		 * @param	fontName
		 * @param	fontSize
		 * @param	color
		 * @param	bold
		 * @return Textfield
		 * @see bridge.abstract.IAbstractTextField
		 */
		public function requestTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false):IAbstractTextField
		{
			var t:IAbstractTextField = (_graphicsEngine as IEngine).requestTextField(width, height, text, fontName, fontSize, color);
			return t;
		}
		
		/**
		 * 
		 * @param	maskedObject
		 * @param	mask
		 * @param	isAnimated
		 * @return IAbstractMask
		 * @see bridge.abstract.IAbstractMask
		 */
		public function requestMask(maskedObject:IAbstractDisplayObject, mask:IAbstractDisplayObject, isAnimated:Boolean = false):IAbstractMask
		{
			var mM:IAbstractMask = (_graphicsEngine as IEngine).requestMask(maskedObject, mask, isAnimated);
			return mM;
		}
		
		/**
		 * 
		 * @param name
		 * @return XML
		 */
		public function getXMLFromAssetsManager(name:String):XML
		{
			return _assetsManager.getXml(name);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	depth
		 * @param	layout
		 * @param	addedToStage
		 * @return IAbstractLayer
		 */
		public function requestLayer(name:String, depth:Number, layout:XML, addedToStage:Boolean):IAbstractLayer
		{
			return (_graphicsEngine as IEngine).requestLayer(name, depth, layout, addedToStage);
		}
		
		/**
		 * 
		 * @return IAbstractEngineLayerVO
		 * @see  bridge.abstract.IAbstractEngineLayerVO
		 */
		public function requestLayersVO():IAbstractEngineLayerVO
		{
			return (_graphicsEngine as IEngine).requestLayersVO();
		}
		
		/** 
		 * Makes the transition to a new state
		 * @param	newState 
		 * @see bridge.abstract.IAbstractState
		 * @param	transitionEffect
		 * @see bridge.abstract.transitions.IAbstractStateTransition
		 */
		public function tranzitionToState(newState:IAbstractState, transitionEffect:IAbstractStateTransition = null):void
		{
			(_graphicsEngine as IEngine).tranzitionToState(newState, transitionEffect);
		}
		
		/** 
		 * Adds child to the default Stage.
		 * @param	child
		 */
		public function addChild(child:Object):void
		{
			_graphicsEngine.engineStage.addChild(child);
		}
		
		 /**
		  * 
		  * @param	target
		  * @param	vo
		  */
		 public function addDropShadowFilter(target:IAbstractDisplayObject, vo:IAbstractDropShadowFilter):void
		 {
			_graphicsEngine.addDropShadowFilter(target, vo);
		 }
		 
		 	 /**
		  * 
		  * @param	target
		  * @param	vo
		  */
		 public function addGlowFilter(target:IAbstractDisplayObject, vo:IAbstractGlowFilter):void
		 {
				_graphicsEngine.addGlowFilter(target, vo);
		 }
		 
		 /**
		  * 
		  * @param	target
		  * @param	vo
		  */
		 public function addBlurFilter(target:IAbstractDisplayObject, vo:IAbstractBlurFilter):void
		 {
			  	_graphicsEngine.addBlurFilter(target, vo);
		 }
		
		/**
		 * 
		 * @param	inputLayers
		 * @param	inTransition
		 * @param	outTransition
		 */
		public function initLayers(container:IAbstractDisplayObjectContainer, inputLayers:Dictionary, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut = null):void
		{
			_graphicsEngine.initLayers(container, inputLayers, inTransition, outTransition);
		}
		
		/**
		 * 
		 * @param	layer
		 */
		public function drawLayerLayout(layer:IAbstractLayer):void
		{
			_graphicsEngine.drawLayerLayout(layer);
		}
		
		/**
		 * 
		 * @param	inLayers
		 * @param	outLayers
		 * @param	inTransition
		 * @param	outTransition
		 */
		public function updateLayers(container:IAbstractDisplayObjectContainer, inLayers:Vector.<IAbstractLayer> = null, outLayers:Vector.<IAbstractLayer> = null, inTransition:IAbstractLayerTransitionIn = null, outTransition:IAbstractLayerTransitionOut= null ):void
		{
			_graphicsEngine.updateLayers(container, inLayers, outLayers, inTransition, outTransition);
		}
		
		/**
		 * @return Returns layers Dictionary containing all the currently displayed layers
		 */
		public function get layers():Dictionary
		{
			return _graphicsEngine.layers;
		}
		
		/**
		 * 
		 */
		public function set layers(val:Dictionary):void
		{
			 _graphicsEngine.layers = val;
		}
		
		/** Swaps the depth of two layers.
		 * 
		 * @param	layer1
		 * @param	layer2
		 */
		public function swapLayers(layer1:IAbstractLayer, layer2:IAbstractLayer):void
		{
			_graphicsEngine.swapLayers(layer1, layer2);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	byteArray
		 */
		public function storeByteArray(name:String, byteArray:ByteArray):void
		{
			_assetsManager.addByteArray(name, byteArray);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	object
		 */
		public function storeObject(name:String, object:Object):void
		{
			_assetsManager.addObject(name, object);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	sound
		 */
		public function storeSound(name:String, sound:Sound):void
		{
			_assetsManager.addSound(name, sound)
		}
		
		/**
		 * 
		 * @param	name
		 * @return Sound
		 */
		public function retrieveSound(name:String):Sound
		{
			return _assetsManager.getSound(name);
		}
		
		/**
		 * @todo make abstract assets manager methods
		 * @param	name
		 * @param	texture
		 */
		public function storeTexture(name:String, texture:IAbstractTexture):void
		{
			_assetsManager.addTexture(name, texture)
		}
		
		/**
		 * 
		 * @param	name
		 * @param	xml
		 */
		public function storeXML(name:String, xml:XML):void
		{
			_assetsManager.addXml(name, xml)
		}
		
		/**
		 * 
		 */
		public function get currentContainer():IAbstractState
		{
			return _graphicsEngine.currentContainer;
		}
		
		/**
		 * 
		 * @param	atlasXml
		 * @param	atlasPng
		 */
		public function storeAtlas(name:String, atlasXml:XML, atlasPng:Class):void
		{
			_graphicsEngine.addTextureAtlas(name, atlasXml, atlasPng);
		}
		
		/** Pretty much destroys everything
		 * @todo double check the above
		 */
		public function cleanUp():void
		{
			display = null;
		
			imageClass = null;
			movieclipClass = null;
			
			for (var k:String in _injectedClasses)
			{
				_injectedClasses[k] = null
			}
			
			_injectedClasses = null;
			
			_assetsManager = null;
			
			_signalsManager = null;
			
			_poolClass = null;
			
			_juggler.purge();
			defaultJuggler.purge();
			_juggler = null;
			
			_space = null;
		
			(_graphicsEngine as IEngine).cleanUp();
			_graphicsEngine = null;
		}
	}

}