use v6;

use Log::Simple;
use Test;
use Test::Mock;

subtest {
    use-ok 'Log::Simple';

    my $l = Log::Simple.new;

    can-ok $l, 'labels';

}, 'load/can';

subtest {
    my $l = Log::Simple.new;
    
    dies-ok { $l.default-labels }, "default-labels() is private";
    dies-ok { $l.generate-log-methods }, "generate-log-methods() is private";

}, 'private methods';

subtest {
    my $l = Log::Simple.new;
    
    is $l.^methods.elems, 10, "obj has proper method count";

}, 'method count';

subtest {
    my $l = mocked(Log::Simple);

    check-mock {
        $l,
        *.called('default-labels'),
        *.called('generate-log-methods');
    };

}, 'proper call chain';

done-testing;
