use v6;

use Log::Simple;
use Test;
use Test::Mock;

subtest {
    use-ok 'Log::Simple';

    my $l = Log::Simple.new;

}, 'load';

subtest {
    my $l = Log::Simple.new;
    
    dies-ok { $l.default-labels }, "default-labels() is private";

}, 'private methods';

subtest {
    my $l = Log::Simple.new;
  
    my @methods;
    
    for $l.^methods {
        push @methods, .gist;
    }
             
    for <log labels level FALLBACK> -> $m {
        can-ok $l, $m;

        is
            so $m eq any(@methods),
            True,
            "$m method ok";
    }          
    is $l.^methods.elems, 4, "obj has proper method count";

}, 'public methods';

done-testing;
