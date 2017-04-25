package Game  {

	import fl.motion.easing.Linear;
	
	public class Stone {
		
		public var l:int;
		public var col:int;
		public var isBlack:Boolean=true;
		/*
		public function getLine():int;
		public function getCol():int;
		public function isBlack():int;
		public function clone():Stone;
*/
		public function Stone(line:int,c:int,black:Boolean) {
			// constructor code
			l=line;
			col=c;
			isBlack=black;
		}

	}
	
}
