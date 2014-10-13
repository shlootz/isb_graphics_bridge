package bridge.abstract.effects 
{
	import bridge.abstract.IAbstractSprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IAbstractParticleSystem extends IAbstractSprite
	{
		function start(duration:Number = Number.MAX_VALUE):void
		function stop():void
		function setEmmiter(position:Point):void
		function clear():void
	}
	
}