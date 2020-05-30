/**
    Apply map functions on InputRanges and opApply ranges and
    compare the benchmarks.
 */
module map;

import containers;
import utils;

const string INPUT_FILE = "input/input.txt";

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
