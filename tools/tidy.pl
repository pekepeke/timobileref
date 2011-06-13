#! /usr/bin/perl

use strict;
use warnings;

use File::Basename;
use File::Find;
use File::Slurp;

find(
    {
        wanted => sub {
            my $fn = $_;
            return if -d $fn;
            $fn =~ s|^orig/||;
            my $html = read_file("orig/$fn")
                or die "failed to read file:orig/$fn:$!";
            $html =~ s{<head>.*?(<title>.*?</title>)</head>}{<head>$1</head>}s;
            $html =~ s{<header role="banner">.*?</header>}{}s;
            $html =~ s{<footer>.*?</footer>}{}s;
            #$html =~ s{<a href="https?:.*?".*?>.*?</a>}{}sg;
            $html =~ s{<li><a href="\/.*?">.*?</a></li>}{}sg;
            system("mkdir -p " . dirname("doc/$fn")) == 0
                or die "mkdir failed:$?";
            write_file("doc/$fn", $html);
        },
        no_chdir => 1,
    },
    'orig',
);
