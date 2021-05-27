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
    
    public function move(position:Int):Bool {
        var eventualPos = position + diceNum;
        if(eventualPos >= 40) {
            eventualPos = eventualPos - 40;
        }
        if(activePlayer.canMoveThere(position)) {
            if(activePlayer.checkForCourseCompletion(position, eventualPos)) {
                activePlayer.completeCourse(position);
                Sys.println("This pawn completed the lap");
                return true;
            }
            if(!activePlayer.checkEventualPosition(eventualPos)) // checks if the eventual position is occupied by one of your pawns
                return false;
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
        
        return false;
    }

    public function makeTheTurn() {
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
        if(input >= 40 || input < 0) {
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
            //counter++;
        }
        Sys.println("Game ended");
    }
}