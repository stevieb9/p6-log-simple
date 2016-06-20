use v6;

unit class Log::Simple;

my constant LEVELS = (0..7);

method FALLBACK($name, $s) {
    # auto-gen the _N() methods

    if ($name ~~ / _ (\d) /) {
        my $level = $0;

            die "default log methods are _0() to _7()" if $level > 7;

        die if $
        self.^add_method($name, method (Str $msg) {
            self.log($level, $msg)
        });
        self.^compose();
        self."_$level"($s);
    }
}

method log($lvl, $msg) { 
    say "$lvl: $msg";
}

method labels (*@labels) {
    die "labels() requires exactly 8 labels sent in" if @labels.elems != 8;
}

method !default-labels {
    return LEVELS.map(-> $lvl { '_'~$lvl });
}
