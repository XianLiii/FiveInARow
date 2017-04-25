package  {
	
	
	import flash.display.MovieClip;
	import flash.geom.Matrix;
	import fl.controls.Button;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.ui.Mouse;
	import flash.text.TextField;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.display.Sprite;
	
    import flash.events.*;
    import flash.media.Sound;
    import flash.media.SoundChannel;
    import flash.net.URLRequest;
	
	import Game.Stone;
	import Game.GameMain;
	import Game.GamePlayer;
	import Game.PointInfo;
	
	import UI.UIMain;
	import UI.UIChoice;
	import UI.ChessBox;
	import UI.Chess;
	import fl.controls.progressBarClasses.IndeterminateBar;
	import flash.ui.GameInput;
	import Game.Rules;
	import flash.utils.Timer;
	
	public class Main extends MovieClip{

//游戏数据成员－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
		public var UI_entrance:UIChoice=new UIChoice();
		public var UI_main:UIMain=new UIMain();
		
		//声明四个玩家，便于在选择棋子、切换玩家时使用。
		var boy:GamePlayer;
		var master:GamePlayer;
		var p1:GamePlayer;
		var p2:GamePlayer;
		
		//声明游戏棋盘信息
		var _Game:GameMain;
		var minLine:int=0;
		var maxLine:int=0;
		var minCol:int=0;
		var maxCol:int=0;
		
		//新建当前玩家、当前棋子
		var currPlayer:GamePlayer;
		var currStone:Stone;
		
		//界面选择高光用到的
		private var lastBox:ChessBox;
		private var allHL:MovieClip=new MovieClip();
		public var chessContainers:Array;
		
//游戏流程函数－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
		public function Main() {
			// constructor code
			InitialGame();

		}
		
		public function InitialGame()
		{
			
			UI_entrance.initialUIChoice();
			
			addChild(UI_entrance);
			UI_entrance.addEventListener(MouseEvent.CLICK,goIntoTheGame);
			
		}
		
		public function goIntoTheGame(e:MouseEvent)
		{
			if(UI_entrance.isPlayingWithAI==true)
			{playWithAI();}
				
			if(UI_entrance.isPlayingWithAI==false)
			{playWithPlayer();}
			
		}
		public function playWithAI()
		{
			trace("now play with AI");
			//增加界面
			var chessBoardBg:Loader=new Loader();
			chessBoardBg.load(new URLRequest("images/chessBoardBg.png"));
			chessBoardBg.x=133;
			chessBoardBg.y=33;
			addChild(chessBoardBg);
			
			//加载游戏棋局信息
			_Game=new GameMain();
			_Game.initialGameMain();
			addChild(_Game);
			
			//重启按钮
			var restartBtn:Loader=new Loader();
			restartBtn.load(new URLRequest("images/restart1.png"));
			restartBtn.x=650;
			restartBtn.y=500;
			addChild(restartBtn);
			restartBtn.addEventListener(MouseEvent.CLICK,restart);

			//初始化玩家，boy普通，master为AI，从普通玩家开始
			boy=new GamePlayer(1,true,false);
			master=new GamePlayer(2,false,true);
			currPlayer=boy;
			
			
			//开始游戏
			Selection();
			
			
			
		}
		
		
		public function playWithPlayer()
		{
		trace("now play with Player");
			//增加界面
			var chessBoardBg:Loader=new Loader();
			chessBoardBg.load(new URLRequest("images/chessBoardBg.png"));
			chessBoardBg.x=133;
			chessBoardBg.y=33;
			addChild(chessBoardBg);
			
			//加载游戏棋局信息
			_Game=new GameMain();
			_Game.initialGameMain();
			addChild(_Game);
			
			//重启按钮
			//重启按钮
			var restartBtn:Loader=new Loader();
			restartBtn.load(new URLRequest("images/restart1.png"));
			restartBtn.x=650;
			restartBtn.y=500;
			addChild(restartBtn);
			restartBtn.addEventListener(MouseEvent.CLICK,restart);

			//初始化玩家，boy普通，master为AI，从普通玩家开始
			p1=new GamePlayer(3,true,false);
			p2=new GamePlayer(4,false,false);
			currPlayer=p1;
			
			
			//开始游戏
			Selection();
		}
		
		public function restart(e:MouseEvent)
		{
			var restartBtn:Loader=new Loader();
			restartBtn.load(new URLRequest("images/restart2.png"));
			restartBtn.x=650;
			restartBtn.y=500;
			addChild(restartBtn);
			
			//remove all children
			while (numChildren>0) 
			{
				removeChildAt(0);
			}
			
			//重置所有数据
			InitialGame();
		}

		
//主要游戏部分，控制游戏循环选择－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
		public function Selection()
		{
			trace("currPlayer is :",currPlayer.Name,currPlayer.isAI);
			
			if(_Game.isGaming==false)
			{
				return;
			}

			
						
			//当前玩家为AI，则进入AI选择棋子，等待3s，增加棋子＋切换玩家
				if(currPlayer.isAI==true)
				{
					AISelection();
				}
			//当前玩家是普通玩家，则监听点击事件，然后在点击事件里增加棋子＋切换玩家
				if(currPlayer.isAI==false)
				{
					//highlight background 移出来方便remove，放在普通用户流程里会remove不了
					chessContainers=new Array();
					for(var i:int=0;i<15;i++)
					{
						var chessContainersRow:Vector.<ChessBox>=new Vector.<ChessBox>();
						for(var j:int=0;j<15;j++)
						{
							var tempCB:ChessBox=new ChessBox(i,j);
							chessContainersRow.push(tempCB);
							
						}
						chessContainers.push(chessContainersRow);
					}
					
					addEventListener(MouseEvent.MOUSE_OVER,highlightBG);
					
				}
				
				
			}
			
		
			public function AISelection()
			{
				//怎么能让它等一会？
				
				//var myTimer:Timer = new Timer(1000,10); // 1 second
				//myTimer.start();
				
				AddStone(_Game.AISelect(minLine,maxLine,minCol,maxCol));
			
				trace("now in the AI selection");
				if(_Game.isGaming==false)
				{
					trace("the Game is over.");
					GameOver();
					return;
					
				}
				
				ChangePlayer();
				
				Selection();
			}
		
		
			public function GameOver()
			{

				trace("function of game over");
				var url:String = "res/cheers.mp3";
				var song:SoundChannel;
				var request:URLRequest = new URLRequest(url);
				var soundFactory:Sound = new Sound();
				soundFactory.load(request);
				song = soundFactory.play();
				
				var winner:Loader=new Loader();
				if(currPlayer.isAI)
				{
					winner.load(new URLRequest("images/winnerWhite.png"));
				}
				if(currPlayer.isBlack)
				{
					winner.load(new URLRequest("images/winnerBlack.png"));
				}
				if(currPlayer.isBlack==false)
				{
					winner.load(new URLRequest("images/winnerWhite.png"));
				}
				
				winner.x=220;
				winner.y=200;
				addChild(winner);

			}
//功能函数－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－－
		//出现不稳定，不知道原因，反应比较慢 
		public function highlightBG(e:MouseEvent)
		{
			if(_Game.isGaming==false||currPlayer.isAI==true)
			{
				removeChild(lastBox);
				lastBox=null;
				removeEventListener(MouseEvent.MOUSE_OVER,highlightBG);
			}
			
			//这里行列反了
			var tempC:int=getLineFromMouse(stage.mouseY);
			var tempL:int=getColFromMouse(stage.mouseX);
			//trace(stage.mouseX,stage.mouseY,tempL,tempC);
			
			if(tempL<0&&tempL>14&&tempC<0&&tempC>14&&lastBox!=null)
			{
				removeChild(lastBox);
			}
			
			if(tempL>=0&&tempL<15&&tempC>=0&&tempC<15&&_Game.isPosiIsEmpty(tempC,tempL)==true)
			{
				if(lastBox==null)
				{
					lastBox=chessContainers[tempL][tempC];
				}
				else
				{
					removeChild(lastBox);
					lastBox=chessContainers[tempL][tempC];
				}
				
				addChild(chessContainers[tempL][tempC]);
			}
			
			chessContainers[tempL][tempC].addEventListener(MouseEvent.CLICK,clickSelect);
			
		}
		
		public function clickSelect(e:MouseEvent)
		{
				
			var tempL:int=getLineFromMouse(stage.mouseY);
			var tempC:int=getColFromMouse(stage.mouseX);
			
			//trace("clickSelect:",stage.mouseX,stage.mouseY,tempL,tempC);

			currStone=new Stone(tempL,tempC,currPlayer.isBlack);
			
			//添加棋子
			if(AddStone(currStone))
			{
				//如果添加成功，判断是否结束
				
				if(_Game.isGaming==false)
				{
					trace("the Game is over.");
					GameOver();
					return;
					
				}
				
				//切换玩家
				ChangePlayer();
			}
			
			//回游戏继续选择
			Selection();
			
		}

		public function ChangePlayer()
		{
			switch(currPlayer.Name)
			{
				case 1:
					currPlayer=master;
				break;
				
				case 2:
					currPlayer=boy;
				break
				
				case 3:
					currPlayer=p2;
				break;
				
				case 4:
					currPlayer=p1;
				break;
				
				default:
					trace("something wrong when change the player.")
				break;
			}
		}
		
		public function AddStone(stone:Stone):Boolean
		{
			var url:String = "res/addStone.mp3";
			var song:SoundChannel;
			var request:URLRequest = new URLRequest(url);
            var soundFactory:Sound = new Sound();
            soundFactory.load(request);
            song = soundFactory.play();
			
			//检查放子位置，如果已经放子就不再放
			if(_Game.isPosiIsEmpty(stone.l,stone.col))
			{
				var newChess:Chess=new Chess(stone.l,stone.col,stone.isBlack);
				addChild(newChess);
				_Game.updateStoneRec(stone);
				trace("add chess at",stone.l,stone.col);
				
				//缩小盘局，改进效率1
				if(minLine==0&&maxLine==0&&minCol==0&&maxCol==0)
				{
					minLine=stone.l;
					maxLine=stone.l;
					minCol=stone.col;
					maxCol=stone.col;
					trace("first time initiative checking square");
				}

				if(stone.l<minLine)
				{minLine=stone.l;}
				else if(stone.l>maxLine)
				{maxLine=stone.l;}
				
				if(stone.col<minCol)
				{minCol=stone.col;}
				else if(stone.col>maxLine)
				{maxCol=stone.col;}
				
				return true;
			}
			return false;
		}

		public function getLineFromMouse(mY:Number):int
		{
			return (mY-(33+28))/32;
		}
		
		public function getColFromMouse(mX:Number):int
		{
			return (mX-(133+28))/32;
		}
		
	}
}