/**
Containers based on InputRanges and OpApply Ranges
 */

struct Student {
    string name;
    int grade;

    @safe string toString() const {
        import std.format : format;

        return "%s(%s)".format(name, grade);
    }

    @property bool isMaxGrade() {
        return grade == 10;
    }
}

struct StudentRange {
    Student[] students;

    @property ref Student front() {
        return students[0];
    }

    @property bool empty() const {
        return students.length == 0;
    }

    void popFront() {
        students = students[1 .. $];
    }
}

struct StudentContainer {
    Student[] students;

    int opApply(int delegate(ref const Student) dg) const {
        foreach(student; students) {
            if (int rc = dg(student)) return rc;
        }
        return 0;
    }
}
