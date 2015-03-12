package bridge.abstract.console 
{
	
	/**
	 * ...
	 * @author Alex Popescu
	 */
	public interface IConsoleCommands 
	{
		function registerCommand(name:String, listener:Function):void
	}
	
}