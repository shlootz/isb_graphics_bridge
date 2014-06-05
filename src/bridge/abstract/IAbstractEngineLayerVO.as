package bridge.abstract 
{
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Alex Popescu
	 * 
	 * The layer proxy manages a dictionary of layers.
	 * Creates and retrieves lauers.
	 * @see bridge.abstract.IAbstractLayer
	 */
	/**
	 * Manages a dictionary of layers. DOES NOT MANAGE LAYERS THEMSELVES
	 */
	public interface IAbstractEngineLayerVO 
	{
		/**
		 * 
		 * @param	layerName
		 */
		function addLayer(layerName:String, depth:uint = 0, xml:XML = null, addToStage:Boolean = true):void
		/**
		 * 
		 * @param	layerName
		 * @return IAbstractLayer
		 * @see bridge.abstract.IAbstractLayer
		 */
		function retrieveLayer(layerName:String):IAbstractLayer
		/**
		 * @return Returns the layers dictionary
		 */
		function get layers():Dictionary
	}
	
}