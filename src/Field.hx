class Field
{
    public var field:Array<Int>;
    public var size:Int;
    public function new(newSize:Int) {
        size = newSize;
        field = [for (i in 0...size) 0];
    }

    public function print() {
        for(i in 0...size) {
            if(i > 9)
                Sys.print(" ");
            Sys.print('${field[i]}  ');
        }
        Sys.println(" ");
        for(i in 0...size)
            Sys.print('${i}  ');
        Sys.println(" ");
    }

    public function putPawnAt(pos:Int, color:Int) {
        field[pos] = color;
    }

    public function freePosition(pos:Int) {
        field[pos] = 0;
    }
    /*
    public function placeStartingPawns() {
        
    }
    */
    public function getPawnAtPosition(pos:Int):Int {
        return field[pos];
    }

    public function isEmpty(pos:Int):Bool {
        if(field[pos] == 0)
            return true;
        return false;
    }

    public function getSize():Int {
        return size;
    }
}