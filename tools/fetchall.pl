#! /usr/bin/perl

use strict;
use warnings;

use File::Basename;
use File::Slurp;
use LWP::Simple;

my $prefix = 'http://developer.appcelerator.com/apidoc/mobile/';
my @queue = qw(latest);
my %fetched;
my %queued;
my $BASEDIR="orig";
system("mkdir $BASEDIR") unless -d $BASEDIR;

while (my $fn = shift @queue) {
    next if $fetched{$fn};
    #next if -e rewrite_ctor_op($fn) .".html";
    print STDERR scalar(@queue), " $fn\n";
    #system("mkdir -p $BASEDIR/" . dirname($fn) . " 2> /dev/null");

    $fetched{$fn} = 1;
    my $html = get("$prefix$fn");
    #$html =~ s|(<a\s+href=")$prefix(.*?)(")|$1 . handle_link($fn, $2) . $3|eg;
    $html =~ s|(<a\s+href=")($prefix)?(.*?)(")|$1 . handle_link($fn, $3) . $4|eg;
    utf8::encode($html);
    #write_file("$BASEDIR/$fn" . ".html", $html);
    system("mkdir -p " .dirname(rewrite_uri("$BASEDIR/$fn")). " 2> /dev/null");
    write_file(rewrite_uri("$BASEDIR/$fn") . ".html", $html);
}

sub handle_link {
    my ($base, $dest) = @_;
    return $dest if ($dest =~ /^https?:\/\//);
    return $dest if ($dest =~ /^\//);
    $dest =~ s/\?.*$//;
    $dest =~ s|/$|/latest|;
    $dest = "latest/$dest" unless ($dest =~ /^latest/);
    #print "$base : $dest\n";

    #push @queue, $dest unless $fetched{$dest};
    my $rewrite_dest = rewrite_uri($dest);

    unless ($fetched{$dest} || $queued{$dest} || $queued{$rewrite_dest}) {
        push @queue, $dest;
        $queued{$rewrite_dest}=1;
    }
    my $prefix = $base =~ m|/| ? dirname($base) . '/' : '';
    $prefix =~ s{[^/]+}{..}g;
    $dest = rewrite_uri($dest);
    "$prefix$dest.html";
}

sub rewrite_uri {
    my $fn = shift;
    $fn =~ s/\.html$//;
    #$fn =~ s/\./\//g;
    $fn;
}

