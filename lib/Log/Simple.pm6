use v6;

unit class Log::Simple;

my constant LEVELS = (0..7);

has Bool $!disabled = False;
has Int $!log-only = -1;
has Bool $!print = True;
has Int $!set-level = 4;

method FALLBACK($name, $s) {
    # auto-gen the _N() methods

    if ($name ~~ / _ (\d) /) {
        my $level = $0;

        die "default log methods are _0() to _7()" if $level > 7;

        self.^add_method($name, method (Str $msg) {
            self.log($level, $msg)
        });
        self.^compose();
        self."_$level"($s);
    }
}

method log ($lvl, $msg) { 
    return if $!disabled;
    say "$lvl: $msg";
}

method print (Bool $print?) {
    return $!print if ! defined $print;
    $!print = $print;
}
method labels (*@labels) {
    die "labels() requires exactly 8 labels sent in" if @labels.elems != 8;
}

method level ($level?) {

    if ! defined $level {
        return $!set-level;
    }

    if defined $level {
        die "$level is invalid\n" if $level !~~ /^('-'||'=')?\d+$/;

        if $level ~~ /^'-'/ {
            $!set-level = -1;
            $!disabled = True;
        }
        elsif ($level ~~ /^'='(\d+)$/) {
            $!log-only = $0;
           
        }
        else {
            $!disabled = False;
            $!log-only = -1;
            $!set-level = $level;
        }
        return $!set-level;
    }
}

method !default-labels {
    return LEVELS.map(-> $lvl { '_'~$lvl });
}
