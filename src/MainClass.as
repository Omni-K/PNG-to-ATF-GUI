package
{
	import fl.controls.CheckBox;
	import fl.controls.TextInput;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import flash.net.FileFilter;
	import flash.filesystem.*;
	import flash.net.FileFilter;
	import flash.events.Event;
	import flash.desktop.NativeProcessStartupInfo;
	import flash.desktop.NativeProcess;
	import ColorIndicator;
	import flash.net.drm.VoucherAccessInfo;
	import flash.text.TextField;
	import Version;
	
	/**
	 * ...
	 * @author Nikolay Putko
	 */
	public class MainClass extends Sprite
	{
		private var p_png2atf:String = 'C:\\Users\\Николай\\Dropbox\\Проекты\\Png2Atf\\src';
		private var isCompressed:String = '-c';
		private var p_input:String = '-i';
		private var p_output:String = '-o';
		
		private var inputfile:File;
		private var txtFilter:FileFilter = new FileFilter("PNG Image", "*.png");
		private var desktop:File = File.desktopDirectory;
		private var application:File = File.applicationDirectory;
		private var execfile:File;
		private var space:String = ' ';
		private var argumetsVector:Vector.<String> = new Vector.<String>;
		
		public var browse_btn:Button;
		public var execute_btn:Button;
		public var input:TextInput;
		public var ios:CheckBox;
		public var android:CheckBox;
		public var windows:CheckBox;
		public var indicator1:ColorIndicator;
		public var version_txt:TextField;
		
		public function MainClass():void
		{
			this.browse_btn.addEventListener(MouseEvent.CLICK, browseFile);
			this.execute_btn.addEventListener(MouseEvent.CLICK, execute);
			indicatorsRefresh();
			getVersion();
		}
		private function indicatorsRefresh():void{
			this.indicator1.switchTo(NativeProcess.isSupported);
		}
		private function getVersion():void {
			version_txt.text = 	Version.Major + "." + Version.Minor + "." + Version.Build + "." + Version.Revision;
			trace(Version.Major + "." + Version.Minor + "." + Version.Build + "." + Version.Revision);
		}
		
		private function browseFile(e:MouseEvent):void {
			try{
				this.inputfile = new File();
				this.inputfile.browseForOpen("Choose PNG to convert", [txtFilter]);				
				this.inputfile.addEventListener(Event.SELECT, fileSelected);
			}
			catch(error:Error){
				trace("Failed: ",error.message);
			}
		}
		private function fileSelected(event:Event):void{
			this.input.text = this.inputfile.nativePath;
		}
		private function execute(event:MouseEvent):void {
			trace(this.application.nativePath);
			execfile= new File(this.application.nativePath+'/png2atf.exe');//inputfile.nativePath
			trace(execfile.nativePath,inputfile.nativePath,desktop.nativePath);
			this.argumetsVector.push('-c','-i',inputfile.nativePath,'-o',desktop.nativePath+'/output.atf');
			trace('file exists',execfile.exists,execfile.extension);
			var nativeProcessStartupInfo:NativeProcessStartupInfo = new NativeProcessStartupInfo();
			nativeProcessStartupInfo.executable = execfile;
			nativeProcessStartupInfo.arguments = this.argumetsVector;
			var process:NativeProcess = new NativeProcess();
			process.start(nativeProcessStartupInfo);
		}
		
	}
}