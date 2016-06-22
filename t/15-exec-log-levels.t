use v6;

use Log::Simple;
use Test;

log-stdout(False);

subtest {
    min-log-level 0;

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        push @ret, call "$lvl";
    }

    is min-log-level(), 0, 'min level ok';
    is max-log-level(), 7, 'max level ok';
    is @ret.elems, 8, 'default max/min ok';

}, 'min-log-level all';

subtest {
    min-log-level 4;

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        my $cur = call "$lvl";
        push @ret, "$cur" if $cur.WHAT ~~ Str;
    }

    is min-log-level(), 4, 'min level ok';
    is max-log-level(), 7, 'max level ok';
    is @ret.elems, 4, 'min at 4 ok';

    for @ret -> $val {
        is so $val == (4..7).any, True, "$val ok with min level";
    }

}, 'min-log-level 4+';

subtest {
    min-log-level 0;
    max-log-level 3;

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        my $cur = call "$lvl";
        push @ret, "$cur" if $cur.WHAT ~~ Str;
    }

    is min-log-level(), 0, 'min level ok';
    is max-log-level(), 3, 'max level ok';
    is @ret.elems, 4, 'min at 4 ok';

    for @ret -> $val {
        is so $val == (0..3).any, True, "$val ok with max level";
    }

}, 'max-log-level 3';

subtest {
    min-log-level 3;
    max-log-level(min-log-level() + 1);

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        my $cur = call "$lvl";
        push @ret, "$cur" if $cur.WHAT ~~ Str;
    }

    is min-log-level(), 3, 'min level ok';
    is max-log-level(), 4, 'max level ok';
    is @ret.elems, 2, 'min 3, max 4 ok count';

    for @ret -> $val {
        is so $val == (3,4).any, True, "$val ok with max level";
    }

}, 'min 3, max 4';

subtest {
    min-log-level 3;
    max-log-level 3;

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        my $cur = call "$lvl";
        push @ret, "$cur" if $cur.WHAT ~~ Str;
    }

    is min-log-level(), 3, 'min level ok';
    is max-log-level(), 3, 'max level ok';
    is @ret.elems, 1, 'min 3, max 3 ok count';

    for @ret -> $val {
        is so $val == 3, True, "$val ok with max level";
    }

}, 'min 3, max 3';

subtest {
    min-log-level 0;
    max-log-level 7;
    log-only 0;

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        my $cur = call "$lvl";
        push @ret, "$cur" if $cur.WHAT ~~ Str;
    }

    is min-log-level(), 0, 'min level ok';
    is max-log-level(), 7, 'max level ok';
    is log-only(), 0, 'log-only set ok';

    is @ret.elems, 1, 'log-only 0 ok';

    for @ret -> $val {
        is so $val == 0, True, "$val ok with log-only(0)";
    }

}, 'log-only(0)';

subtest {
    min-log-level 0;
    max-log-level 7;
    log-only 6;

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        my $cur = call "$lvl";
        push @ret, "$cur" if $cur.WHAT ~~ Str;
    }

    is min-log-level(), 0, 'min level ok';
    is max-log-level(), 7, 'max level ok';
    is log-only(), 6, 'log-only set ok';

    is @ret.elems, 1, 'log-only 6 ok';

    for @ret -> $val {
        is so $val == 6, True, "$val ok with log-only(6)";
    }

}, 'log-only(6)';

subtest {
    min-log-level 0;
    max-log-level 7;
    log-only False;

    my @ret;

    for (0..7) -> $lvl {
        my $s = 'log'~$lvl;
        my &call = ::("&" ~ $s);
        my $cur = call "$lvl";
        push @ret, "$cur" if $cur.WHAT ~~ Str;
    }

    is min-log-level(), 0, 'min level ok';
    is max-log-level(), 7, 'max level ok';
    is log-only(), False, 'log-only set ok';

    is @ret.elems, 8, 'log-only False ok';

    for @ret -> $val {
        is so $val == (0..7).any, True, "$val ok with log-only(False)";
    }

}, 'log-only(False)';

done-testing;
