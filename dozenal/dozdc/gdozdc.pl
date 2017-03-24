#!/usr/bin/perl
# +AMDG  This document was begun on 27 Aug 11E8, the feast
# of St. Raymond Nonnatus, Confessor, and it is humbly
# dedicated to him and to the Immacualte Heart of Mary, for
# their prayers, and to the Sacred Heart of Jesus, for His
# mercy.

use Tk;
use Tk::Balloon;
use Tk::PNG;
use Tk::Bitmap;
use PAR;

# main window

my $mw = new MainWindow;
$mw->title('gdozdc v1.0');
#my $icon = $mw->Photo(-file=>'logo_shapes_dozenal.png');
#$mw->Icon(-image=>$icon);
#$mw->Icon(
#	-image=>$mw->Bitmap(
#		-file=>'logo_shapes_mask.xbm'
#	),
#);
#my $icon = $mw->Bitmap(-file=>'logo_shapes_dozenal.xbm');
#$mw->Icon(-image=>$icon);
#$mw->iconmask('@logo_shapes_mask.xbm');

# smaller font

$smallfont = $mw -> fontCreate('small',-family=>'serif',-size=>8);
$halffont = $mw -> fontCreate('half',-family=>'sans',-size=>6);

# format for the help balloons

$msgarea = $mw->Label(-borderwidth=>2,-relief=>'groove',
	-justify=>'left')
	-> grid(-column=>1,-row=>8,-columnspan=>10,-sticky=>'ew');

# create the menus

my $mainmenu = $mw -> Menu(-relief=>'raised');
$mw->configure(-menu=>$mainmenu);
my $filemenu = $mainmenu->cascade(-label=>"File",-underline=>0,
	-tearoff=>0);
$filemenu->command(-label=>"Quit",-underline=>0,-command=>sub{exit});
my $helpmenu = $mainmenu->cascade(-label=>"Help",-underline=>0,
	-tearoff=>0);
$helpmenu->command(-label=>"Help",-underline=>0,-command=>\&help);
$helpmenu->command(-label=>"About",-underline=>0,-command=>\&about);

sub help
{
	$helpmess =<<EOMESS;
gdozdc is a graphical frontend for the dozdc calculator, available at http://www.sourceforge.net/dozenal/.  It covers a number of functions and works in the dozenal (twelve) base only.\n\nEach function has a keyboard shortcut; the application can be used entirely without the keyboard, or entirely without the mouse, as the user sees fit.\n\nHover the mouse over a button to learn the keyboard shortcut.  I tried to make these as obvious as possible, but with the number of functions available that wasn't always easy.  Hovering with cause a help balloon to pop up with the button's keyboard shortcut in parentheses and a brief explanation of the function's purpose.\n\nUnary functions are standard postfix; that is, put the number, then hit the function desired.  E.g., "0;2 sin" will give the sine of the angle 0;2 unciaPi.  Binary functions are standard infix; that is, the function goes between the numbers.  E.g., "2 + 4" gives the sum of two and four; "5 logb 2" gives the logarithm of five to base two.\n\nFunctions can be grouped by parentheses as normal; this allows any order of operations desired.\n\nFor more information on the individual functions, please see the dozdc documentation at http://www.sourceforge.net/dozenal/.
EOMESS
	$aboutbox => $mw->messageBox(-title=>"gdozdc v1.0 Help",-font=>"small",
		-message=>$helpmess,-type=>'OK',-icon=>'question');
}

sub about
{
	$aboutbox => $mw->messageBox(-title=>"About
	gdozdc",-font=>"small",
		-message=>"gdozdc v1.0\nCopyright (C) Donald P.  Goodman III.  Released under the GNU GPL v3.0, available at http://www.gnu.org/copyleft/gpl.html.\n\ngdozdc is a graphical frontend written in Perl/Tk for the command-line program dozdc, part of the dozenal suite, available at http://www.sourceforge.net/dozenal/.",
		-type=>'OK',-icon=>'question');
}

# the calculation field, prec field, and angle field

my $ent = $mw -> Entry(-bg=>"white",
	-textvariable=>\$calcfield,-justify=>"right")
	-> grid(-row=>1,-column=>3,-columnspan=>8,-sticky=>"ew");
my $container = $mw -> Frame() -> grid(-row=>1,-column=>1,
	-columnspan=>2);
