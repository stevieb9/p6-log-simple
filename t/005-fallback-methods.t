use v6;

use IO::Capture::Simple;
use Log::Simple;
use Test;

subtest {
    my $l = Log::Simple.new;
    
    my @lvls = (0..7).map(-> $lvl { '_'~$lvl });

    for @lvls {
        my $capture = capture_stdout {
            lives-ok { $l."$_"('blah') }, "method $_ callable";
        };
    }

}, 'default log methods are callable';

subtest {
    my $l = Log::Simple.new;
    
    dies-ok { $l._0() }, 'default log methods require a message param';
    dies-ok { $l._0(1) }, 'default log methods die if a string not passed in';
    dies-ok { $l._0('blah', 1) }, 'default log methods die if called with too many params';

}, 'default log methods require a single string param';

subtest {
    my $l = Log::Simple.new;

    throws-like { $l._8('blah') }, Exception, message => /methods\sare/;

}, 'auto-gen method out-of-bounds';

done-testing;
