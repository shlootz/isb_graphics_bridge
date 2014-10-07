package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractDisplayObject;
	import flash.geom.Point;
	/**
	 * ...
	 * @author Alex Popescu
	 */
	/**
	 * Contains all the logic of a Button.
	 */
	public interface IAbstractButton extends IAbstractDisplayObject
	{
		function set idName(value:String):void
		function get idName():String
		
		function get autoFlatten () : Boolean
		
		function set autoFlatten (value:Boolean) : void

		function get currentState_ () : String
		
		function set currentState_ (value:String) : void
		
		function get defaultIcon_ () : IAbstractDisplayObject
		
		function set defaultIcon_ (value:IAbstractDisplayObject) : void
		
		//function get defaultLabelProperties () : Object
		
		//function set defaultLabelProperties (value:Object) : void
		
		function get defaultSelectedIcon_ () : IAbstractDisplayObject
		
		function set defaultSelectedIcon_ (value:IAbstractDisplayObject) : void
		
		//function get defaultSelectedLabelProperties () : Object
		
		//function set defaultSelectedLabelProperties (value:Object) : void
		
		function get defaultSelectedSkin_ () : IAbstractDisplayObject
		
		function set defaultSelectedSkin_ (value:IAbstractDisplayObject) : void
		
		function get defaultSkin_ () : IAbstractDisplayObject
		
		function set defaultSkin_ (value:IAbstractDisplayObject) : void
		
		function get disabledIcon_ () : IAbstractDisplayObject
		
		function set disabledIcon_ (value:IAbstractDisplayObject) : void
		
		//function get disabledLabelProperties () : Object
		
		function get disabledSkin_ () : IAbstractDisplayObject
		
		function set disabledSkin_ (value:IAbstractDisplayObject) : void
		
		function get downIcon_ () : IAbstractDisplayObject
		
		function set downIcon_ (value:IAbstractDisplayObject) : void
		
		//function get downLabelProperties () : Object
		
		//function set downLabelProperties (value:Object) : void
		
		function get downSkin_ () : IAbstractDisplayObject
		
		function set downSkin_ (value:IAbstractDisplayObject) : void
		
		function get gap () : Number
		
		function set gap (value:Number) : void
		
		function get horizontalAlign () : String
		
		function set horizontalAlign (value:String) : void
		
		function get hoverIcon_ () : IAbstractDisplayObject
	
		function set hoverIcon_ (value:IAbstractDisplayObject) : void

		//function get hoverLabelProperties () : Object
		
		//function set hoverLabelProperties (value:Object) : void
		
		function get hoverSkin_ () : IAbstractDisplayObject
		
		function set hoverSkin_ (value:IAbstractDisplayObject) : void
		
		function get iconOffsetX () : Number
		
		function set iconOffsetX (value:Number) : void
		
		function get iconOffsetY () : Number
		
		function set iconOffsetY (value:Number) : void
		
		function get iconPosition () : String
		
		function set iconPosition (value:String) : void
		
		function set isEnabled (value:Boolean) : void
		
		function get isEnabled():Boolean
		
		function get isLongPressEnabled () : Boolean
		
		function set isLongPressEnabled (value:Boolean) : void
		
		function get isSelected () : Boolean
		
		function set isSelected (value:Boolean) : void
		
		function get isToggle () : Boolean
		
		function set isToggle (value:Boolean) : void
		
		//function get label () : String
		
		//function set label (value:String) : void
	
		//function get labelFactory () : Function
		
		//function set labelFactory (value:Function) : void
		
		//function get labelOffsetX () : Number
		
		//function set labelOffsetX (value:Number) : void
		
		//function get labelOffsetY () : Number
		
		//function set labelOffsetY (value:Number) : void
		
		function get longPressDuration () : Number
		
		function set longPressDuration (value:Number) : void
		
		function get padding () : Number
		
		function set padding (value:Number) : void
		
		function get paddingBottom () : Number
		
		function set paddingBottom (value:Number) : void
		
		function get paddingLeft () : Number
		
		function set paddingLeft (value:Number) : void

		function get paddingRight () : Number
		
		function set paddingRight (value:Number) : void
		
		function get paddingTop () : Number
	
		function set paddingTop (value:Number) : void
		
		function get selectedDisabledIcon_ () : IAbstractDisplayObject
		
		function set selectedDisabledIcon_ (value:IAbstractDisplayObject) : void
		
		//function get selectedDisabledLabelProperties () : Object
		
		//function set selectedDisabledLabelProperties (value:Object) : void
		
		function get selectedDisabledSkin_ () : IAbstractDisplayObject
		
		function set selectedDisabledSkin_ (value:IAbstractDisplayObject) : void
		
		function get selectedDownIcon_ () : IAbstractDisplayObject
		
		function set selectedDownIcon_ (value:IAbstractDisplayObject) : void
		
		//function get selectedDownLabelProperties () : Object
		
		//function set selectedDownLabelProperties (value:Object) : void
		
		function get selectedDownSkin_ () : IAbstractDisplayObject
		
		function set selectedDownSkin_ (value:IAbstractDisplayObject) : void
		
		function get selectedHoverIcon_ () : IAbstractDisplayObject
		
		function set selectedHoverIcon_ (value:IAbstractDisplayObject) : void
		
		//function get selectedHoverLabelProperties () : Object
		
		//function set selectedHoverLabelProperties (value:Object) : void
		
		function get selectedHoverSkin_ () : IAbstractDisplayObject
		
		function set selectedHoverSkin_ (value:IAbstractDisplayObject) : void
		
		function get selectedUpIcon_ () : IAbstractDisplayObject
		
		function set selectedUpIcon_ (value:IAbstractDisplayObject) : void
		
		//function get selectedUpLabelProperties () : Object
		
		//function set selectedUpLabelProperties (value:Object) : void
		
		function get selectedUpSkin_ () : IAbstractDisplayObject
		
		function set selectedUpSkin_ (value:IAbstractDisplayObject) : void
		
		function get stateNames_ () : Vector.<String>
		
		function get stateToIconFunction () : Function
		
		function set stateToIconFunction (value:Function) : void
		
		//function get stateToLabelPropertiesFunction () : Function
		
		//function set stateToLabelPropertiesFunction (value:Function) : void
		
		function get stateToSkinFunction () : Function
		
		function set stateToSkinFunction (value:Function) : void
		
		function get upIcon_ () : IAbstractDisplayObject
		
		function set upIcon_ (value:IAbstractDisplayObject) : void
		
		//function get upLabelProperties () : Object
		
		//function set upLabelProperties (value:Object) : void
		
		function get upSkin_ () : IAbstractDisplayObject
		
		function set upSkin_ (value:IAbstractDisplayObject) : void
		
		function get verticalAlign () : String
		
		function set verticalAlign (value:String) : void
		
		function autoSizeIfNeeded_ () : Boolean
		
		//function button_removedFromStageHandler (event:Event) : void
		
		//function createLabel_ () : void
		
		function draw_ () : void
		
		//function focusInHandler (event:Event) : void
		
		//function focusOutHandler (event:Event) : void
		
		function layoutContent_ () : void
		
		//function longPress_enterFrameHandler (event:Event) : void
		
		//function positionLabelAndIcon_ () : void
		
		function positionSingleChild_ (displayObject:IAbstractDisplayObject) : void
		
		function refreshIcon_ () : void
		
		//function refreshLabel_ () : void
		
		//function refreshLabelStyles_ () : void
		
		//function refreshMaxLabelWidth_ (forMeasurement:Boolean) : void
		
		function isHit (localPoint:Point, forTouch:Boolean=false) : Boolean;
		
		function refreshSkin_ () : void
		
		function scaleSkin_ () : void
		
		function addCustomLabel(customLabel:IAbstractLabel, align:String = "center", customAlign:Point = null):void
		
		function get customLabel():IAbstractLabel
		
		function updateCustomLabel(labelText:String):void
		
	}

}