package  Game{
	import flash.display3D.IndexBuffer3D;
	import flash.geom.Point;
	
	public class PointInfo {

		//给周围一圈空棋位打分
		public var Bmark:int=0;
		public var Wmark:int=0;
		public var MXmark:int=0;

		public var l:int;
		public var col:int;
		public var isBlack:Boolean;
		public var isEmpty:Boolean;
		
		public var numH:int=0;
		public var numV:int=0;
		public var numS:int=0;
		public var numBS:int=0;
		
		public var UpSpace:PointInfo;
		public var DownSpace:PointInfo;
		public var LeftSpace:PointInfo;
		public var RightSpace:PointInfo;
		
		public var LeftUpSpace:PointInfo;
		public var RightUpSpace:PointInfo;
		public var LeftDownSpace:PointInfo;
		public var RightDownSpace:PointInfo;
		
		public var isFiveStone:Boolean;
		
		public var BnumFive:int=0;		
		public var BnumLiveThree:int=0;
		public var BnumLiveTwo:int=0;
		public var BnumOneFour:int=0;
		public var BnumLiveFour:int=0;
		
		public var WnumFive:int=0;	
		public var WnumLiveThree:int=0;
		public var WnumLiveTwo:int=0;
		public var WnumOneFour:int=0;
		public var WnumLiveFour:int=0;
		
		
		public function PointInfo(line:int,c:int) {
			// constructor code
			l=line;
			col=c;
			isEmpty=true;
		}
		
		public function updatePointInfo(s:Stone)
		{
			l=s.l;
			col=s.col;
			isBlack=s.isBlack;
			isEmpty=false;
			isFiveStone=isFiveStoneAll();
			//trace("Now the PointInfo[",line,"][",col,"is not empty.");
		}
		
		public function calculatePointInfo()
		{
			//归零，避免受到上一次计算影响

			Bmark=0;
			Wmark=0;
			MXmark=0;
			
			BnumFive=0;			
			BnumLiveThree=0;
			BnumLiveTwo=0;
			BnumOneFour=0;
			BnumLiveFour=0;
		
			WnumFive=0;	
			WnumLiveThree=0;
			WnumLiveTwo=0;
			WnumOneFour=0;
			WnumLiveFour=0;
			
			//如果此棋位不为空，则0分跳过
			if(this.isEmpty==false)
			{
				//trace("jump0");
				Bmark=0;
				Wmark=0;
				MXmark=0;
				return;
			}
			

		//计算剩余 本身是空棋位，周围有其他棋子的
		calH();
		calV();
		calS();
		calBS();
		
		//计算分值
		calBmark();
		calWmark();
		
		//只存最大值
		if(Bmark>=Wmark)
		{
			MXmark=Bmark;
		}
		else
		{
			MXmark=Wmark;
		}
		trace("in checking PT","l=",l,"col=",col,"Bmark=",Bmark,"Wmark=",Wmark);
		return;
		}
		//------------------------------------------------------------------------------------
		
		public function calWmark()
		{
			
			if(WnumFive==1)
			{
				Wmark=560;
				return;
			}
			if(WnumLiveFour==1)
			{
				Wmark=545;
				return;
			}
			if(WnumOneFour>1)
			{
				Wmark=544;
				return;
			}
			if(WnumOneFour==1&&WnumLiveThree==1)
			{
				Wmark=543;
				return;
			}
			if(WnumLiveThree==2)
			{
				Wmark=541;
				return;
			}
			if(WnumOneFour==1&&WnumLiveTwo>2)
			{
				Wmark=535;
				return;
			}
			if(WnumOneFour==1)
			{
				Wmark=529;
				return;
			}
			if(WnumLiveThree==1&&WnumLiveTwo<2)
			{
				Wmark=533;
				return;
			}
			if(WnumLiveThree==1)
			{
				Wmark=532;
				return;
			}
			if(WnumLiveTwo>=2)
			{
				Wmark=529;
				return;
			}
			if(WnumLiveTwo==2)
			{
				Wmark=525;
				return;
			}
			if(WnumLiveTwo==1)
			{
				Wmark=521;
				return;
			}
			Wmark=1;
			return;
			
			
			
		}
		
		public function calBmark()
		{
			
			if(BnumFive==1)
			{
				Bmark=570;
				return;
			}
			if(BnumLiveFour==1)
			{
				Bmark=548;
				return;
			}
			if(BnumOneFour==1)
			{
				Bmark=547;
				return;
			}
			if(BnumOneFour==1&&BnumLiveThree==1)
			{
				Bmark=546;
				return;
			}
			if(BnumLiveThree==1)
			{
				Bmark=542;
				return;
			}
			if(BnumOneFour==1&&BnumLiveTwo>2)
			{
				Bmark=541;
				return;
			}
			if(BnumOneFour==1)
			{
				Bmark=540;
				return;
			}
			if(BnumLiveThree==1&&BnumLiveTwo<2)
			{
				Bmark=540;
				return;
			}
			if(BnumLiveThree==1)
			{
				Bmark=535;
				return;
			}
			if(BnumLiveTwo>=2)
			{
				Bmark=528;
				return;
			}
			if(BnumLiveTwo==2)
			{
				Bmark=526;
				return;
			}
			if(BnumLiveTwo==1)
			{
				Bmark=522;
				return;
			}
			Bmark=1;
			return;
			
			
			
		}
		
		
		//------------------------------------------------------------------------------------
		
		public function isFiveStoneAll():Boolean
		{
			return isFiveStoneH()||isFiveStoneV()||isFiveStoneS()||isFiveStoneBS();
		}
		
		public function isFiveStoneH():Boolean
		{
			//trace("begin isFiveStoneH");
			var flagL:Boolean=true;
			var flagR:Boolean=true;
			
			var tempPT:PointInfo=this;
			var count:int=1;//counted the current chess
			
			while(flagL)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftSpace!=null&&tempPT.LeftSpace.isEmpty==false&&tempPT.LeftSpace.isBlack==isBlack)
				{
					tempPT=tempPT.LeftSpace;//move to the next one in the left
					count++;
				}
				else
				{
					flagL=false;
					tempPT=this;//reset
				}
			}
			
			while(flagR)
			{
				if(tempPT.RightSpace!=null&&tempPT.RightSpace.isEmpty==false&&tempPT.RightSpace.isBlack==isBlack)
				{
					tempPT=tempPT.RightSpace;
					count++;
				}
				else
				{
					flagR=false;
				}
			}
			
			if(count<5)
			{
				return false;
			}
			else
			{
				return true;
			}
			
		}
		public function isFiveStoneV():Boolean
		{
			//trace("begin isFiveStoneV");
			var flagU:Boolean=true;
			var flagD:Boolean=true;
			
			var tempPT:PointInfo=this;
			var count:int=1;//counted the current chess
			
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.UpSpace!=null&&tempPT.UpSpace.isEmpty==false&&tempPT.UpSpace.isBlack==isBlack)
				{
					tempPT=tempPT.UpSpace;//move to the higher one
					count++;
				}
				else
				{
					flagU=false;
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.DownSpace!=null&&tempPT.DownSpace.isEmpty==false&&tempPT.DownSpace.isBlack==isBlack)
				{
					tempPT=tempPT.DownSpace;
					count++;
				}
				else
				{
					flagD=false;
				}
			}
			this.numV=count;
			if(count<5)
			{
				return false;
			}
			else
			{
				return true;
			}
			trace("end isFiveStoneV");
			return false;
		}
		public function isFiveStoneS():Boolean
		{
			//trace("begin isFiveStoneS");

			var flagL:Boolean=true;
			var flagR:Boolean=true;
			
			var tempPT:PointInfo=this;
			
			var count:int=1;//counted the current chess
			
			while(flagL)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftUpSpace!=null&&tempPT.LeftUpSpace.isEmpty==false&&tempPT.LeftUpSpace.isBlack==isBlack)
				{
					//move to the higher left one
					tempPT=tempPT.LeftUpSpace;
					count++;
				}
				else
				{
					flagL=false;
					tempPT=this;
				}
			}
			
			while(flagR)
			{
				if(tempPT.RightDownSpace!=null&&tempPT.RightDownSpace.isEmpty==false&&tempPT.RightDownSpace.isBlack==isBlack)
				{
					tempPT=tempPT.RightDownSpace;
					count++;
				}
				else
				{
					flagR=false;
				}
			}
			this.numS=count;
			if(count<5)
			{
				return false;
			}
			else
			{
				return true;
			}
			
			trace("end isFiveStoneS");
			return false;
		}
		public function isFiveStoneBS():Boolean
		{
			//trace("begin isFiveStoneBS");
			var flagL:Boolean=true;
			var flagR:Boolean=true;
			
			var tempPT:PointInfo=this;
			var count:int=1;//counted the current chess
			
			while(flagR)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.RightUpSpace!=null&&tempPT.RightUpSpace.isEmpty==false&&tempPT.RightUpSpace.isBlack==isBlack)
				{
					tempPT=tempPT.RightUpSpace;
					
					count++;
				}
				else
				{
					flagR=false;
					tempPT=this;
				}
			}
			
			while(flagL)
			{
				if(tempPT.LeftDownSpace!=null&&tempPT.LeftDownSpace.isEmpty==false&&tempPT.LeftDownSpace.isBlack==isBlack)
				{
					tempPT=tempPT.LeftDownSpace;
					count++;
				}
				else
				{
					flagL=false;
				}
			}
			this.numBS=count;
			if(count<5)
			{
				return false;
			}
			else
			{
				return true;
			}
			trace("end isFiveStoneBS");
			return false;
		}
		
		
		//------------------------------------------------------------------------------------

		public function calNumB(Bcount:int,des1:PointInfo,des2:PointInfo)
		{
			switch(Bcount)
			{
				case 5:
					BnumFive++;
					break;
				case 4:
					if(des1!=null&&des2!=null&&des1.isEmpty==true&&des2.isEmpty==true)
					{BnumLiveFour++;break;}//两端不为null，为空，总数为4，活4
					if((des1!=null&&des2!=null)&&des1.isEmpty==true||des2.isEmpty==true)
					{BnumOneFour++;}//两端不为null，一端为空
					if(des1==null&&des2.isEmpty==true)
					{BnumOneFour++;}//左死右活
					if(des2==null&&des1.isEmpty==true)
					{BnumOneFour++;}//右死左活
					break;
				case 3:
					if(des1==null||des2==null)
					{break;}
					if(des1.isEmpty==true&&des2.isEmpty==true)
					{BnumLiveThree++;break;}//两端为空，总数为3，活3
					break;
				case 2:
					if(des1==null||des2==null)
					{break;}
					if(des1.isEmpty==true&&des2.isEmpty==true)
					{BnumLiveTwo++;break;}//两端为空，总数为3，活3
					break;
				case 1:
					//trace("it's ",1);
					break;
				case 0:
					//trace("it's ",0);
					break;
				default:
					trace("something wrong in calH Bcount");
					break;
			}
			
		
		}
		
		public function calNumW(Wcount:int,des3:PointInfo,des4:PointInfo)
		{
			switch(Wcount)
			{
				case 5:
					WnumFive++;
					break;
				case 4:
					if(des3!=null&&des4!=null&&des3.isEmpty==true&&des4.isEmpty==true)
					{BnumLiveFour++;break;}//两端不为null，为空，总数为4，活4
					if((des3!=null&&des4!=null)&&des3.isEmpty==true||des4.isEmpty==true)
					{BnumOneFour++;}//两端不为null，一端为空
					if(des3==null&&des4.isEmpty==true)
					{BnumOneFour++;}//左死右活
					if(des4==null&&des3.isEmpty==true)
					{BnumOneFour++;}//右死左活
					break;
				case 3:
					if(des3==null||des4==null)
					{break;}
					if(des3.isEmpty==true&&des4.isEmpty==true)
					{WnumLiveThree++;break;}//两端为空，总数为3，活3
					break;
				case 2:
					if(des3==null||des4==null)
					{break;}
					if(des3.isEmpty==true&&des4.isEmpty==true)
					{WnumLiveTwo++;break;}//两端为空，总数为3，活3
					break;
				case 1:
					//trace("it's ",1);
					break;
				case 0:
					//trace("it's ",0);
					break;
				default:
					trace("something wrong in calH Wcount");
					break;
			}
		}
		
		public function calH()
		{
			//trace("begin calH");
			
			var tempPT:PointInfo=this;
			
			//两端空位，用于判断是否为活
			var des1:PointInfo;
			var des2:PointInfo;
			
			var des3:PointInfo;
			var des4:PointInfo;
			
			var Bcount:int=1;//多少个黑棋
			var Wcount:int=1;//多少个白棋
			
			//先算黑棋，进攻点
			var flagU:Boolean=true;
			var flagD:Boolean=true;
			
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftSpace!=null&&tempPT.LeftSpace.isEmpty==false&&tempPT.LeftSpace.isBlack==true)
				{
					tempPT=tempPT.LeftSpace;//move to the higher one
					Bcount++;
				}
				else
				{
					flagU=false;
					des1=tempPT.LeftSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.RightSpace!=null&&tempPT.RightSpace.isEmpty==false&&tempPT.RightSpace.isBlack==true)
				{
					tempPT=tempPT.RightSpace;
					Bcount++;
				}
				else
				{
					des2=tempPT.RightSpace;//存端点2
					flagD=false;
				}
			}
			
			//再算白棋，防守点
			
			flagU=true;
			flagD=true;
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftSpace!=null&&tempPT.LeftSpace.isEmpty==false&&tempPT.LeftSpace.isBlack==false)
				{
					tempPT=tempPT.LeftSpace;//move to the higher one
					Wcount++;
				}
				else
				{
					flagU=false;
					des3=tempPT.LeftSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.RightSpace!=null&&tempPT.RightSpace.isEmpty==false&&tempPT.RightSpace.isBlack==false)
				{
					tempPT=tempPT.RightSpace;
					Wcount++;
				}
				else
				{
					des4=tempPT.RightSpace;//存端点2
					flagD=false;
				}
			}
			
			//计算值
			calNumB(Bcount,des1,des2);
			calNumW(Wcount,des3,des4);
			
		
			
		}
		
		public function calV()
		{
			//trace("begin calV");
			
			var tempPT:PointInfo=this;
			
			//两端空位，用于判断是否为活
			var des1:PointInfo;
			var des2:PointInfo;
			
			var des3:PointInfo;
			var des4:PointInfo;
			
			var Bcount:int=1;//多少个黑棋
			var Wcount:int=1;//多少个白棋
			
			//先算黑棋，进攻点
			var flagU:Boolean=true;
			var flagD:Boolean=true;
			
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.UpSpace!=null&&tempPT.UpSpace.isEmpty==false&&tempPT.UpSpace.isBlack==true)
				{
					tempPT=tempPT.UpSpace;//move to the higher one
					Bcount++;
				}
				else
				{
					flagU=false;
					des1=tempPT.UpSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.DownSpace!=null&&tempPT.DownSpace.isEmpty==false&&tempPT.DownSpace.isBlack==true)
				{
					tempPT=tempPT.DownSpace;
					Bcount++;
				}
				else
				{
					des2=tempPT.DownSpace;//存端点2
					flagD=false;
				}
			}
			
			//再算白棋，防守点
			
			flagU=true;
			flagD=true;
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.UpSpace!=null&&tempPT.UpSpace.isEmpty==false&&tempPT.UpSpace.isBlack==false)
				{
					tempPT=tempPT.UpSpace;//move to the higher one
					Wcount++;
				}
				else
				{
					flagU=false;
					des3=tempPT.UpSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.DownSpace!=null&&tempPT.DownSpace.isEmpty==false&&tempPT.DownSpace.isBlack==false)
				{
					tempPT=tempPT.DownSpace;
					Wcount++;
				}
				else
				{
					des4=tempPT.DownSpace;//存端点2
					flagD=false;
				}
			}
			
			//计算值
			calNumB(Bcount,des1,des2);
			calNumW(Wcount,des3,des4);
		
		}
		
		public function calS()
		{
			//trace("begin calS");
			
			var tempPT:PointInfo=this;
			
			//两端空位，用于判断是否为活
			var des1:PointInfo;
			var des2:PointInfo;
			
			var des3:PointInfo;
			var des4:PointInfo;
			
			var Bcount:int=1;//多少个黑棋
			var Wcount:int=1;//多少个白棋
			
			//先算黑棋，进攻点
			var flagU:Boolean=true;
			var flagD:Boolean=true;
			
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftUpSpace!=null&&tempPT.LeftUpSpace.isEmpty==false&&tempPT.LeftUpSpace.isBlack==true)
				{
					tempPT=tempPT.LeftUpSpace;//move to the higher one
					Bcount++;
				}
				else
				{
					flagU=false;
					des1=tempPT.LeftUpSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.RightDownSpace!=null&&tempPT.RightDownSpace.isEmpty==false&&tempPT.RightDownSpace.isBlack==true)
				{
					tempPT=tempPT.RightDownSpace;
					Bcount++;
				}
				else
				{
					des2=tempPT.RightDownSpace;//存端点2
					flagD=false;
				}
			}
			
			//再算白棋，防守点
			
			flagU=true;
			flagD=true;
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftUpSpace!=null&&tempPT.LeftUpSpace.isEmpty==false&&tempPT.LeftUpSpace.isBlack==false)
				{
					tempPT=tempPT.LeftUpSpace;//move to the higher one
					Wcount++;
				}
				else
				{
					flagU=false;
					des3=tempPT.LeftUpSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.RightDownSpace!=null&&tempPT.RightDownSpace.isEmpty==false&&tempPT.RightDownSpace.isBlack==false)
				{
					tempPT=tempPT.RightDownSpace;
					Wcount++;
				}
				else
				{
					des4=tempPT.RightDownSpace;//存端点2
					flagD=false;
				}
			}
			
			//计算值
			calNumB(Bcount,des1,des2);
			calNumW(Wcount,des3,des4);
		
		}
		
		public function calBS()
		{
			//trace("begin calBS");
			
			var tempPT:PointInfo=this;
			
			//两端空位，用于判断是否为活
			var des1:PointInfo;
			var des2:PointInfo;
			
			var des3:PointInfo;
			var des4:PointInfo;
			
			var Bcount:int=1;//多少个黑棋
			var Wcount:int=1;//多少个白棋
			
			//先算黑棋，进攻点
			var flagU:Boolean=true;
			var flagD:Boolean=true;
			
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftDownSpace!=null&&tempPT.LeftDownSpace.isEmpty==false&&tempPT.LeftDownSpace.isBlack==true)
				{
					tempPT=tempPT.LeftDownSpace;//move to the higher one
					Bcount++;
				}
				else
				{
					flagU=false;
					des1=tempPT.LeftDownSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.RightUpSpace!=null&&tempPT.RightUpSpace.isEmpty==false&&tempPT.RightUpSpace.isBlack==true)
				{
					tempPT=tempPT.RightUpSpace;
					Bcount++;
				}
				else
				{
					des2=tempPT.RightUpSpace;//存端点2
					flagD=false;
				}
			}
			
			//再算白棋，防守点
			
			flagU=true;
			flagD=true;
			while(flagU)
			{
				//if the positon is occupied by a chess which is the same color as the current player
				if(tempPT.LeftDownSpace!=null&&tempPT.LeftDownSpace.isEmpty==false&&tempPT.LeftDownSpace.isBlack==false)
				{
					tempPT=tempPT.LeftDownSpace;//move to the higher one
					Wcount++;
				}
				else
				{
					flagU=false;
					des3=tempPT.LeftDownSpace;//存端点1
					tempPT=this;//reset
				}
			}
			
			while(flagD)
			{
				if(tempPT.RightUpSpace!=null&&tempPT.RightUpSpace.isEmpty==false&&tempPT.RightUpSpace.isBlack==false)
				{
					tempPT=tempPT.RightUpSpace;
					Wcount++;
				}
				else
				{
					des4=tempPT.RightUpSpace;//存端点2
					flagD=false;
				}
			}
			
			//计算值
			calNumB(Bcount,des1,des2);
			calNumW(Wcount,des3,des4);
		
		}
		//end of all calculation---------------------------------------------------------------------

	}
	
}
