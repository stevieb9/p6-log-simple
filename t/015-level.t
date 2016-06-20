use v6;

use Log::Simple;
use Test;

subtest {
    my $l = Log::Simple.new;

    is $l.level, 4, 'default level is 4';

    $l.level(2);
    is $l.level, 2, 'setting level to an int ok';

    $l.level(-1);
    is $l.level, -1, 'setting level to -1 ok';

}, 'level';

done-testing;
