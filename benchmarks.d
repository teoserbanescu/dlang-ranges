/**
    This file runs benchmarks for different functions
    using InputRanges and opApply ranges.
 */
import containers;
import utils;
import std.datetime.stopwatch : Duration;

void compareIteration(StudentRange schoolRange,
    StudentContainer schoolContainer, uint nrRuns) {
    import operations : iterateRange;
    import std.datetime.stopwatch : benchmark, Duration;
    import std.stdio : writeln;

    void f0() { iterateRange(schoolRange); }
    void f1() { iterateRange(schoolContainer); }

    auto r = benchmark!(f0, f1) (nrRuns);
    Duration f0Result = r[0]; // time f0 took to run nrRuns times
    Duration f1Result = r[1]; // time f1 took to run nrRuns times

    writeln(nrRuns, ",", convertToMsecs(f0Result),
        ",", convertToMsecs(f1Result));
}

void compareFilter(StudentRange schoolRange,
    StudentContainer schoolContainer, uint nrRuns) {
    import operations : filterOpApply;
    import std.algorithm : filter;
    import std.datetime.stopwatch : benchmark, Duration;
    import std.stdio: writeln;

    void f0() { schoolRange.filter!(student => student.grade != 10); }
    void f1() { schoolContainer.filterOpApply!(student =>
        student.grade != 10); }

    auto r = benchmark!(f0, f1) (nrRuns);
    Duration f0Result = r[0]; // time f0 took to run nrRuns times
    Duration f1Result = r[1]; // time f1 took to run nrRuns times

    writeln(nrRuns, ",", convertToMsecs(f0Result),
        ",", convertToMsecs(f1Result));
}

void compareMap(StudentRange schoolRange,
    StudentContainer schoolContainer, uint nrRuns) {
    import operations : mapOpApply;
    import std.algorithm : map, min;
    import std.datetime.stopwatch : benchmark, Duration;
    import std.stdio: writeln;

    void f0() { schoolRange.map!(student =>
        (min(student.grade + 1, 10))); }
    void f1() { schoolContainer.mapOpApply!(student =>
        (min(student.grade + 1, 10))); }

    auto r = benchmark!(f0, f1) (nrRuns);
    Duration f0Result = r[0]; // time f0 took to run nrRuns times
    Duration f1Result = r[1]; // time f1 took to run nrRuns times

    writeln(nrRuns, ",", convertToMsecs(f0Result),
        ",", convertToMsecs(f1Result));
}


void compareMapFilter(StudentRange schoolRange,
    StudentContainer schoolContainer, uint nrRuns) {
    import operations : filterOpApply;
    import operations : mapOpApply;
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

void compareBenchmarks(string operation, StudentRange schoolRange,
    StudentContainer schoolContainer, uint nrRuns) {
    import std.datetime.stopwatch : Duration;
    import std.stdio : writeln;

    switch (operation) {
        case "iterate":
            compareIteration(schoolRange, schoolContainer, nrRuns);
            break;
        case "filter":
            compareFilter(schoolRange, schoolContainer, nrRuns);
            break;
        case "map":
            compareMap(schoolRange, schoolContainer, nrRuns);
            break;
        case "mapfilter":
            compareMapFilter(schoolRange, schoolContainer, nrRuns);
            break;
        default:
            writeln("Wrong operation type. The available options are: " ~
                "iterate, filter, map, mapfilter");
            break;
    }
}