use Test;

use Pod::To::HTML;
use URI::Escape;

my $link-html = "";

subtest 'internal-only links' => {
    my $link-html = node2html(create-link-pod("", "#internal-only"));
    is get-display-text($link-html),
       "internal-only",
       "Strip # from the text if internal-only link";
}

subtest 'Do not escape special chars if not internal url' => {
    for <q{&} q{<} q{>} q{'}> -> $char {
        $link-html = node2html(create-link-pod("/routine/$char", "random text"));
            is get-href-content($link-html),
            "/routine/$char",
            "$char not escaped from url";
    }
}

subtest 'Escape special chars if internal url' => {
    for <& < > '> -> $char {
        $link-html = node2html(create-link-pod("#$char", "random text"));
            is get-href-content($link-html),
            "#" ~ uri_escape($char),
            "$char escaped from url";
    }
}

# helpers 

sub create-link-pod($url, $contents) {
    Pod::FormattingCode.new(
        type     => "L",
        meta     => [$url],
        contents => [$contents]
    )
}

sub get-href-content($html) {
    my $content;
    $html ~~ /href\=\"$<cm>=<-["]>+\"/;
    return $<cm>.Str;
}

sub get-display-text($html) {
    my $content;
    $html ~~ /\>$<cm>=<-["]>+\</;
    return $<cm>.Str;
}