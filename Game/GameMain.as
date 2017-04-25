package Game{
	import fl.controls.progressBarClasses.IndeterminateBar;
	import flash.display.MovieClip;
	import UI.ChessBox;
	import UI.Chess;
	import Game.PointInfo;
	
	public class GameMain extends MovieClip{
		
		public var isGaming:Boolean=true;
		public var StoneRectangle:Array=new Array();
		
		public function GameMain() {}
		public function initialGameMain() 
		{

			// constructor code
			for(var i:int=0;i<15;i++)
			{
				for(var j:int=0;j<15;j++)
				{
					var tempPI:PointInfo=new PointInfo(i,j);
					StoneRectangle.push(tempPI);
				}
				
			}
			
			//更新每一个点的相邻位置信息
			for(var s:int=0;s<15;s++)
			{
				for(var k:int=0;k<15;k++)
				{
					//更新相邻位置信息
					if((s-1)>=0)
					{StoneRectangle[s*15+k].UpSpace=StoneRectangle[(s-1)*15+k];}
					if((s+1)<15)
					{StoneRectangle[s*15+k].DownSpace=StoneRectangle[(s+1)*15+k];}
					if((k-1)>=0)
					{StoneRectangle[s*15+k].LeftSpace=StoneRectangle[s*15+(k-1)];}
					if((k+1)<15)
					{StoneRectangle[s*15+k].RightSpace=StoneRectangle[s*15+(k+1)];}
					
					if((s-1)>=0&&(k-1)>=0)
					{StoneRectangle[s*15+k].LeftUpSpace=StoneRectangle[(s-1)*15+(k-1)];}
					if((k-1)>=0&&(s+1)<15)
					{StoneRectangle[s*15+k].LeftDownSpace=StoneRectangle[(s+1)*15+(k-1)];}
					if((s-1)>=0&&(k+1)<15)
					{StoneRectangle[s*15+k].RightUpSpace=StoneRectangle[(s-1)*15+(k+1)];}
					if((s+1)<15&&(k+1)<15)
					{StoneRectangle[s*15+k].RightDownSpace=StoneRectangle[(s+1)*15+(k+1)];}
					
				}
			}
			
			/*成功打印for(var m:int=0;m<15;m++){for(var n:int=0;n<15;n++){trace("StoneRectangle[",m,"][",n,"]=",StoneRectangle[m][n]);}}*/
			
			
		}
		
	
	
		public function updateStoneRec(s:Stone)
		{
			//更新棋盘信息
			StoneRectangle[s.l*15+s.col].updatePointInfo(s);
			if(StoneRectangle[s.l*15+s.col].isFiveStone==true)
			{
				isGaming=false;
			}
		}
		
		public function isPosiIsEmpty(l:Number,c:Number):Boolean
		{
			//trace("is the postion empty?",StoneRectangle[l*15+c].isEmpty)
			return StoneRectangle[l*15+c].isEmpty;
		}
		
		public function AISelect(minL:int,maxL:int,minC:int,maxC:int):Stone
		{
			var maxPT:PointInfo;
			
			//矫正数字以免出界
			if(minL==0){minL=1;}
			if(minC==0){minL=1;}
			if(maxL==14){maxL=13;}
			if(maxC==14){maxC=13;}
			maxPT=null;
			
			//trace("minL=",minL,"maxL=",maxL,"minC=",minC,"maxC=",maxC);
			//trace("checking squre is","minL=",minL-1,"maxL=",maxL+1,"minC=",minC-1,"maxC=",maxC+1);
			//遍历所有空棋位，计算pointInfo，并打分，只存分值最大的（有更大的就替换）
			for(var s:int=minL-1;s<maxL+2;s++)
			{
				for(var k:int=minC-1;k<maxC+2;k++)
				{
					trace("in Loop","s=",s,"k=",k);
					//计算并打分
					StoneRectangle[s*15+k].calculatePointInfo();
					
					//高于0，若maxPT为null，则先存下来，否则比较大小，存较大的

					if(maxPT==null)
					{
						maxPT=StoneRectangle[s*15+k];
					}
					if(StoneRectangle[s*15+k].MXmark>maxPT.MXmark)
					{
						maxPT=StoneRectangle[s*15+k];
					}
					
					
				}
			}
			trace("the mark is ","l=",maxPT.l,"c=",maxPT.col,"MXmark=",maxPT.MXmark);
			
			
			return new Stone(maxPT.l,maxPT.col,false);
		}
	}
	
}
