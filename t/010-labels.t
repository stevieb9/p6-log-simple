use v6;

use Log::Simple;
use Test;

{ # list count

    my $l = Log::Simple.new;

    # not enough args

    throws-like { $l.labels }, Exception, message => /exactly\s8\slabels/;

    # too many args

    throws-like { $l.labels(0..8) }, Exception, message => /exactly\s8\slabels/;

    # 8 args exactly

    lives-ok { $l.labels(0..7) }, "labels() with proper arg count ok";
}

done-testing;
