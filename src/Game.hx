import haxe.Exception;
import eval.luv.Random;
import Player;

class Game
{
    /*
    private var field = [for (i in 0...40) 0];
    private var pawnsInHouse = {red: 4, yellow: 4, blue: 4, green: 4};
    private var redPositions = {start: 0, end: 39};
    private var yellowPositions = {start: 10, end: 9};
    private var bluePositions = {start: 20, end: 19};
    private var greenPositions = {start: 30, end: 29};
    private var turnColor:Int; // 1: red; 2: yellow; 3: blue; 4: green
    */
    private var diceNum:Int; // 1-6
    private var gameOver:Bool;
    /*
    private var savedRedPawns:Int;
    private var savedYellowPawns:Int;
    private var savedBluePawns:Int;
    private var savedGreenPawns:Int;
    */
    private var field:Field;
    private var red:Player;
    private var yellow:Player;
    private var blue:Player;
    private var green:Player;
    private var activePlayer:Player;

    public function new() {
        gameOver = false;
        field = new Field();
        red = new Player(1, 0, 39, field);
        yellow = new Player(2, 10, 9, field);
        blue = new Player(3, 20, 19, field);
        green = new Player(4, 30, 29, field);
        activePlayer = red;
        /*
        turnColor = 1;
        field[redPositions.start] = 1;
        field[yellowPositions.start] = 2;
        field[bluePositions.start] = 3;
        field[greenPositions.start] = 4;
        pawnsInHouse.red--;
        pawnsInHouse.yellow--;
        pawnsInHouse.blue--;
        pawnsInHouse.green--;
        savedRedPawns = 0;
        savedYellowPawns = 0;
        savedBluePawns = 0;
        savedGreenPawns = 0;
        */
    }

    public function printWithPositions() {
        field.print();
        /*for(i in 0...40) {
            if(i > 9)
                Sys.print(" ");
            Sys.print('${field[i]}  ');
        }
        Sys.println(" ");
        for(i in 0...40)
            Sys.print('${i}  ');
        Sys.println(" ");
        */
    }
    /*
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
    */
    public function throwDie() {
        //diceNum = Std.random(6) + 1;
        var diceInput = Sys.stdin().readLine();
        //diceNum = Sys.stdin().readLine();
        diceNum = Std.parseInt(diceInput);
    }
    /*
    private function completeCourse(pos:Int) {
        
        switch field[pos] {
            case 1: savedRedPawns++;
            case 2: savedYellowPawns++;
            case 3: savedBluePawns++;
            case 4: savedGreenPawns++;
        }
        field[pos] = 0;
    }
    
    private function checkForCompletionOfCourse(position:Int, eventualPos:Int):Bool {
        var startPos;
        var endPos;
        switch turnColor {
            case 1: startPos = redPositions.start;
                    endPos = redPositions.end;
            case 2: startPos = yellowPositions.start;
                    endPos = yellowPositions.end;
            case 3: startPos = bluePositions.start;
                    endPos = bluePositions.end;
            case 4: startPos = greenPositions.start;
                    endPos = greenPositions.end;
            default: startPos = 0;
                    endPos = 0;
        }
        
        
        if(position == endPos)
            return true;
        if(turnColor == 1) // red color is a special case
            if(position + diceNum > 39)
                return true;
        if(position < endPos && eventualPos >= startPos && eventualPos > endPos)
            return true;

        return false;
    }
    */
    public function move(position:Int):Bool {
        var eventualPos = position + diceNum;
        if(eventualPos > 40) {
            eventualPos = eventualPos - 40;
        }
        if(activePlayer.canMoveThere(position, eventualPos)) {
            if(!field.isEmpty(eventualPos)) {
                switch field.getPawnAtPosition(eventualPos) {
                    case 1: red.removePawnFromField();
                    case 2: yellow.removePawnFromField();
                    case 3: blue.removePawnFromField();
                    case 4: green.removePawnFromField();
                }
            }
            activePlayer.move(position, eventualPos);
            return true;
        } else {
            return false;
        }
        /*
        if(field[position] == turnColor) { // check for pawn color or if the position is empty
            if(checkForCompletionOfCourse(position, eventualPos)) {
                completeCourse(position);
                Sys.println("This pawn completed the lap");
                return true;
            }
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
        */
        trace("error");
        return true;
    }

    public function spawnNewPawn(color:Int):Bool {
        if(activePlayer.canSpawnPawn()) {
            if(!field.isEmpty(activePlayer.getStartingPosition())) {
                switch field.getPawnAtPosition(activePlayer.getStartingPosition()) {
                    case 1: red.removePawnFromField();
                    case 2: yellow.removePawnFromField();
                    case 3: blue.removePawnFromField();
                    case 4: green.removePawnFromField();
                }
            }
            activePlayer.spawnPawn();
            return true;
        } else {
            return false;
        }
        /*
        switch color{
            case 1: 
                if(field[redPositions.start] != 1) {
                    if(pawnsInHouse.red > 0) { // checks if there are pawns left in the house
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
                        return false;
                    }
                } else {
                    //trace("error");
                    return false;
                }
            case 2:
                if(field[yellowPositions.start] != 2 && pawnsInHouse.yellow > 0) {
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
                if(field[bluePositions.start] != 3 && pawnsInHouse.blue > 0) {
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
                    if(field[greenPositions.start] != 4 && pawnsInHouse.green > 0) {
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
        */
        return false;
    }

    public function makeTheTurn() {
        /*
        switch turnColor
        {
            case 1: Sys.print("Red");
            case 2: Sys.print("Yellow");
            case 3: Sys.print("Blue");
            case 4: Sys.print("Green");
        }*/
        activePlayer.printColor();
        Sys.println(" turn.");
        throwDie();
        var diceSix:Bool = false; 
        Sys.println('You threw ${diceNum}');
        if(diceNum == 6) {
            diceSix = true;
            if(activePlayer.canSpawnPawn()) {
                Sys.println("You get an extra pawn");
                activePlayer.spawnPawn();
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

            if(!checkUserInput(inputInt)) {
                if(gameOver)
                    return;
                continue;
            }
            
            if(move(inputInt))
                break;

        } while(true);
        //print();
        printWithPositions();

        if(diceSix)
            return;
        /*
        if(turnColor == 4) {
            turnColor = 1;
        } else {
            turnColor++;
        }
        */
        switch activePlayer.getColor() {
            case 1: activePlayer = yellow;
            case 2: activePlayer = blue;
            case 3: activePlayer = green;
            case 4: activePlayer = red;
        }
    }

    public function checkUserInput(input:Int):Bool {
        if(input == null) {
            Sys.println("Invalid input");
            return false;
        }
        if(input >= 40 || input < 0) {
            if(input == 42) {// a quick exit
                gameOver = true;
                return false;
            }
            Sys.println("Position out of bounds");
            return false;
        }
        /*
        if(Std.isOfType(input, Float)) {
            Sys.println("No floats");
            return false;
        }
        */
        return true;
    }

    public function run() {
        Sys.println("Game Starts!");
        var counter = 0;
        while(!gameOver) {
            makeTheTurn();
            //counter++;
        }
        Sys.println("Game ended");
    }
}