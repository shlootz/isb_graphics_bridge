package bridge.abstract 
{
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
			var className:String = getQualifiedClassName(_type);
			var vectorClass:Class  = Class(getDefinitionByName("Vector.<" + className + ">"));
			var i:uint = _size;
			//_pool = new vectorClass(poolsize); //if non SWC version
			_pool = new Array(poolsize);
			
			 while ( --i > -1 ) 
			 {
				 switch (args.length)
				 {
					 case 0:
						 _pool[i] = new _type(); 
						 break;
					 case 1:
						 _pool[i] = new _type(args[0]); 
						 break;
					 case 2:
						 _pool[i] = new _type(args[0], args[1]); 
						 break;
					 case 3:
						  _pool[i] = new _type(args[0], args[1], args[2]); 
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
			
			if (_pool.length == 0)
			{
				_pool.push(new Object());
			}
			
			newObj = _pool.shift();
			
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
		 * @param	newSpritesNumber
		 */
		public function growPool(newSpritesNumber:uint):void
		{
			var i:uint = _size;
			 while( --i > -1 ) 
                _pool.push(new _type()); 
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
	}
}