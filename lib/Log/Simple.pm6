use v6;

unit class Log::Simple;

my constant LEVELS = (0..7);

method new {
    self!generate-log-methods(self!default-labels);
    return self.bless;
}
method labels (*@labels) {
    die "labels() requires exactly 8 labels sent in" if @labels.elems != 8;
}
method !default-labels {
    return LEVELS.map(-> $lvl { '_'~$lvl });
}
method !generate-log-methods (*@labels) {
    for @labels -> $label {
        self!add-method($label);
    }
}
method !add-method (Str $label) {
    self.^add_method(
        $label, 
        method (Str $msg) {
            $msg.say;
        }    
    );
}
