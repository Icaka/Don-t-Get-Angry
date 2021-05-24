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
		p1.putPawnAtPosition(10);
		p1.putPawnAtPosition(15);
		p2.putPawnAtPosition(11);
		p2.putPawnAtPosition(14);
		terrain.print();
	}
}
