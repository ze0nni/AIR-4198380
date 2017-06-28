package 
{
	import flash.display.Shape;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	import flash.net.NetStreamAppendBytesAction;
	import flash.utils.ByteArray;
	import starling.core.Starling;
	import starling.display.Quad;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author e.blagodarev
	 */
	public final class GameRoot extends Sprite 
	{
		[Embed(source="intro.flv", mimeType="application/octet-stream")]
		private static const VIDEO: Class;
		
		public function GameRoot() 
		{
			super();
			
			// starling
			addChild(new Quad(400, 150, 0xffc0ff));
			
			// flash
			const blackSprite: Shape = new Shape();
			blackSprite.graphics.beginFill(0x0);
			blackSprite.graphics.drawRect(0, 0, 300, 200);
			blackSprite.graphics.endFill();
			Starling.current.nativeStage.addChild(blackSprite);
			
			const video: Video = new Video(280, 180);
			video.smoothing = true;
			video.attachNetStream(stream(new VIDEO()));
			
			Starling.current.nativeStage.addChild(video);
		}
		
		private function stream(source: ByteArray):NetStream
		{
			const connection: NetConnection = new NetConnection();
			connection.connect(null);
			
			const netStream: NetStream = new NetStream(connection);
			netStream.client = {};
			netStream.client['onMetadata '] = function(): void {};
			
			netStream.play(null);
			netStream.appendBytesAction(NetStreamAppendBytesAction.RESET_BEGIN);
			source.position = 0;
			netStream.appendBytes(source);
			return netStream;
		}
	}

}