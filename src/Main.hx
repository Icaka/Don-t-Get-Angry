import Game;
import Player;
class Main {
	static function main() {
		//trace("Hello, world!");
		//var game = new Game();
		//game.printPawnsInHouse();
		//game.run();
		var terrain = new Field();
		var p1 = new Player(1, 0, 39, terrain);
		var p2 = new Player(2, 10, 9, terrain);
		var p3 = new Player(3, 20, 19, terrain);
		var p4 = new Player(4, 30, 29, terrain);
		//p1.putPawnAtPosition(10);
		//p1.putPawnAtPosition(15);
		//p2.putPawnAtPosition(11);
		//p2.putPawnAtPosition(14);
		terrain.print();
	}
}
