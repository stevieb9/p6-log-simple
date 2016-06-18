use v6;

unit class Log::Simple;

method new {
    for <foo bar> -> $y {
        self.^add_method($y, method (Int $x) { say $x; });
    }
    return self.bless;
}
