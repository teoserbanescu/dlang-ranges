import benchmarks : compareBenchmarks;
import containers;
import utils;

const string INPUT_FILE = "input/input.txt";

void main(string[] args) {
    import std.conv : parse;
    import std.format : format;
    import std.stdio : File, writeln;

    if (args.length != 3) {
    	writeln("Usage: %s <operation> <number_of_runs>".format(args[0]));
    }

    Student[] students;
    auto f = File(INPUT_FILE);

    readInput(f, students);

    auto schoolRange = StudentRange(students);
    auto schoolContainer = StudentContainer(students);

    compareBenchmarks(args[1], schoolRange, schoolContainer,
    	parse!uint(args[2]));
}
