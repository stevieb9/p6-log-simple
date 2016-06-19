use v6;

use Log::Simple;
use Test;

{ # list count

    my $l = Log::Simple.new;

    throws-like { $l.labels }, Exception, message => /exactly\s8\slabels/;
}

done-testing;
