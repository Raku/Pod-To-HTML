use Test;
use Pod::To::HTML;
use Pod::Load;

my $test-pod-path = $?FILE.IO.sibling('multi.pod6');

dies-ok { render(42) }, 'Cannot render an Int';

like render($test-pod-path), /magicians/, 'Is rendering the whole file by path Str';

like render(slurp $test-pod-path), /magicians/, 'Is rendering the whole file by text';

like render([load($test-pod-path)]), /magicians/, 'Is rendering an Array';

like render(load($test-pod-path)), /magicians/, 'Is rendering a Pod::Block';

done-testing;