use strict;
use warnings;

use Test::More tests => 14;

is(system("blib/script/timobileref > /dev/null"), 0, 'top page');
is(system("blib/script/timobileref Titanium > /dev/null"), 0, 'exact path');
is(system("blib/script/timobileref Ti > /dev/null"), 0, 'expand');
is(system("blib/script/timobileref Ti.Android.Intent > /dev/null"), 0, 'expand');
is(system("blib/script/timobileref Titanium.Android.Intent > /dev/null"), 0, 'module');
is(system("blib/script/timobileref Titanium.Android.Activity > /dev/null"), 0, 'object');
is(system("blib/script/timobileref Titanium.removeEventListener > /dev/null"), 0, 'method');
is(system("blib/script/timobileref Titanium.Android.PENDING_INTENT_FOR_ACTIVITY > /dev/null"), 0, 'property');
is(system("blib/script/timobileref Titanium-module > /dev/null"), 0, 'module');
is(system("blib/script/timobileref Titanium.Android.Intent-object > /dev/null"), 0, 'object');
is(system("blib/script/timobileref Titanium.Android.Activity-object > /dev/null"), 0, 'object');
is(system("blib/script/timobileref Titanium.removeEventListener-method > /dev/null"), 0, 'method');
is(system("blib/script/timobileref Titanium.Android.PENDING_INTENT_FOR_ACTIVITY-property > /dev/null"), 0, 'property');
is(system("blib/script/timobileref hokhokhok > /dev/null 2>&1"), 256, 'not found');


