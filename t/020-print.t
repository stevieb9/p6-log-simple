use v6;

use Log::Simple;
use Test;

subtest {
    my $l = Log::Simple.new;

    is $l.print, True, 'print enabled by default';

    $l.print(False);
    is $l.print, False, 'and can be disabled with False';

    $l.print(True);
    is $l.print, True, '...and can be re-enabled';

    $l.print(False);
    is $l.print, False, 'instance print reset to False';

}, 'print enabled/disabled';

subtest {
    my $l = Log::Simple.new;

    is $l.print, True, 'new instance has default print setting';

}, '2nd instance print default ok';

done-testing;
