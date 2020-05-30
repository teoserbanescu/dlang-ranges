/**
    Apply combinations of filter and map functions on InputRanges and
    opApply ranges and compare the benchmarks.
 */
import containers;
import utils;

const string INPUT_FILE = "input/input.txt";

struct FilterOpApplyResult(alias pred, Rng) {
    import std.traits: ForeachType;

    alias T = ForeachType!Rng;
    Rng r;

    int opApply(int delegate(T) dlg) {
        foreach(item; r) {
            if(pred(item)) {
                if(int rc = dlg(item)) return rc;
            }
        }
        return 0;
    }
}
auto filterOpApply(alias pred, Rng)(Rng r) {
    return FilterOpApplyResult!(pred, Rng)(r);
}

struct MapOpApplyResult(alias fun, Rng) {
    import std.traits: ForeachType;

    alias T = ForeachType!Rng;
    Rng r;

    int opApply(int delegate(typeof(fun(T.init))) dlg) {
        foreach(item; r) {
            if(int rc = dlg(fun(item))) return rc;
        }
        return 0;
    }
}
auto mapOpApply(alias fun, Rng)(Rng r) {
    return MapOpApplyResult!(fun, Rng)(r);
}

void compareBenchmarks(StudentRange schoolRange,
    StudentContainer schoolContainer, uint nrRuns) {
    import std.algorithm : filter, map, min;
    import std.datetime.stopwatch : benchmark, Duration;
    import std.stdio: writeln;

    /* Compose more filter and map calls, alternatively. */
    void f0() { schoolRange.map!(student =>
        Student(student.name, (min(student.grade + 1, 10))))
        .filter!(student => (student.grade != 10))
        .map!(student => Student(student.name,
            (min(student.grade + 1, 10))))
        .filter!(student => (student.grade != 10)); }
    void f1() { schoolContainer.mapOpApply!(student =>
        Student(student.name, (min(student.grade + 1, 10))))
        .filterOpApply!(student => (student.grade != 10))
        .mapOpApply!(student => Student(student.name,
            (min(student.grade + 1, 10))))
        .filterOpApply!(student => (student.grade != 10)); }

    auto r = benchmark!(f0, f1) (nrRuns);
    Duration f0Result = r[0]; // time f0 took to run nrRuns times
    Duration f1Result = r[1]; // time f1 took to run nrRuns times

    writeln(nrRuns, ",", convertToMsecs(f0Result),
        ",", convertToMsecs(f1Result));
}

void main(string[] args) {
    import std.conv : parse;
    import std.stdio : File;

    Student[] students;
    auto f = File(INPUT_FILE);

    readInput(f, students);

    auto schoolRange = StudentRange(students);
    auto schoolContainer = StudentContainer(students);

    compareBenchmarks(schoolRange, schoolContainer, parse!uint(args[1]));
}