use v6;

my constant LEVELS = (0..7);

my Bool $enabled = True;
my Int $min-level = 0;
my Int $max-level = 7;

my $log-only = False;

my $stdout = True;
my @stream = $*OUT;

sub log($level, Str $msg) {
	return unless $enabled;
    
    if ($log-only !~~ Bool && $level != $log-only) {
        return;
    }
	return if $min-level > $level || $level > $max-level;

    if $stdout {
    	put $msg; 
    }
    else {
        return $msg;
    }
}
multi sub log-stdout (Bool $log-stdout) {
    $stdout = $log-stdout;
    @stream = $stdout ?? $*OUT !! ();
}
multi sub log-stdout () { $stdout }

multi sub min-level (Int $new-level) { $min-level = $new-level }
multi sub min-level ()               { $min-level }
                                     
multi sub max-level (Int $new-level) { $max-level = $new-level }
multi sub max-level ()               { $max-level }

multi sub log-only (Int $log-lvl-only) { $log-only = $log-lvl-only }
multi sub log-only (Bool $only?) {
    if ! defined $only {
        return $log-only;
    }
    $log-only = False;
    return $log-only;
}

sub EXPORT {
	my Map $ret-map = Map.new(
		(("&log" xx * Z~ LEVELS) Z=> LEVELS.map: { &log.assuming($_) } ),
		"&disable-log" => sub { $enabled = False },
		"&enable-log" => sub { $enabled = True },
		"&min-log-level" => &min-level, 
		"&max-log-level" => &max-level,
        "&log-stdout" => &log-stdout,
        "&log-only" => &log-only,
	);
#	dd $ret-map;
	$ret-map;
}
