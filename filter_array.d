/**
    Apply filter functions on InputRanges and opApply ranges and
    compare the benchmarks.
 */
module filter;

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
