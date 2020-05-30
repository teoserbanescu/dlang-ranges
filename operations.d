/**
    This file defines the operations which are benchmarked for
    InputRanges and opApply ranges. The opApply implementations
    of the functions can be found here.
 */
module operations;

import containers;

__gshared int gradeTotal;

void iterateRange(T)(T range) {
    gradeTotal = 0;
    foreach(student; range) {
        gradeTotal += student.grade;
    }
}

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
