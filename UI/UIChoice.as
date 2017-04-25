package  UI{
	import flash.display.MovieClip;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	
	public class UIChoice extends MovieClip{
		
		public var isPlayingWithAI:Boolean=false;
		var titleBg:Loader;
		var yellowBg:Loader;
		var lidyellowBg:Loader;
		var greenBg:Loader;
		var lidgreenBg:Loader;
		
		var txt_player:Loader;
		var txt_master:Loader;
		
		public function UIChoice() {}
		public function initialUIChoice() {
			// constructor code

			titleBg=new Loader();
			titleBg.load(new URLRequest("images/txt_title.png"));
			titleBg.x=133;
			titleBg.y=133;
			addChild(titleBg);
			
			

			yellowBg=new Loader();
			yellowBg.load(new URLRequest("images/b_yellow.png"));
			yellowBg.x=233;
			yellowBg.y=383;
			addChild(yellowBg);
			
			lidyellowBg=new Loader();
			lidyellowBg.load(new URLRequest("images/lid_yellow.png"));
			lidyellowBg.x=255;
			lidyellowBg.y=386;
			addChild(lidyellowBg);
			yellowBg.addEventListener(MouseEvent.MOUSE_OVER,onChoosePlayer);
			yellowBg.addEventListener(MouseEvent.CLICK,choosePlayer);
			yellowBg.addEventListener(MouseEvent.MOUSE_OUT,outChoosePlayer);

			txt_player=new Loader();
			txt_player.load(new URLRequest("images/txt_player.png"));
			txt_player.x=235;
			txt_player.y=346;
	
			
			//---------------------------------
			greenBg=new Loader();
			greenBg.load(new URLRequest("images/b_green.png"));
			greenBg.x=433;
			greenBg.y=383;
			greenBg.addEventListener(MouseEvent.MOUSE_OVER,onChooseAI);
			greenBg.addEventListener(MouseEvent.CLICK,chooseAI);
			greenBg.addEventListener(MouseEvent.MOUSE_OUT,outChooseAI);
			addChild(greenBg);
			
			lidgreenBg=new Loader();
			lidgreenBg.load(new URLRequest("images/lid_green.png"));
			lidgreenBg.x=457;
			lidgreenBg.y=386;
			addChild(lidgreenBg);
			
			txt_master=new Loader();
			txt_master.load(new URLRequest("images/txt_master.png"));
			txt_master.x=435;
			txt_master.y=346;
			

			
			var withPlayer:Button=new Button();
			withPlayer.label="Play with player";
			withPlayer.width=200;
			withPlayer.height=50;
			withPlayer.x=300;
			withPlayer.y=300;
			
			var withAI:Button=new Button();
			withAI.label="Play with Master";
			withAI.width=200;
			withAI.height=50;
			withAI.x=300;
			withAI.y=360;
			
			
			withPlayer.addEventListener(MouseEvent.CLICK,choosePlayer);
			withAI.addEventListener(MouseEvent.CLICK,chooseAI);
			
			
		}
		public function onChoosePlayer(e:MouseEvent)
		{
			var myTimer:Timer = new Timer(1000,3);
			//myTimer.addEventListener(TimerEvent.TIMER, liftUp1)
			//myTimer.start();
			lidyellowBg.y-=60;
			addChild(txt_player);
		}
		public function outChoosePlayer(e:MouseEvent){lidyellowBg.y+=60;removeChild(txt_player);}
		public function choosePlayer(e:MouseEvent)
		{
			
			isPlayingWithAI=false;
			trace(isPlayingWithAI);
			
			for(var i:Number=0;i<1;i++)
			{
				parent.removeChildAt(0);
			}
		}
		
		//----------------
		public function onChooseAI(e:MouseEvent)
		{
			//var myTimer:Timer = new Timer(1000,3);
			//myTimer.addEventListener(TimerEvent.TIMER, liftUp2)
			//myTimer.start();
			lidgreenBg.y-=60;
			addChild(txt_master);
		}
		public function outChooseAI(e:MouseEvent){lidgreenBg.y+=60;removeChild(txt_master);}
		public function chooseAI(e:MouseEvent)
		{
			isPlayingWithAI=true;
			trace(isPlayingWithAI);

			for(var i:Number=0;i<1;i++)
			{
			parent.removeChildAt(0);
			}
		}
		
	}
	
}
