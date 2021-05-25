class Field
{
    public var field:Array<Int>;

    public function new() {
        field = [for (i in 0...40) 0];
    }

    public function print() {
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

    public function putPawnAt(pos:Int, color:Int) {
        field[pos] = color;
    }

    public function freePosition(pos:Int) {
        field[pos] = 0;
    }

    public function placeStartingPawns() {
        
    }

    public function getPawnAtPosition(pos:Int):Int {
        return field[pos];
    }
}