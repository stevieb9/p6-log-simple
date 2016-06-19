use v6;

unit class Log::Simple;

my constant LEVELS = (0..7);

method new {
    self!generate-log-methods(self!default-method-names);
    return self.bless;
}
method !default-method-names {
    return LEVELS.map(-> $lvl { '_'~$lvl });
}
method !generate-log-methods (*@labels) {
    for @labels -> $label {
        self.^add_method(
            $label, 
            method (Str $msg) {
                $msg.say;
            }    
        );
    }
}