my $preccont = $container -> Frame() -> grid(-row=>1,-column=>1);
my $preclab = $preccont -> Label(-text=>"Pr.:",-font=>'half')
	-> grid(-row=>1,-column=>1,-sticky=>'e');
my $prec = 4;
my $precis = $preccont -> Entry(-bg=>"white",-font=>'half',
	-textvariable=>\$prec,-width=>1,-justify=>"right")
	-> grid(-row=>1,-column=>2,-sticky=>"e");
my $ang = 'z';
my $unciapi = $container -> Radiobutton(-text=>"U",-value=>'z',
	-selectcolor=>gray,-font=>'half',-variable=>\$ang,-width=>1);
my $degrees = $container -> Radiobutton(-text=>"D",-value=>'d',
	-selectcolor=>gray,-font=>'half',-variable=>\$ang,-width=>1);
my $radians = $container -> Radiobutton(-text=>"R",-value=>'r',
	-selectcolor=>gray,-font=>'half',-variable=>\$ang,-width=>1);
$unciapi -> grid(-row=>1,-column=>2);
$degrees -> grid(-row=>2,-column=>1);
$radians -> grid(-row=>2,-column=>2);

# the number buttons and keypad

my $neg = $mw -> Button(-width=>1,-text=>"-",
	-command=>[\&enterit,' -'])
	-> grid(-row=>6,-column=>1);
my $dit = $mw -> Button(-width=>1,-text=>";",
	-command=>[\&enterit,';'])
	-> grid(-row=>6,-column=>2);
my $expnot = $mw -> Button(-width=>1,-text=>"e",
	-command=>[\&enterit,'e'])
	-> grid(-row=>6,-column=>3);
my $zero = $mw -> Button(-width=>1,-text=>"0",
	-command =>[\&enterit,'0'])
	-> grid(-row=>5,-column=>1);
my $one = $mw -> Button(-width=>1,-text=>"1",
	-command =>[\&enterit,'1'])
	-> grid(-row=>5,-column=>2);
my $two = $mw -> Button(-width=>1,-text=>"2",
	-command =>[\&enterit,'2'])
	-> grid(-row=>5,-column=>3);
my $three = $mw -> Button(-width=>1,-text=>"3",
	-command =>[\&enterit,'3'])
	-> grid(-row=>4,-column=>1);
my $four = $mw -> Button(-width=>1,-text=>"4",
	-command =>[\&enterit,'4'])
	-> grid(-row=>4,-column=>2);
my $five = $mw -> Button(-width=>1,-text=>"5",
	-command =>[\&enterit,'5'])
	-> grid(-row=>4,-column=>3);
my $six = $mw -> Button(-width=>1,-text=>"6",
	-command =>[\&enterit,'6'])
	-> grid(-row=>3,-column=>1);
my $seven = $mw -> Button(-width=>1,-text=>"7",
	-command =>[\&enterit,'7'])
	-> grid(-row=>3,-column=>2);
my $eight = $mw -> Button(-width=>1,-text=>"8",
	-command =>[\&enterit,'8'])
	-> grid(-row=>3,-column=>3);
my $nine = $mw -> Button(-width=>1,-text=>"9",
	-command =>[\&enterit,'9'])
	-> grid(-row=>2,-column=>1);
my $ten = $mw -> Button(-width=>1,-text=>"X",
	-command =>[\&enterit,'X'])
	-> grid(-row=>2,-column=>2);
my $elv = $mw -> Button(-width=>1,-text=>"E",
	-command =>[\&enterit,'E'])
	-> grid(-row=>2,-column=>3);

# the four functions and equals

my $equals = $mw -> Button(-width=>1,-text=>"=",
	-command =>[\&enterit,' ='])
	-> grid(-row=>6,-column=>4);
my $plus = $mw -> Button(-width=>1,-text=>"+",
	-command =>[\&enterit,' + '])
	-> grid(-row=>5,-column=>4);
my $minus = $mw -> Button(-width=>1,-text=>"-",
	-command =>[\&enterit,' - '])
	-> grid(-row=>4,-column=>4);
my $times = $mw -> Button(-width=>1,-text=>"*",
	-command =>[\&enterit,' * '])
	-> grid(-row=>3,-column=>4);
my $divide = $mw -> Button(-width=>1,-text=>"/",
	-command =>[\&enterit,' / '])
	-> grid(-row=>2,-column=>4);

# the clear button, parens, exponents, square roots

my $clear = $mw -> Button(-width=>1,-text=>"Cl",
	-command=>[\&enterit,'clear'])
	-> grid(-row=>2,-column=>5);
