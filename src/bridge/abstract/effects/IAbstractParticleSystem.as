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
		
		/////////////////////////////// SYSTEM PROPERTIES //////////////////////////////
		
		/**
		 * 
		 * @return
		 */
		function get emissionRate():Number
		
		function set emissionRate(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitAngle():Number
		
		function set emitAngle(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitAngleAlignedRotation():Boolean
		
		function set emitAngleAlignedRotation(val:Boolean):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitAngleVariance():Number
	
		function set emitAngleVariance(val:Number):void
	
		
		/**
		 * 
		 * @return
		 */
		function get emitter():Point
		
		function set emitter(val:Point):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitterObject():Object
		
		function set emitterObject(val:Object):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitterType():Number
		
		function set emitterType(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitterX():Number
		
		function set emitterX(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitterXVariance():Number
		
		function set emitterXVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitterY():Number
		
		function set emitterY(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitterYVariance():Number
		
		function set emitterYVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get emitting():Boolean
		
		
		/**
		 * 
		 * @return
		 */
		function get endRotation():Number
		
		function set endRotation(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get endRotationVariance():Number
		
		function set endRotationVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get endSize():Number
		
		function set endSize(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get endSizeVariance():Number
		
		function set endSizeVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get fadeInTime():Number
		
		function set fadeInTime(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get fadeOutTime():Number
		
		function set fadeOutTime(val:Number):void
		
	
		/**
		 * 
		 * @return
		 */
		function get gravityX():Number
		
		function set gravityX(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		
		function set gravityY(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get lifespan():Number
		
		function set lifespan(val:Number):void
		
		/**
		 * 
		 * @return
		 */
		function get lifespanVariance():Number
		
		function set lifespanVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get maxCapacity():Number
		
		function set maxCapacity(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get maxNumParticles():Number
		
		function set maxNumParticles(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get maxRadius():Number
		
		function set maxRadius(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get maxRadiusVariance():Number
		
		function set maxRadiusVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get minRadius():Number
		
		function set minRadius(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get minRadiusVariance():Number
		
		function set minRadiusVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get numParticles():Number
		
		
		/**
		 * 
		 * @return
		 */
		function get radialAcceleration():Number
		
		function set radialAcceleration(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get radialAccelerationVariance():Number
	
		function set radialAccelerationVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get randomStartFrames():Boolean
		
		function set randomStartFrames(val:Boolean):void
		
		
		/**
		 * 
		 * @return
		 */
		function get rotatePerSecond():Number
		
		function set rotatePerSecond(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get rotatePerSecondVariance():Number
		
		function set rotatePerSecondVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get spawnTime():Number
		
		function set spawnTime(val:Number):void
		
	
		/**
		 * 
		 * @return
		 */
		function get speed():Number
		
		function set speed(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get speedVariance():Number
		
		function set speedVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get startRotation():Number
		
		function set startRotation(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get startRotationVariance():Number
		
		function set startRotationVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get startSize():Number
		
		function set startSize(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get startSizeVariance():Number
		
		function set startSizeVariance(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get tangentialAcceleration():Number
		
		function set tangentialAcceleration(val:Number):void
		
		
		/**
		 * 
		 * @return
		 */
		function get tangentialAccelerationVariance():Number
		
		function set tangentialAccelerationVariance(val:Number):void
		
	}
	
}