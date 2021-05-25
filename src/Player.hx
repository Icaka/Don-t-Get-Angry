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

    public function new(col:Int, start:Int, end:Int, f:Field) {
        color = col;
        pawnsInHouse = 3;
        startPosition = start;
        endPosition = end;
        savedPawns = 0;
        field = f;
        field.putPawnAt(startPosition, color);
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

    public function canMoveThere(position:Int, eventualPosition:Int):Bool {
        if(field.getPawnAtPosition(position) != color) {
            Sys.println("This pawn does not belong to you");
            return false;
        }
        if(field.getPawnAtPosition(position) == 0) {
            Sys.println("This position is empty");
            return false;
        }
        if(field.getPawnAtPosition(eventualPosition) == color) {
            Sys.println("Position is occupied by your pawn");
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
            if(position > 30 && eventualPos < 10)
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
}