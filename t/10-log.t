use v6;

use Log::Simple;
use Test;

log-stdout(False);

my $ret;

$ret = log0 'zero';
is $ret, 'zero', "log0 ok";
$ret = log1 'one';
is $ret, 'one', "log1 ok";
$ret = log2 'two';
is $ret, 'two', "log2 ok";
$ret = log3 'three';
is $ret, 'three', "log3 ok";
$ret = log4 'four';
is $ret, 'four', "log4 ok";
$ret = log5 'five';
is $ret, 'five', "log5 ok";
$ret = log6 'six';
is $ret, 'six', "log6 ok";
$ret = log7 'seven';
is $ret, 'seven', "log7 ok";

throws-like { EVAL 'log8 "die"' }, Exception, message => /Undeclared\sroutine/;

# min-log-level 3;
# max-log-level ( min-log-level() + 1);

done-testing;