my $leftp = $mw -> Button(-width=>1,-text=>"(",
	-command=>[\&enterit,'('])
	-> grid(-row=>3,-column=>5);
my $rightp = $mw -> Button(-width=>1,-text=>")",
	-command=>[\&enterit,')'])
	-> grid(-row=>4,-column=>5);
my $expon = $mw -> Button(-width=>1,-text=>"^",
	-command=>[\&enterit,' ^ '])
	-> grid(-row=>5,-column=>5);
my $sqrt = $mw -> Button(-width=>1,-text=>"sqrt",
	-command=>[\&enterit,'sqrt'])
	-> grid(-row=>6,-column=>5);

# trig functions, arbitrary base log, natural log

my $sin = $mw -> Button(-width=>1.5,-text=>"sin",
	-command=>[\&enterit,' sin '])
	-> grid(-row=>2,-column=>6);
my $cos = $mw -> Button(-width=>1.5,-text=>"cos",
	-command=>[\&enterit,' cos '])
	-> grid(-row=>3,-column=>6);
my $tan = $mw -> Button(-width=>1.5,-text=>"tan",
	-command=>[\&enterit,' tan '])
	-> grid(-row=>4,-column=>6);
my $log = $mw -> Button(-width=>1,-text=>"log",
	-command=>[\&enterit,' log '])
	-> grid(-row=>5,-column=>6);
my $logx = $mw -> Button(-width=>1,-text=>"logx",
	-command=>[\&enterit,' logx '])
	-> grid(-row=>6,-column=>6);
my $asin = $mw -> Button(-width=>1.5,-text=>"asin",
	-command=>[\&enterit,' asin '])
	-> grid(-row=>2,-column=>7);
my $acos = $mw -> Button(-width=>1.5,-text=>"acos",
	-command=>[\&enterit,' acos '])
	-> grid(-row=>3,-column=>7);
my $atan = $mw -> Button(-width=>1.5,-text=>"atan",
	-command=>[\&enterit,' atan '])
	-> grid(-row=>4,-column=>7);
my $logb = $mw -> Button(-width=>1.5,-text=>"logb",
	-command=>[\&enterit,' logb '])
	-> grid(-row=>5,-column=>7);
my $ln = $mw -> Button(-width=>1.5,-text=>"ln",
	-command=>[\&enterit,' ln '])
	-> grid(-row=>6,-column=>7);
my $sinh = $mw -> Button(-width=>1.5,-text=>"sinh",
	-command=>[\&enterit,' sinh '])
	-> grid(-row=>2,-column=>8);
my $cosh = $mw -> Button(-width=>1.5,-text=>"cosh",
	-command=>[\&enterit,' cosh '])
	-> grid(-row=>3,-column=>8);
my $tanh = $mw -> Button(-width=>1.5,-text=>"tanh",
	-command=>[\&enterit,' tanh '])
	-> grid(-row=>4,-column=>8);
my $dlg = $mw -> Button(-width=>1.5,-text=>"dlg",
	-command=>[\&enterit,' dlg '])
	-> grid(-row=>5,-column=>8);
my $recip = $mw -> Button(-width=>1.5,-text=>"1/x",
	-command=>[\&enterit,' 1/x '])
	-> grid(-row=>6,-column=>8);

# backspace, factorial, mod, pi, eul

my $back = $mw -> Button(-width=>1.5,-text=>"<-",
	-command=>[\&backit])
	-> grid(-row=>2,-column=>9);
my $factorial = $mw -> Button(-width=>1.5,-text=>"!",
	-command=>[\&enterit,' ! '])
	-> grid(-row=>3,-column=>9);
my $mod = $mw -> Button(-width=>1.5,-text=>"%",
	-command=>[\&enterit,' % '])
	-> grid(-row=>4,-column=>9);
my $pi = $mw -> Button(-width=>1.5,-text=>"pi",
	-command=>[\&enterit,' pi '])
	-> grid(-row=>5,-column=>9);
my $eul = $mw -> Button(-width=>1.5,-text=>"eul",
	-command=>[\&enterit,' eul '])
	-> grid(-row=>6,-column=>9);

# memory buttons

my $replace = $mw -> Button(-width=>1.5,-text=>"M+",
	-command=>[\&saveit,'M+'])
	-> grid(-row=>2,-column=>10);
my $append = $mw -> Button(-width=>1.5,-text=>"M++",
	-command=>[\&saveit,'M++'])
	-> grid(-row=>3,-column=>10);
