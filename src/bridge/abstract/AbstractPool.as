package bridge.abstract 
{
	import bridge.BridgeGraphics;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public class AbstractPool 
	{
		private var _id:String;
		private var _type:Class;
		private var _size:uint;
		//private var _pool:Vector.<*>; //if non SWC version
		private var _pool:Array;
		private var _args:Array;
		
		/**
		 * 
		 * @param	id
		 * @param	type
		 * @param	size
		 */
		public function AbstractPool(id:String,type:Class,size:uint, ... args) 
		{
			_id = id;
			_type = type;
			_size = size;
			
			ObjPool(size, type, args);
		}
		
		/**
		 * 
		 * @param	poolsize
		 * @param	_type
		 */
	    public function ObjPool(poolsize:uint, _type:Class, args:Array):void
		{
			_args = args;
			
			var className:String = getQualifiedClassName(_type);
			var vectorClass:Class  = Class(getDefinitionByName("Vector.<" + className + ">"));
			var i:uint = _size;
			//_pool = new vectorClass(poolsize); //if non SWC version
			_pool = new Array();
			
			 while ( --i > -1 ) 
			 {
				 switch (args.length)
				 {
					 case 0:
						_pool.push(new _type()); 
						 break;
					 case 1:
						_pool.push(new _type(args[0])); 
						 break;
					 case 2:
						 _pool.push(new _type(args[0], args[1])); 
						 break;
					 case 3:
						 _pool.push(new _type(args[0], args[1], args[2])); 
						 break;
					 case 4:
						 _pool.push(new _type(args[0], args[1], args[2], args[3])); 
						 break;
					 case 5:
						_pool.push(new _type(args[0], args[1], args[2], args[3], args[4])); 
						 break;
					 case 6:
						  _pool.push( new _type(args[0], args[1], args[2], args[3], args[4], args[5])); 
						 break;
					 case 7:
						 _pool.push(new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6])); 
						 break;
					 case 8:
						 _pool.push(new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7])); 
						 break;
					 case 9:
						 _pool.push(new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8])); 
						 break;
					 case 10:
						 _pool.push(new _type(args[0], args[1], args[2], args[3], args[4], args[5], args[6], args[7], args[8], args[9])); 
						 break;
				 }
			 }	
		}
		
		/**
		 * 
		 * @param	newSpritesNumber
		 */
		public function growPool(newNumber:uint):void
		{
			if(BridgeGraphics.isVerbose) trace("[POOL ]" + _id + " is growing by "+newNumber);
			
			var i:uint = newNumber;
			
			  while ( --i > -1 ) 
			 {
				 switch (_args.length)
				 {
					 case 0:
						_pool.push(new _type()); 
						 break;
					 case 1:
						_pool.push(new _type(_args[0])); 
						 break;
					 case 2:
						 _pool.push(new _type(_args[0], _args[1])); 
						 break;
					 case 3:
						 _pool.push(new _type(_args[0], _args[1], _args[2])); 
						 break;
					 case 4:
						 _pool.push(new _type(_args[0], _args[1], _args[2], _args[3])); 
						 break;
					 case 5:
						_pool.push(new _type(_args[0], _args[1], _args[2], _args[3], _args[4])); 
						 break;
					 case 6:
						  _pool.push( new _type(_args[0], _args[1], _args[2], _args[3], _args[4], _args[5])); 
						 break;
					 case 7:
						 _pool.push(new _type(_args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6])); 
						 break;
					 case 8:
						 _pool.push(new _type(_args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7])); 
						 break;
					 case 9:
						 _pool.push(new _type(_args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7], _args[8])); 
						 break;
					 case 10:
						 _pool.push(new _type(_args[0], _args[1], _args[2], _args[3], _args[4], _args[5], _args[6], _args[7], _args[8], _args[9])); 
						 break;
				 }
			 }	
		}
		
		/**
		 * 
		 * @return Object
		 */
		public function getNewObject():Object
		{
			var newObj:Object;
			
			if (_pool.length == 1)
			{
				growPool(10);
			}
			
			newObj = _pool.pop();
			
			return newObj;
		}
		
		/**
		 * 
		 * @param	target
		 */
		public function returnToPool(target:Object):void
		{
			_pool.push(target);
		}
		
		/**
		 * 
		 * @param	target
		 */
		public function disposeObject(target:Object):void
		{
			target = null;
		}
		
		/**
		 * 
		 */
		public function emptyPool():void
		{
			var i:uint = _pool.length;
			 while( --i > -1 ) 
                _pool[i] = null;
			_pool.length = 0;
		}
		
		/**
		 * 
		 */
		public function get poolSize():uint
		{
			return _pool.length;
		}
	}
}