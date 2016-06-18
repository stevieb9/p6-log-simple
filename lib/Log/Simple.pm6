use v6;

unit class Log::Simple;

constant NUM-LEVELS = 7;

method new {
    for self!sub-names -> $y {
        self.^add_method($y, method (Int $x) { say $x; });
    }
    return self.bless;
}

method !sub-names {
    return (0..NUM-LEVELS).map(-> $lvl {'_'~$lvl});
}