my $save = $mw -> Button(-width=>1.5,-text=>"M",
	-command=>[\&saveit,'M'])
	-> grid(-row=>4,-column=>10);
my $wipe = $mw -> Button(-width=>1.5,-text=>"CM",
	-command=>[\&saveit,'K'])
	-> grid(-row=>5,-column=>10);
my $quit = $mw -> Button(-width=>1.5,-text=>"Quit",
	-command=>\&exit)
	-> grid(-row=>6,-column=>10);

# memory subroutines

sub saveit
{
	if ($_[0] eq 'M') {
		$memory = $calcfield;
	} elsif ($_[0] eq 'M++') {
		$calcfield .= $memory;
	} elsif ($_[0] eq 'K') {
		$memory = "";
	} else {
		$calcfield = $memory;
	}
}

# process a backspace

sub backit
{
	chop($calcfield);
}

# process whatever is entered; put results of calc back into
# field

sub enterit
{
	my $tempvar;

	if ($_[0] eq ' =') {
		$rpn = shuntyard($calcfield);
		$tempvar = `dozdc -k$prec -$ang " $rpn" 2>&1`;
		if ($tempvar =~ /:/) {
			$errtext = `dozdc -k$prec -$ang " $rpn" 2>&1 1>/dev/null`;
			$errbox => $mw->messageBox(-title=>'gdozdc Error',
				-bitmap=>"warning",-font=>'small', 
				-message=>"Error:  $errtext",-type=>'OK');
			chomp($calcfield);
		} else {
			$calcfield = $tempvar;
		}
		chomp($calcfield);
		$errtext = "";
	} elsif ($_[0] =~ /sqrt/) {
		$calcfield .= ' v ';
	} elsif ($_[0] =~ /1\/x/) {
		$calcfield .= ' recip ';
	} elsif ($_[0] =~ /pi/ || $_[0] =~ /eul/) {
		$tempvar = qx(dozdc -k$prec -$ang " $_[0] =");
		chomp($tempvar);
		$calcfield .= $tempvar;
	} else {
		$calcfield .= $_[0];
	}
	if ($_[0] =~ /clear/) {
		$calcfield = '';
	}
}

# shunting yard to convert infix to rpn

sub shuntyard
{
	# Copyright (c) 2012 the authors listed at the following
	# URL, and/or the authors of referenced articles or
	# incorporated external code:
	# http://en.literateprograms.org/Shunting_yard_algorithm_(Perl)?action=history&offset=20080112153653
	# 
	# Permission is hereby granted, free of charge, to any
	# person obtaining a copy of this software and associated
	# documentation files (the "Software"), to deal in the
	# Software without restriction, including without limitation
	# the rights to use, copy, modify, merge, publish,
	# distribute, sublicense, and/or sell copies of the
	# Software, and to permit persons to whom the Software is
	# furnished to do so, subject to the following conditions:
	# 
	# The above copyright notice and this permission notice
	# shall be included in all copies or substantial portions of
	# the Software.
	# 
	# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY
	# KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
	# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
	# PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
	# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
	# DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
	# CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
	# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
	# IN THE SOFTWARE.
	# 
	# Retrieved from:
	# http://en.literateprograms.org/Shunting_yard_algorithm_(Perl)?oldid=12069
	my $expr=$_[0];
	my @tokens=split(/\ *([\+\-\*\/\(\)]|[0-9XE]+;[e0-9XE]+|[0-9XE]+) */, $expr);
	my %prec=('-u'=>5, '*'=>4, '/'=>3, '+'=>2, '-'=>1, '('=>0, ''=>9);
	my %right=('-u'=>1);
	sub getprec {
		my ($op)=@_;
		return exists $prec{$op}?$prec{$op}:-1;
	}
	# Parsing
	my @op_stack;
	my @rpn;
	my $last="";
	foreach my $token (@tokens) {
		!$token and next;
		if($token eq '-' and getprec($last)>=0) {$token='-u';}
		if($token=~/^[\dXE]+$|^[\dXE]+;[\dXE]+$|^[\dXE]+;[\dXE]+e[\dXE]+$/) {
			if($last=~/^[\dXE]+$|^[\dXE]+;[\dXE]+$/ || $last eq ")") {
				die "Value tokens must be separated by an operator";
			}
			push(@rpn, $token);
		} elsif($token eq '(') {
			push(@op_stack, $token);
		} elsif($token eq ')') {
			while($op_stack[-1] ne '(') {
				my $t=pop(@op_stack);
				push(@rpn, $t);
			}
			pop(@op_stack) eq '(' or die "No matching (";
		} elsif((my $pr=getprec($token))>0) {
			if(exists $right{$token}) {
				while(scalar @op_stack>0 && $pr<getprec($op_stack[-1])) {
					push(@rpn, pop(@op_stack));
				}
			} else {
				while(scalar @op_stack>0 && $pr<=getprec($op_stack[-1])) {
					push(@rpn, pop(@op_stack));
				}
			}
			push(@op_stack, $token);
		} else {
			push(@op_stack,$token);
		}
		$last=$token;
	}
	while(scalar @op_stack>0) {
		push(@rpn, pop(@op_stack));
	}
	foreach my $token (@rpn) {
		if($token eq '-u') {$newcalc .= " -1 * ";}
		else {$newcalc .= "$token ";}
	}
	$newcalc .= " = ";
}

