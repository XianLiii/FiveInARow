package  UI{
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	import fl.controls.progressBarClasses.IndeterminateBar;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.MouseEvent;
	
	public class Chess extends Sprite
	{
		private var row:int;
		private var col:int;
		public var chessLoader:Loader=new Loader();
		
		public function Chess(l:int,c:int,isBlack:Boolean) 
		{
			//trace("cbline=",l,"cbcol=",c);
			row=l;
			col=c;
			
			if(isBlack==true)
			{
				chessLoader.load(new URLRequest("images/chessBlack.png"));
			}
			if(isBlack==false)
			{
				chessLoader.load(new URLRequest("images/chessWhite.png"));
			}
			chessLoader.x=133+28+col*32+2;
			chessLoader.y=33+28+row*32+2;
			
			addChild(chessLoader);
		}
	}
	
}
