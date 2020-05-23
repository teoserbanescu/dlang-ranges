import std.random;
import std.stdio;
import std.conv;

enum StudentNames {
    Ebru, Derya, Damla, Anna, John, Michael, Susan, Kate, Justin
}

void main(string[] args) {
    // seed with a constant
    Mt19937 gen;
    // Seed with an unpredictable value
    gen.seed(unpredictableSeed);

    int nrStudents = parse!int(args[1]);
    writeln(nrStudents);
    for(int i = 0; i < nrStudents; ++i) {
    	writeln(gen.uniform!StudentNames, " ", uniform(1, 11, gen));
    }
}