package
{
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.system.Capabilities;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import starling.core.Starling;
	
	/**
	 * ...
	 * @author e.blagodarev
	 */
	public class Main extends Sprite 
	{
		public function Main() 
		{
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			stage.addEventListener(Event.DEACTIVATE, deactivate);
			
			// touch or gesture?
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			// Entry point
			if (stage == null) {
				addEventListener(Event.ADDED_TO_STAGE, init);
			} else {
				init();
			}
		}
		
		private function deactivate(e:Event):void 
		{
			// make sure the app behaves well (or exits) when in background
			//NativeApplication.nativeApplication.exit();
		}
		
		private function init(...args): void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			Starling.multitouchEnabled = true;
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			//_starling = new Starling(GameFacade, stage, resolution.viewPort, null, "auto", "auto");
			const starling: Starling = new Starling(GameRoot, stage, null, null, "auto", "auto");
			starling.enableErrorChecking = Capabilities.isDebugger;
			starling.simulateMultitouch  = false;
			starling.stage.color = 0xffffff;
			
			starling.skipUnchangedFrames = true;
			
			starling.start();
		}
	}
	
}