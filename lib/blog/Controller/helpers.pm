package Helpers_extra;

# checkLog - Allow to check if a user is already looged, if not redirect to to home
# @arg0 - Controller
# @arg1 - User exists value
sub checkLog {
	my ( $c, $check ) = @_;
	if (!$check) {
		$c->flash->{status_msg} = "Not authorized";
		$c->res->redirect($c->uri_for('/', {}));
	}
}

# currentTime - Take the local time and return on string format (YYYY-MM-DD HH:MM:SS)
# @return - Local time on string format (YYYY-MM-DD HH:MM:SS)
sub currentTime {
	my ($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime();
    $year += 1900;
    $mon++;
    return "$year-$mon-$mday $hour:$min:$sec";
}

# extractYears - Take all the posts and obtain all the diferents years
# @arg0 - All posts
# @return - List of years
sub extractYears {
	my @posts = @_[0];
	my @years;
	if (@posts > 0) {
		my $newer_year = $posts[0]->date->year;
		print $newer_year, "\n";
		print $newer_year, "\n";
		print $newer_year, "\n";
		print $newer_year, "\n";
		my $older_year = $posts[-1]->date->year;
		push @years, $newer_year;
		if ($older_year != $newer_year) {
			for (my $x = $newer_year; $x >= $older_year; $x--) {
			push @years, $x;
		}
		}
	}
	return \@years;
}

1;