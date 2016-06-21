use v6;

my constant LEVELS = (0..7);

my Bool $enabled = True;
my Int $min-level = 0;
my Int $max-level = 7;

sub log($level, *@msg) {
	return unless $enabled;
	return if $min-level > $level || $level > $max-level;
	put("$level: ", $_) for @msg;
}

multi sub min-level (Int $new-level) { $min-level = $new-level }
multi sub min-level ()               { $min-level }
                                     
multi sub max-level (Int $new-level) { $max-level = $new-level }
multi sub max-level ()               { $max-level }

sub EXPORT {
	my Map $ret-map = Map.new(
		(("&log" xx * Z~ LEVELS) Z=> LEVELS.map: { &log.assuming($_) } ),
		"&disable-logging" => sub { $enabled = False },
		"&enable-logging" => sub { $enabled = True },
		"&min-log-level" => &min-level, 
		"&max-log-level" => &max-level,
	);
#	dd $ret-map;
	$ret-map;
}