# define the key bindings

$mw -> bind('<Key-p>',sub{$precis->focus();});
$mw -> bind('<Key-u>',sub{$ang = 'z'});
$mw -> bind('<Key-d>',sub{$ang = 'd'});
$mw -> bind('<Key-r>',sub{$ang = 'r'});
$mw -> bind('<Key-underscore>',sub{enterit(' -')});
$mw -> bind('<Key-semicolon>',sub{enterit(';')});
$mw -> bind('<Key-e>',sub{enterit('e')});
$mw -> bind('<Key-0>',sub{enterit('0')});
$mw -> bind('<Key-1>',sub{enterit('1')});
$mw -> bind('<Key-2>',sub{enterit('2')});
$mw -> bind('<Key-3>',sub{enterit('3')});
$mw -> bind('<Key-4>',sub{enterit('4')});
$mw -> bind('<Key-5>',sub{enterit('5')});
$mw -> bind('<Key-6>',sub{enterit('6')});
$mw -> bind('<Key-7>',sub{enterit('7')});
$mw -> bind('<Key-8>',sub{enterit('8')});
$mw -> bind('<Key-9>',sub{enterit('9')});
$mw -> bind('<Key-X>',sub{enterit('X')});
$mw -> bind('<Key-E>',sub{enterit('E')});
$mw -> bind('<Key-equal>',sub{enterit(' =')});
$mw -> bind('<Key-Return>',sub{enterit(' =')});
$mw -> bind('<Key-KP_Enter>',sub{enterit(' =')});
$mw -> bind('<Key-plus>',sub{enterit(' + ')});
$mw -> bind('<Key-minus>',sub{enterit(' - ')});
$mw -> bind('<Key-asterisk>',sub{enterit(' * ')});
$mw -> bind('<Key-slash>',sub{enterit(' / ')});
$mw -> bind('<Key-w>',sub{enterit('clear')});
$mw -> bind('<Key-parenleft>',sub{enterit('(')});
$mw -> bind('<Key-parenright>',sub{enterit(')')});
$mw -> bind('<Key-asciicircum>',sub{enterit(' ^ ')});
$mw -> bind('<Key-v>',sub{enterit('sqrt')});
$mw -> bind('<Key-s>',sub{enterit(' sin ')});
$mw -> bind('<Key-c>',sub{enterit(' cos ')});
$mw -> bind('<Key-t>',sub{enterit(' tan ')});
$mw -> bind('<Key-l>',sub{enterit(' log ')});
$mw -> bind('<Key-x>',sub{enterit(' logx ')});
$mw -> bind('<Key-S>',sub{enterit(' asin ')});
$mw -> bind('<Key-C>',sub{enterit(' acos ')});
$mw -> bind('<Key-T>',sub{enterit(' atan ')});
$mw -> bind('<Key-b>',sub{enterit(' logb ')});
$mw -> bind('<Key-n>',sub{enterit(' ln ')});
$mw -> bind('<Key-h>',sub{enterit(' sinh ')});
$mw -> bind('<Key-H>',sub{enterit(' cosh ')});
$mw -> bind('<Key-A>',sub{enterit(' tanh ')});
$mw -> bind('<Key-D>',sub{enterit(' dlg ')});
$mw -> bind('<Key-R>',sub{enterit(' 1/x ')});
$mw -> bind('<Key-BackSpace>',sub{backit()});
$mw -> bind('<Key-exclam>',sub{enterit(' ! ')});
$mw -> bind('<Key-percent>',sub{enterit(' % ')});
$mw -> bind('<Key-P>',sub{enterit(' pi ')});
$mw -> bind('<Key-U>',sub{enterit(' eul ')});
$mw -> bind('<Key-m>',sub{saveit('M+')});
$mw -> bind('<Key-M>',sub{saveit('M++')});
$mw -> bind('<Key-k>',sub{saveit('M')});
$mw -> bind('<Key-K>',sub{saveit('K')});
$mw -> bind('<Key-Q>',sub{exit;});

