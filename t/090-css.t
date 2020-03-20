use v6;
use Test;
use Pod::To::HTML;

plan 3;

=begin pod

Je suis Napoleon!

=end pod

like pod2html($=pod, :css('https://design.raku.org/perl.css')),
    /'<link rel="stylesheet" href='/, 'inclusion of CSS stylesheet in default template';

unlike pod2html($=pod, :lang<fr>, :css('')),
    /'<link rel="stylesheet" href='/,
    'empty string for CSS URL disables CSS inclusion';

unlike pod2html($=pod, :lang<fr>),
    /'<link rel="stylesheet" href='/,
    'not providing the css template variable also disables CSS inclusion';
