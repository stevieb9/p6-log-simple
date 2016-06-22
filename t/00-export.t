use v6;

use Test;

plan 6;

use Log::Simple;

ok &log0 ~~ Callable, 'imported `log0`';
ok &log7 ~~ Callable, 'imported  `log1`';
ok &disable-log ~~ Callable, 'imported `disable-logging`';
ok &enable-log~~ Callable, 'imported `enable-logging`';
ok &min-log-level ~~ Callable, 'imported `min-log-level`';
ok &max-log-level ~~ Callable, 'imported `max-max-level`';

log0 "foo";
log7 "bar";

disable-log;

log0 "silent";

enable-log;

log0 "loud";

min-log-level 3;
max-log-level ( min-log-level() + 1);

log2 "silent";
log3 "loud";
log4 "loud";
log5 "silent";
