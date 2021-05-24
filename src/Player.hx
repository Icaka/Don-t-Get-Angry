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

    public function spawnPawn() {
        
    }

    public function putPawnAtPosition(pos:Int) {
        field.putPawnAt(pos, color);
    }
}