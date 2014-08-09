use strict;
use warnings;
use Test::More;


use Catalyst::Test 'blog';
use blog::Controller::post;

ok( request('/post')->is_success, 'Request should succeed' );
done_testing();
