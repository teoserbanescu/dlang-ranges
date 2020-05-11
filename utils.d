import containers;
import std.datetime.stopwatch;
import std.stdio;

/* TODO: This is a temporary solution. Generate the input at runtime instead. */
void readInput(File f, ref Student[] students) {
    int nrStudents;
    f.readf("%d\n", nrStudents);

    for(auto i = 0; i < nrStudents; ++i)
    {
        int grade;
        string name;
        f.readf("%s %d\n", name, grade);
        students.length = students.length + 1;
        students[students.length - 1] = Student(name, grade);
    }
}

double convertToMsecs(Duration result) {
    long seconds, msecs, usecs, hnsecs;
    result.split!("seconds", "msecs", "usecs", "hnsecs")
        (seconds, msecs, usecs, hnsecs);
    return seconds * 1000 + msecs + usecs * 0.001 + hnsecs * 0.000001;
}

void printRange(T)(T range) {
    foreach(elem; range) {
        write(elem, ' ');
    }
    writeln();
}
