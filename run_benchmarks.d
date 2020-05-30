import benchmarks : compareBenchmarks;
import containers;
import utils;

const string INPUT_FILE = "input/input.txt";

void main(string[] args) {
    import std.stdio : File;
    import std.conv : parse;

    Student[] students;
    auto f = File(INPUT_FILE);

    readInput(f, students);

    auto schoolRange = StudentRange(students);
    auto schoolContainer = StudentContainer(students);

    compareBenchmarks(args[1], schoolRange, schoolContainer,
    	parse!uint(args[2]));
}
