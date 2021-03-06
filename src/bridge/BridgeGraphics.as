package bridge 
{
	import bridge.abstract.console.IConsoleCommands;
	import bridge.abstract.effects.IAbstractParticleSystem;
	import bridge.abstract.filters.IAbstractBlurFilter;
	import bridge.abstract.filters.IAbstractDropShadowFilter;
	import bridge.abstract.filters.IAbstractGlowFilter;
	import bridge.abstract.IAbstractBlitMask;
	import bridge.abstract.IAbstractDisplayObject;
	import bridge.abstract.IAbstractDisplayObjectContainer;
	import bridge.abstract.IAbstractEngineLayerVO;
	import bridge.abstract.IAbstractGraphics;
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
	import bridge.abstract.ui.IAbstractComboBox;
	import bridge.abstract.ui.IAbstractComboBoxItemRenderer;
	import bridge.abstract.ui.IAbstractInputText;
	import bridge.abstract.ui.IAbstractLabel;
	import bridge.abstract.ui.IAbstractSlider;
	import bridge.abstract.ui.IAbstractToggle;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
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
		public static var isVerbose:Boolean = false;
		
		public static const GRAPHICS_ENGINE:String = getQualifiedClassName+"graphicsEngine";
		public static const ASSETS_MANAGER:String = getQualifiedClassName+"assetsManager";
		public static const SIGNALS_MANAGER:String = getQualifiedClassName+"signalsManager";
		public static const POOL:String = getQualifiedClassName+"pool";
		public static const JUGGLER:String = getQualifiedClassName+"juggler";
		//public static const SPACE:String = getQualifiedClassName+"space";
			
		public var display:Object;
		
		public var imageClass:Class;
		public var movieclipClass:Class;
		
		private var _injectedClasses:Dictionary = new Dictionary();
		private var _graphicsEngine:Object;
		private var _assetsManager:Object;
		private var _signalsManager:Object;
		private var _poolClass:Class;
		private var _juggler:Object;
		//private var _space:Object;
		
		private var _pools:Dictionary = new Dictionary(true);
		
		private var _bitmapDataFallBack:BitmapData = new BitmapData(50, 50, true, 0x000000);
		
		private var _alwaysVerbose:Boolean = false;
		
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
										//space:Class = null,
										debugMode:Boolean = false,
										alwaysVerbose:Boolean = false
									    ) 
		{
			_injectedClasses[GRAPHICS_ENGINE] = graphicsEngineClass;
			_injectedClasses[ASSETS_MANAGER] = assetsManagerClass;
			_injectedClasses[SIGNALS_MANAGER] = signalsManagerClass;
			_injectedClasses[POOL] = poolClass;
			_injectedClasses[JUGGLER] = juggler;
			//_injectedClasses[SPACE] = space;
			
			_graphicsEngine = new graphicsEngineClass(graphicsEngineInited, canvasSize.x, canvasSize.y, "FULLSCREEN", debugMode) as IEngine;
			(_graphicsEngine as IEngine).alwaysVerbose = alwaysVerbose;
			_assetsManager = new assetsManagerClass();
			_signalsManager = new signalsManagerClass();
			(_graphicsEngine as IEngine).injectAssetsManager(_assetsManager);
			(_graphicsEngine as IEngine).injectSignalsHub(_signalsManager);
			_poolClass = poolClass;
			_juggler = new juggler();
			//_space = new space();
			_alwaysVerbose = alwaysVerbose;
			
			BridgeGraphics.isVerbose = _alwaysVerbose;
		}
		
		public function returnToPool(obj:Object):void
		{
			(_graphicsEngine as IEngine).returnToPool(obj);
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
			
			//if (space != null)
			//{
				//
			//}
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
		public function get juggler_():Object
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
			return (_graphicsEngine as IEngine).juggler_;
		}
		
		/**
		 * @return Returns the class for the physics space.
		 * 
		 * @TODO Build an interface for the space
		 */
		//public function get space():Object
		//{
			//return _space;
		//}
		
		/** Set a custom juggler.
		 * @param	val a generic object as juggler
		 * @TODO Build an interface for the juggler
		 */
		public function set juggler(val:Object):void
		{
			_juggler = juggler_;
		}
		
		/** Set a custom space
		 * @param	val a generic object as space
		 * @TODO Build an interface for the space
		 */
		//public function set space(val:Object):void
		//{
			//_space = space;
		//}
		
		/**
		 * IConsoleCommands
		 */
		public 	function get consoleCommands():IConsoleCommands 
		{
			return (_graphicsEngine as IEngine).consoleCommands;
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
		public function requestImage(name:String, scaleFromAtlas:Boolean = false):IAbstractImage
		{
			var textureObject:Object = (_assetsManager.getTexture(name));
			var img:IAbstractImage;
			
			if (textureObject != null)
			{
				img =  (_graphicsEngine as IEngine).requestImage(textureObject, name) as IAbstractImage;
				if (scaleFromAtlas)
				{
					img.scaleX = img.scaleY = searchScale(name);
				}
			}
			else
			{
				if(BridgeGraphics.isVerbose) trace("WARNING :: BridgeGraphics :: requestImage :: name: " + name+" cannot be found -> fallback to transparent bitmapData");
				img = (_graphicsEngine as IEngine).requestImageFromBitmapData(_bitmapDataFallBack);
				img.name = "imgFallback" + Math.random() * 999999;
			}
			
			return img;
		}
		
		/**
		 * 
		 * @param	id
		 * @return
		 */
		private function searchScale(id:String):Number
		{
			var autoScale:Number = 1;
			/*var elementsList:XML;
			var xl:XMLList ;
			
			var spriteSheetsNames:Vector.<String> = _assetsManager.getXmlNames();
			
			for (var i:uint = 0; i < spriteSheetsNames.length; i++ )
			{
				elementsList = _assetsManager.getXml(spriteSheetsNames[i]);
				if (elementsList.name() == "TextureAtlas")
				{
					xl = elementsList..*.(@name == String(id));
					if (xl.toXMLString() != "")
					{
						 autoScale = xl.attribute("scale");
					}
				}
			}
			
			if (autoScale == 0)
			{
				autoScale = 1;
			}*/
			
			if (id.indexOf("x@0.5") >= 0)
			{
				autoScale = .5;
			}
			else {
				if (id.indexOf("x@1.5") >= 0) {
						autoScale = 1.5;
				}
				else
				{
					if (id.indexOf("x@2") >= 0) {
						autoScale = 2;
					}
				}
			}
			
			return autoScale;
		}
		
		/** Adds and blends a color on an IAbstractImage 
		 *  Please note that IAbstractMovieClip extends IAbstractImage, colorize works for any extension of IAbstractImage
		 * @param	image
		 * @param	color
		 */
		 public function colorizeImage(image:IAbstractImage, color:uint):void
		 {
			 (_graphicsEngine as IEngine).colorizeImage(image, color);
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
		
		/**
		 * 
		 * @param	characters
		 * @param	font
		 * @param	fontSize
		 * @param	bold
		 * @param	italic
		 * @param	charMarginX
		 * @param	fontCustomID
		 */
		public function batchFont(characters:String = "", font:String = "Verdana", fontSize:uint = 12, bold:Boolean = false, italic:Boolean = false, charMarginX:int = 0, fontCustomID:String = ""):void
		 {
			 (_graphicsEngine as IEngine).batchFont(characters, font, fontSize, bold, italic, charMarginX, fontCustomID);
		 }
		
		/**
		 * 
		 * @param	bitmapData
		 * @return
		 */
		public function batchBitmapData(vec:Vector.<BitmapData>,  names:Vector.<String>, atlasName:String):void
		{
			(_graphicsEngine as IEngine).batchBitmapData(vec, names, atlasName);
		}
		
		/** Uses a prefix to build an animation from images in an atlas.
		 * 
		 * @param	prefix - retrieves all the images from an atlas using this prefix
		 * @param	fps - sets the frames per second that the movie clip will play at independently
		 * @return Returns an IAbstractMovie
		 * @see bridge.abstract.IAbstractMovie
		 */
		public function requestMovie(prefix:String, fps:uint = 24, scaleFromAtlas:Boolean = false):IAbstractMovie
		{
			var mc:IAbstractMovie = (_graphicsEngine as IEngine).requestMovie(prefix, fps) as IAbstractMovie;
			//if (mc)
			//{
				//var autoScale:Number = 1;
				//var results:Vector.<Number> = new Vector.<Number>;
				//
				//if (scaleFromAtlas)
				//{
					//results.push(searchScale(prefix + "-" + "0"));
					//results.push(searchScale(prefix + "-" + "1"));
					//results.push(searchScale(prefix + "_" + "0"));
					//results.push(searchScale(prefix + "_" + "1"));
					//results.push(searchScale(prefix + "" + "0"));
					//results.push(searchScale(prefix + "" + "1"));
					//results.push(searchScale(prefix + "" + "00"));
					//results.push(searchScale(prefix + "" + "01"));
					//results.push(searchScale(prefix + "_" + "00"));
					//results.push(searchScale(prefix + "_" + "01"));
					//
					//for (var i:uint = 0; i < results.length; i++ )
					//{
						//if (results[i] != 1)
						//{
							//autoScale = results[i];
							//break;
						//}
					//}
				//}
				//
				//mc.scaleX = mc.scaleY = autoScale;
			//}
			return mc;
		}
		
		/**
		 * 
		 * @param	frames
		 * @param	fps
		 * @return
		 */
		public function requestMovieFromFrames(frames:Vector.<IAbstractImage>, fps:uint = 24):IAbstractMovie
		{
			return (_graphicsEngine as IEngine).requestMovieFromFrames(frames, fps) as IAbstractMovie;
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
			return (_graphicsEngine as IEngine).requestSprite(name) as IAbstractSprite;
		}
		
		public function requestGraphics(target:IAbstractDisplayObjectContainer):IAbstractGraphics
		{
			return (_graphicsEngine as IEngine).requestGraphics(target) as IAbstractGraphics;
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
		 * @param	dataProvider
		 * @param	width
		 * @param	height
		 * @param	backgroundImage
		 * @param	font
		 * @return
		 */
		public function requestComboBox(dataProvider:Vector.<IAbstractComboBoxItemRenderer>, width:Number, height:Number, backgroundImage:IAbstractImage, font:String):IAbstractComboBox
		{
			return(_graphicsEngine as IEngine).requestComboBox(dataProvider, width, height, backgroundImage, font) as IAbstractComboBox;
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
			return (_graphicsEngine as IEngine).requestSlider(thumbUpSkin, thumbDownSkin, trackUpSkin, trackDownSkin, backgroundSkin, label, name)
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
		public function requestTextField(width:int, height:int, text:String, fontName:String="Verdana", fontSize:Number=12, color:uint=0, bold:Boolean=false,  nativeFiltersArr:Array = null):IAbstractTextField
		{
			var t:IAbstractTextField = (_graphicsEngine as IEngine).requestTextField(width, height, text, fontName, fontSize, color, bold,  nativeFiltersArr);
			return t;
		}
		
		public function requestInputTextField(width:int, height:int, text:String = "", fontName:String = "Verdana", fontSize:Number = 12, color:uint = 0):IAbstractInputText
		{
			return (_graphicsEngine as IEngine).requestInputTextField(_signalsManager, width, height, text, fontName, fontSize, color);
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
		 * @param	filter
		 */
		public function addFragmentFilter(target:IAbstractDisplayObject, filter:Object):void
		{
			_graphicsEngine.addFragmentFilter(target, filter);
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
		  * @param	target
		  * @param	pixelSize
		  */
		 public function addPixelationFilter(target:IAbstractDisplayObject, pixelSize:int):void
		 {
			 _graphicsEngine.addPixelationFilter(target, pixelSize);
		 }
		 
		  /**
		  * 
		  * @param	target
		  * @param	pixelSize
		  */
		 public function addNewsPaperFilter(target:IAbstractDisplayObject, size:int, scale:int, angleInRadians:Number):void
		 {
			  _graphicsEngine.addNewsPaperFilter(target, size, scale, angleInRadians);
		 }
		
		 /**
		  * 
		  * @param	target
		  */
		 public function clearFilter(target:IAbstractDisplayObject):void
		 {
			 _graphicsEngine.clearFilter(target);
		 }
		 
		 /**
		  * 
		  * @param	rect
		  * @param	scale
		  * @return
		  */
		public  function requestScreenshot(rect:Rectangle, scale:Number=1.0):BitmapData
		{
				return (_graphicsEngine as IEngine).requestScreenshot(rect, scale);
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
		 * @return
		 */
		public function retrieveObject(name:String):Object
		{
			return _assetsManager.getObject(name);
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
			_assetsManager.addXml(name, atlasXml);
			_graphicsEngine.addTextureAtlas(name, atlasXml, atlasPng);
		}
		
		/**
		 * 
		 * @param	name
		 * @param	atlasXml
		 * @param	atlasATF
		 */
		public function storeAtlasATF(name:String, atlasXml:XML, atlasATF:ByteArray):void
		{
			_assetsManager.addXml(name, atlasXml);
			_graphicsEngine.addATFAtlasByteArray(name, atlasXml, atlasATF);
		}
		
		public function get nativeDisplay():Sprite
		{
			return _graphicsEngine.nativeDisplay;
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
			
			//_space = null;
		
			(_graphicsEngine as IEngine).cleanUp();
			_graphicsEngine = null;
		}
		
		/**
	 * 
	 * @param	configXML
	 * @param	imageSource
	 * @return
	 */
	public function requestParticleSystem(configXML:XML, imageSource:IAbstractImage):IAbstractParticleSystem
	 {
		 return (_graphicsEngine as IEngine).requestParticleSystem(configXML, imageSource);
	 }
	 
	 /**
	  * 
	  * @param	configXML
	  * @param	imageSource
	  * @param	atlasXML
	  * @return
	  */
	public function requestAdvancedParticleSystem(configXML:XML, imageSource:IAbstractImage, atlasXML:XML = null):IAbstractParticleSystem
	{
		return (_graphicsEngine as IEngine).requestAdvancedParticleSystem(configXML, imageSource, atlasXML);
	}
	
	/**
	 * Returns a Flare scene3D object(Eg. bridgeGraphics.scene3D as scene3D)
	 */
	public function get scene3D():Object 
	{
		return (_graphicsEngine as IEngine).scene3D;
	}
	
	public function get alwaysVerbose():Boolean 
	{
		return _alwaysVerbose;
	}
	
	public function set alwaysVerbose(value:Boolean):void 
	{
		_alwaysVerbose = value;
		BridgeGraphics.isVerbose  = _alwaysVerbose;
	}
	
	 /**
	 * 
	 */
	public function pauseRender():void
	 {
		 (_graphicsEngine as IEngine).pauseRender();
	 }	 
	 
	/**
	 * 
	 */
	 public function resumeRender():void
	{
		 (_graphicsEngine as IEngine).resumeRender();
	}
	
	/**
	 * 
	 * @return
	 */
	public function  contextStatus():Boolean
	{
		return (_graphicsEngine as IEngine).contextStatus();
	}
	}

}