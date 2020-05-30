/**
    Iterate through InputRanges and opApply ranges and compare
    the benchmarks.
 */
module iteration;

import containers;
import utils;

__gshared int gradeTotal;
//const string INPUT_FILE = "input/input.txt";

void iterateRange(T)(T range) {
    gradeTotal = 0;
    foreach(student; range) {
        gradeTotal += student.grade;
    }
}
/*
void compareBenchmarks(StudentRange schoolRange,
    StudentContainer schoolContainer, uint nrRuns) {
    import std.datetime.stopwatch : benchmark, Duration;
    import std.stdio : writeln;

    void f0() { iterateRange(schoolRange); }
    void f1() { iterateRange(schoolContainer); }

    auto r = benchmark!(f0, f1) (nrRuns);
    Duration f0Result = r[0]; // time f0 took to run nrRuns times
    Duration f1Result = r[1]; // time f1 took to run nrRuns times

    writeln(nrRuns, ",", convertToMsecs(f0Result),
        ",", convertToMsecs(f1Result));
}*/


/*void main(string[] args) {
    import std.stdio : File;
    import std.conv : parse;

    Student[] students;
    auto f = File(INPUT_FILE);

    readInput(f, students);

    auto schoolRange = StudentRange(students);
    auto schoolContainer = StudentContainer(students);

    compareBenchmarks(schoolRange, schoolContainer, parse!uint(args[1]));
}
*/