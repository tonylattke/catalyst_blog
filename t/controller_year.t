use strict;
use warnings;
use Test::More;


use Catalyst::Test 'blog';
use blog::Controller::year;

ok( request('/year')->is_success, 'Request should succeed' );
done_testing();
