use Pod::To::HTML;
use Test;

=begin pod

=begin para :property<cool>
Test text!
=end para

=end pod

class Node::To::HTML::Custom is Node::To::HTML {
    multi method node2html(Pod::Block::Para $node, *%config --> Str) {
        with %config<property> {
            "Nice, $_ render!";
        } else {
            "A bug appeared...";
        }
    }
}

like Pod::To::HTML.new(node-renderer => Node::To::HTML::Custom).render($=pod),
        /'Nice, cool render!'/, 'Config in a paragraph was understood';

done-testing;
