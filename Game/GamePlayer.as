package  Game{
	import flash.display3D.IndexBuffer3D;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import UI.ChessBox;
	
	public class GamePlayer extends Sprite{
		

		public var Name:Number;
		public var isBlack:Boolean;
		public var isAI:Boolean=false;
		private var currStone:Stone=null;
		private var chessContainers:Array=new Array();
		private var lastBox:ChessBox=null;
		
		public function GamePlayer(nm:Number,Black:Boolean,AI:Boolean=false) 
		{ 
			// constructor code
			isBlack=Black;
			isAI=AI;
			Name=nm;
		}
		
	
	}
	
}
