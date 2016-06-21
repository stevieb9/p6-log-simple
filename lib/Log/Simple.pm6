use v6;

my constant LEVELS = (0..7);

my Bool $enabled = True;
my Int $min-level = 0;
my Int $max-level = 7;
my @stream = $*ERR;

sub log($level, *@msg) {
	return unless $enabled;
	return if $min-level > $level || $level > $max-level;
	@stream>>.put("$level: ", $_) for @msg;
}

multi sub min-level (Int $new-level) { $min-level = $new-level }
multi sub min-level ()               { $min-level }
                                     
multi sub max-level (Int $new-level) { $max-level = $new-level }
multi sub max-level ()               { $max-level }

multi sub to-file (Str $path, :$mode = :w ) { @stream = $path.IO.open(|$mode) }
multi sub to-file (IO::Handle $io) { @stream = $io }

mutli sub add-file (Str $path, :$mode = :w ) { @stream.push: $path.IO.open(|$mode) }
multi sub add-file (IO::Handle $io) { @stream.push: $io }

multi sub to-stdout () { @stream = $*OUT }
multi sub to-stderr () { @stream = $*ERR }

sub EXPORT {
	my Map $ret-map = Map.new(
		(("&log" xx * Z~ LEVELS) Z=> LEVELS.map: { &log.assuming($_) } ),
		"&disable-logging" => sub { $enabled = False },
		"&enable-logging" => sub { $enabled = True },
		"&min-log-level" => &min-level, 
		"&max-log-level" => &max-level,
		"&log-to-file" => &to-file,
		"&log-to-stdout" => &to-stdout,
		"&log-to-stderr" => &log-to-stderr,
		"&log-add-file" => &add-file,
	);
#	dd $ret-map;
	$ret-map;
}
