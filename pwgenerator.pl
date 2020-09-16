#! /usr/bin/perl

sub pwd {
	my $has_upper_case;
	my $has_lower_case;
	my $has_number;
	my $has_symbol;
	my $pass_name_rule;
	my $user_name = $ENV{USER};
	my $passwd = "";
	my $my_name = "Taylor Tang"; #hardcoded
	sub name_check {
		my $name = shift;
		my $pwd = lc(shift);
		my $length = length($name) - 2;
		for(0...$length) {
			my $p = substr $name, $_, 2;
			if($pwd =~ /\Q$p/i) {
				return 0;
			}
		}
		return 1;
	}

	for(0...9){
		my $rand = int(rand(93));
		my $char = chr(33+$rand); 
		if($char =~ /[A-Z]/) {
			$has_upper_case = 1;
		} elsif($char =~ /[a-z]/) {
			$has_lower_case = 1;
		} elsif($char =~ /\d/) {
			$has_number = 1;
		} else {
			$has_symbol = 1;
		}
		$passwd .= $char;
	}
	$pass_name_rule = (name_check $user_name, $passwd) && (name_check $my_name, $passwd);
	if($has_upper_case && $has_lower_case && $has_number && !$has_symbol && $pass_name_rule) {
		return $passwd;
	} else {
		pwd();
	}
}
sub writeFile {
	my $pw = shift;
	my $file = "$ENV{'HOME'}/log/pwlog";
	open(my $fh, '>>', $file) or die "Can't open file $file $!";
	print $fh gmtime()."\n";
	print $fh "$pw\n";
	close $fh
}
my $pw =  pwd();
writeFile($pw);
print "$pw\n";
