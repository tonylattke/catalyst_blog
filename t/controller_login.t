use strict;
use warnings;
use Test::More;


use Catalyst::Test 'blog';
use blog::Controller::login;

ok( request('/login')->is_success, 'Request should succeed' );
done_testing();
