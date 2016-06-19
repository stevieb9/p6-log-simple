use v6;

use Log::Simple;
use Test;

use-ok 'Log::Simple';

my $l = Log::Simple.new;

can-ok $l, 'labels';

dies-ok { $l.default-labels }, "default-labels() is private";
dies-ok { $l.generate-log-methods }, "default-labels() is private";
