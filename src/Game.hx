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
        //diceNum = Std.random(6) + 1;
        var diceInput = Sys.stdin().readLine();
        //diceNum = Sys.stdin().readLine();
        diceNum = Std.parseInt(diceInput);
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

    public function spawnNewPawn(color:Int):Bool {
        switch color{
            case 1: 
                if(field[redPositions.start] != 1) {
                    if(field[redPositions.start] != 0) {
                        if(field[redPositions.start] == 2)
                            pawnsInHouse.yellow++;
                        if(field[redPositions.start] == 3)
                            pawnsInHouse.blue++;
                        if(field[redPositions.start] == 4)
                            pawnsInHouse.green++;
                    }
                    field[redPositions.start] = 1;
                    pawnsInHouse.red--;
                    return true;
                } else {
                    //trace("error");
                    return false;
                }
            case 2:
                if(field[yellowPositions.start] != 2) {
                    if(field[yellowPositions.start] != 0) {
                        if(field[yellowPositions.start] == 1)
                            pawnsInHouse.red++;
                        if(field[yellowPositions.start] == 3)
                            pawnsInHouse.blue++;
                        if(field[yellowPositions.start] == 4)
                            pawnsInHouse.green++;
                    }
                    field[yellowPositions.start] = 2;
                    pawnsInHouse.yellow--;
                    return true;
                } else {
                    return false;
                }
            case 3: 
                if(field[bluePositions.start] != 3) {
                    if(field[bluePositions.start] != 0) {
                        if(field[bluePositions.start] == 1)
                            pawnsInHouse.red++;
                        if(field[bluePositions.start] == 2)
                            pawnsInHouse.yellow++;
                        if(field[bluePositions.start] == 4)
                            pawnsInHouse.green++;
                    }
                    field[bluePositions.start] = 3;
                    pawnsInHouse.blue--;
                    return true;
                } else {
                    return false;
                }
                case 4: 
                    if(field[greenPositions.start] != 4) {
                        if(field[greenPositions.start] != 0) {
                            if(field[greenPositions.start] == 1)
                                pawnsInHouse.red++;
                            if(field[greenPositions.start] == 2)
                                pawnsInHouse.yellow++;
                            if(field[greenPositions.start] == 3)
                                pawnsInHouse.blue++;
                        }
                        field[greenPositions.start] = 4;
                        pawnsInHouse.green--;
                        return true;
                    } else {
                        return false;
                    }
                default: return false;    
        }
        return false;
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
        var diceSix:Bool = false; 
        Sys.println('You threw ${diceNum}');
        if(diceNum == 6) {
            diceSix = true;
            if(spawnNewPawn(turnColor)) {
                Sys.println("You get an extra pawn");
                printWithPositions();
                return;
            }

        }

        //Sys.println('You threw ${diceNum}');
        printWithPositions();
        var input;
        var inputInt;
        do {
            Sys.print("Enter position of pawn to move: ");
            input = Sys.stdin().readLine();
            inputInt = Std.parseInt(input);

            if(inputInt >= 40) {
                Sys.println("Position out of bounds");
                continue;
            }

            if(move(inputInt))
                break;
        } while(true);
        print();

        if(diceSix)
            return;

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