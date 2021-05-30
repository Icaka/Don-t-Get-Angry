import sys.io.File;
import Field;
class Player 
{
    private var color:Int;
    private var pawnsInHouse:Int;
    private var startPosition:Int;
    private var endPosition:Int;
    private var savedPawns:Int;
    private var field:Field;

    public function new(col:Int, start:Int, f:Field) {
        color = col;
        pawnsInHouse = 3;
        startPosition = start;
        savedPawns = 0;
        //if(color == 2)
        //    savedPawns = 3;
        field = f;
        field.putPawnAt(startPosition, color);
        endPosition = (startPosition - 1 + field.getSize()) % field.getSize();
        //if(color == 2)
        //    field.putPawnAt(7, color);
    }

    public function getColor():Int {
        return color;
    }

    public function getPawnsInHouse():Int {
        return pawnsInHouse;
    }

    public function getStartingPosition():Int {
        return startPosition;
    }

    public function getEndPosition():Int {
        return endPosition;
    }

    public function getSavedPawns():Int {
        return savedPawns;
    }

    public function printColor() {
        switch color
        {
            case 1: Sys.print("Red");
            case 2: Sys.print("Yellow");
            case 3: Sys.print("Blue");
            case 4: Sys.print("Green");
        }
    }

    public function savePawn() {
        savedPawns++;
    }

    public function canSpawnPawn():Bool {
        if(field.getPawnAtPosition(startPosition) == color) {
            Sys.println("Starting position is occupied");
            return false;
        }
        if(pawnsInHouse == 0) {
            Sys.println("No more pawns left in the house");
            return false;
        }
        return true;
    }

    public function spawnPawn() {
        field.putPawnAt(startPosition, color);
        pawnsInHouse--;
        
    }

    public function removePawnFromField() {
        pawnsInHouse++;
    }

    public function putPawnAtPosition(pos:Int) {
        field.putPawnAt(pos, color);
    }

    public function canMove(position:Int):Bool {
        if(field.getPawnAtPosition(position) == 0) {
            Sys.println("This position is empty");
            return false;
        }
        if(field.getPawnAtPosition(position) != color) {
            Sys.println("This pawn does not belong to you");
            return false;
        }
        return true;
    }

    public function checkEventualPosition(eventualPos:Int):Bool {
        if(field.getPawnAtPosition(eventualPos) == color) {
            Sys.println("Eventual position is occupied by your pawn");
            return false;
        }
        return true;
    }

    public function move(position:Int, eventualPos:Int) {
        field.putPawnAt(eventualPos, color);
        field.freePosition(position);
        //return true;
    }

    public function checkForCourseCompletion(position:Int, eventualPos:Int):Bool {
        if(position == endPosition)
            return true;
        if(color == 1) {
            if(eventualPos < position)
                return true;
        } else {
            if(position < endPosition && eventualPos >= startPosition && eventualPos > endPosition)
                return true;
        }

        return false;
    }

    public function completeCourse(position:Int) {
        field.freePosition(position);
        savedPawns++;
    }

    public function removePawnfromPosition(pos:Int) {
        field.freePosition(pos);
        pawnsInHouse++;
    }

    public function hasActivePawns():Bool { // returns false if there are no active pawns
        if(4 - pawnsInHouse == savedPawns)
            return false;
        return true;
    }
}