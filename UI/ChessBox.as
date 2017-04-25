package  UI{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import fl.controls.progressBarClasses.IndeterminateBar;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	
	public class ChessBox extends Sprite{
		
		private var line:int;
		private var col:int;
		public var hlBgLoader:Loader=new Loader();

		public function ChessBox(l:int,c:int) {
			// constructor code
			//trace("cbline=",l,"cbcol=",c);
			line=l;
			col=c;
			
			hlBgLoader.load(new URLRequest("images/highLightBoxesBg.png"));
			hlBgLoader.x=133+28+line*32;
			hlBgLoader.y=33+28+col*32;
			addChild(hlBgLoader);
			
			//trace("addEventListener");
			//hlBgLoader.addEventListener(MouseEvent.MOUSE_OVER,highLightBox);
			
			/*bg.lineStyle(1,0xffffff);
			bg.beginFill(0xffffff);
			bg.drawRect(133+28+line*32,33+28+line*32//原来是这里出错,30,30);
			bg.endFill();*/
			
		}
		
		
		public function getLine():int{return line;}
		public function getCol():int{return col;}
		
	}

}