$precis -> bind('<Key-Escape>',sub{$mw->focus();});
$precis->bindtags([$precis,ref($precis),$precis,'all']);

# put in the help balloons

$b = $mw -> Balloon(-statusbar=>$msgarea);
$b->attach($unciapi,-msg=>"(u) angles in unciaPi"); 
$b->attach($degrees,-msg=>"(d) angles in degrees"); 
$b->attach($radians,-msg=>"(r) angles in radians"); 
$b->attach($neg,-msg=>"(_) Negative sign");
$b->attach($dit,-msg=>"(;) Uncial point");
$b->attach($expnot,-msg=>"(E) Exponential notation (ZeZ)");
$b->attach($zero,-msg=>"(0) Zero");
$b->attach($one,-msg=>"(1) One");
$b->attach($two,-msg=>"(2) Two");
$b->attach($three,-msg=>"(3) Three");
$b->attach($four,-msg=>"(4) Four");
$b->attach($five,-msg=>"(5) Five");
$b->attach($six,-msg=>"(6) Six");
$b->attach($seven,-msg=>"(7) Seven");
$b->attach($eight,-msg=>"(8) Eight");
$b->attach($nine,-msg=>"(9) Nine");
$b->attach($ten,-msg=>"(x) Ten");
$b->attach($elv,-msg=>"(e) Elv");
$b->attach($equals,-msg=>"(=, enter) Equals; perform calculation");
$b->attach($plus,-msg=>"(+) Plus, addition");
$b->attach($minus,-msg=>"(-) Minus, subtraction");
$b->attach($times,-msg=>"(*) Times, multiplication");
$b->attach($divide,-msg=>"(/) Division");
$b->attach($clear,-msg=>"(w) Clear (wipe) the calculation field");
$b->attach($leftp,-msg=>"(\'(\') Left parenthesis");
$b->attach($rightp,-msg=>"(\')\') Right Parenthesis");
$b->attach($expon,-msg=>"(^) Exponentiation");
$b->attach($sqrt,-msg=>"(v) Square root");
$b->attach($sin,-msg=>"(s) Sine");
$b->attach($cos,-msg=>"(c) Cosine");
$b->attach($tan,-msg=>"(t) Tangent");
$b->attach($log,-msg=>"(l) Base-10 logarithms");
$b->attach($logx,-msg=>"(X) Base-X logarithms");
$b->attach($asin,-msg=>"(S) Arcsine");
$b->attach($acos,-msg=>"(S) Arccosine");
$b->attach($atan,-msg=>"(T) Arctangent");
$b->attach($logb,-msg=>"(b) Arbitrary-base logarithms");
$b->attach($ln,-msg=>"(n) Natural logarithms");
$b->attach($sinh,-msg=>"(h) Hyperbolic sine");
$b->attach($cosh,-msg=>"(H) Hyperbolic cosine");
$b->attach($tanh,-msg=>"(A) Hyperbolic tangent");
$b->attach($dlg,-msg=>"(D) Dublogs (base-two logarithms)");
$b->attach($recip,-msg=>"(R) Reciprocal");
$b->attach($back,-msg=>"(backspace) delete last character from field"); 
$b->attach($factorial,-msg=>"(!) Factorial");
$b->attach($mod,-msg=>"(%) Modulus (remainder)");
$b->attach($pi,-msg=>"(P) Pi (constant)");
$b->attach($eul,-msg=>"(U) Euler's constant");
$b->attach($replace,-msg=>"(m) Replace all with memory");
$b->attach($append,-msg=>"(m) Append memory to field");
$b->attach($save,-msg=>"(k) Save current field to memory");
$b->attach($wipe,-msg=>"(K) Clear (wipe) current memory");
$b->attach($quit,-msg=>"(Q) Quit the application");
$b->attach($preccont,-msg=>"(p) Change precision of results");

# get it all rolling

MainLoop;
