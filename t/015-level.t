use v6;

use Log::Simple;
use Test;

subtest {
    my $l = Log::Simple.new;

    is $l.level, 4, 'default level is 4';

}, 'level';
