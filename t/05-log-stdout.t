use v6;

use IO::Capture::Simple;
use Log::Simple;
use Test;

my $out = capture_stdout { log0('enabled'); };

is $out, "enabled\n", 'log-stdout() enabled ok';

log-stdout(False);

my $ret;
$out = capture_stdout { $ret = log0('disabled') };

is $out, Any, 'log-stdout() disabled doesnt print';
is $ret, 'disabled', 'log-stdout() disabled returns the msg';

log-stdout(True);

$ret = '';
$out = capture_stdout { $ret = log0('re-enabled'); };

is $out, "re-enabled\n", 'log-stdout() re-enabled ok';
is $ret, "re-enabled\n", "log-stdout() enabled returns as well as prints, and has newline";

log-stdout(False);

$ret = '';
$out = capture_stdout { $ret = log0('re-disabled'); };

is $out, Any, 'log-stdout() re-disabled ok';
is $ret, "re-disabled", "log-stdout() returns only, with no newline";

done-testing;
