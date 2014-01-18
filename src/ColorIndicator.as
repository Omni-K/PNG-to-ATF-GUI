package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author Nikolay Putko
	 */
	public class ColorIndicator extends MovieClip 
	{
		
		public function ColorIndicator() 
		{
			super();
			this.stop();
		}
		public function switchTo(b:Boolean):void {
			this.gotoAndStop(String(b));
		}
		
	}

}