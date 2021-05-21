import eval.luv.Random;

class Game
{
    private var field = [for (i in 0...40) 0];
    private var pawnsInHouse = {red: 4, yellow: 4, blue: 4, green: 4};
    private var redPositions = {start: 0, end: 39};
    private var yellowPositions = {start: 10, end: 9};
    private var bluePositions = {start: 20, end: 19};
    private var greenPositions = {start: 30, end: 29};
    private var turnColor:Int; // 1: red; 2: yellow; 3: blue; 4: green
    private var diceNum:Int; // 1-6

    public function new() {
        turnColor = 1;
    }

    public function printField() {
        for(i in field)
            Sys.println(i);
    }

    public function printPawnsInHouse() {
        Sys.println('Red: ${pawnsInHouse.red}');
        Sys.println('Yellow: ${pawnsInHouse.yellow}');
        Sys.println('Blue: ${pawnsInHouse.blue}');
        Sys.println('Green: ${pawnsInHouse.green}');
    }

    public function throwDie() {
        diceNum = Std.random(6) + 1;
    }

    public function move(position:Int) {
        var eventualPos = position + diceNum;
        if(field[position] == turnColor) { // check for pawn color or if the position is empty
            if(field[eventualPos] != turnColor) {
                if(field[eventualPos] != 0) {
                    if(field[eventualPos] == 1)
                        pawnsInHouse.red++;
                    if(field[eventualPos] == 2)
                        pawnsInHouse.yellow++;
                    if(field[eventualPos] == 3)
                        pawnsInHouse.blue++;
                    if(field[eventualPos] == 4)
                        pawnsInHouse.green++;
                }
                field[eventualPos] = turnColor;
            } else {
                Sys.println("Position is occupied by your pawn");
            }
        } else if (field[position] == 0){
           Sys.println("This position is empty");
        } else {
            Sys.println("This pawn does not belong to you");
        }
    }
}