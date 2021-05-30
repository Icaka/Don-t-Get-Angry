import haxe.Exception;
import eval.luv.Random;
import Player;

class Game
{
    private var diceNum:Int; // 1-6
    private var gameOver:Bool;

    private var field:Field;
    private var red:Player;
    private var yellow:Player;
    private var blue:Player;
    private var green:Player;
    private var activePlayer:Player;

    public function new() {
        gameOver = false;
        field = new Field(40);
        red = new Player(1, 0, field); // 39
        yellow = new Player(2, 10, field); // 9
        blue = new Player(3, 20, field); // 19
        green = new Player(4, 30, field); // 29
        activePlayer = red;
    }

    public function printWithPositions() {
        field.print();
    }
    /*
    public function print() {
        Sys.println(field);
    }
    
    public function printField() {
        for(i in field)
            Sys.println(i);
    }
    */
    public function printPawnsInHouse() {
        Sys.println('Red: ${red.getPawnsInHouse()}');
        Sys.println('Yellow: ${yellow.getPawnsInHouse()}');
        Sys.println('Blue: ${blue.getPawnsInHouse()}');
        Sys.println('Green: ${green.getPawnsInHouse()}');
    }

    public function throwDie() {
        diceNum = Std.random(6) + 1;
        //var diceInput = Sys.stdin().readLine();
        //diceNum = Std.parseInt(diceInput);
    }
    
    public function move(position:Int):Bool {
        var eventualPos = position + diceNum;
        if(eventualPos >= field.getSize()) {
            eventualPos = eventualPos - field.getSize();
        }
        if(activePlayer.canMove(position)) {
            if(activePlayer.checkForCourseCompletion(position, eventualPos)) {
                activePlayer.completeCourse(position);
                Sys.println("This pawn completed the lap");
                return true;
            }
            if(!activePlayer.checkEventualPosition(eventualPos)) // checks if the eventual position is occupied by one of your pawns
                return false;

            freePosition(eventualPos);

            activePlayer.move(position, eventualPos);
            return true;
        } else {
            return false;
        }
        
        trace("error");
        return true;
    }

    public function freePosition(positionToFree:Int) {
        if(!field.isEmpty(positionToFree)) {
            switch field.getPawnAtPosition(positionToFree) {
                case 1: red.removePawnFromField();
                case 2: yellow.removePawnFromField();
                case 3: blue.removePawnFromField();
                case 4: green.removePawnFromField();
            }
        }
    }

    public function makeTheTurn() {
        activePlayer.printColor();
        Sys.println(" turn.");
        throwDie();
        var diceSix:Bool = false; // used to check wether the active player should be changed
        Sys.println('You threw ${diceNum}');
        if(diceNum == 6) {
            diceSix = true;
            if(activePlayer.canSpawnPawn()) {
                Sys.println("You get an extra pawn");
                freePosition(activePlayer.getStartingPosition());
                activePlayer.spawnPawn();
                printWithPositions();
                return;
            }

        }
        printWithPositions();
        if(!activePlayer.hasActivePawns()) {
            Sys.println("No pawns to move");
        } else {
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

            printWithPositions();
            if(checkWinningCondition()) {
                activePlayer.printColor();
                Sys.println(" won");
                gameOver = true;
                return;
            }

            if(diceSix)
                return;
        }

        switchActivePlayer();
    }

    public function switchActivePlayer() {
        switch activePlayer.getColor() {
            case 1: activePlayer = yellow;
            case 2: activePlayer = blue;
            case 3: activePlayer = green;
            case 4: activePlayer = red;
        }
    }

    public function checkWinningCondition():Bool {
        if(activePlayer.getSavedPawns() >= 4)
            return true;
        return false;
    }

    public function checkUserInput(input:Int):Bool {
        if(input == null) {
            Sys.println("Invalid input");
            return false;
        }
        if(input >= field.getSize() || input < 0) {
            if(input == 42) {// a quick exit
                gameOver = true;
                return false;
            }
            Sys.println("Position out of bounds");
            return false;
        }
        return true;
    }

    public function run() {
        Sys.println("Game Starts!");
        var counter = 0;
        while(!gameOver) {
            makeTheTurn();
        }
        Sys.println("Game ended");
    }
}