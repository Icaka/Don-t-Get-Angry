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
        field[redPositions.start] = 1;
        field[yellowPositions.start] = 2;
        field[bluePositions.start] = 3;
        field[greenPositions.start] = 4;
    }

    public function printWithPositions() {
        for(i in 0...40) {
            if(i > 9)
                Sys.print(" ");
            Sys.print('${field[i]}  ');
        }
        Sys.println(" ");
        for(i in 0...40)
            Sys.print('${i}  ');
        Sys.println(" ");
    }

    public function print() {
        Sys.println(field);
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

    public function move(position:Int):Bool {
        var eventualPos = position + diceNum;
        if(eventualPos > 40) {
            eventualPos = eventualPos - 40;
        }
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
                field[position] = 0;
                field[eventualPos] = turnColor;
                return true;
            } else {
                Sys.println("Position is occupied by your pawn");
                return false;
            }
        } else if (field[position] == 0){
           Sys.println("This position is empty");
           return false;
        } else {
            Sys.println("This pawn does not belong to you");
            return false;
        }
    }

    public function makeTheTurn() {
        switch turnColor
        {
            case 1: Sys.print("Red");
            case 2: Sys.print("Yellow");
            case 3: Sys.print("Blue");
            case 4: Sys.print("Green");
        }
        Sys.println(" turn.");
        throwDie();
        Sys.println('You threw ${diceNum}');
        printWithPositions();
        var input;
        var inputInt;
        do {
            Sys.print("Enter position of pawn to move: ");
            input = Sys.stdin().readLine();
            inputInt = Std.parseInt(input);
            if(move(inputInt))
                break;
        } while(true);
        print();

        if(turnColor == 4) {
            turnColor = 1;
        } else {
            turnColor++;
        }
    }

    public function run() {
        Sys.println("Game Starts!");
        var counter = 0;
        while(counter < 15) {
            makeTheTurn();
            counter++;
        }
        Sys.println("Game ended");
    }
}