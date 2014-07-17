package bridge.abstract.ui 
{
	import bridge.abstract.IAbstractSprite;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractSlider extends IAbstractSprite
	{
		  function get sliderComponentX():uint
		  function set sliderComponentX(val:uint):void
		  function get sliderComponentY():uint
		  function set sliderComponentY(val:uint):void
		  function get anchor():Function
		  function set anchor(val:Function):void
	}
	
}