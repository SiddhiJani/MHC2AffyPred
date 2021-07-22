$arg1=$#ARGV+1;

if($arg1!=3)
{
	print "USAGE	perl	$0	<Inp1-Template>	<Inp2-SEQUENCES>	<PEPTIDE-NAME>\n";
	exit 1;
}

#IN1	GC2F,SC3Q,DC4W,WC5S,RC6V,FC7E,LC8S,RC9L,GC10Q,YC11S,HC12T,QC13R,YC14A,AC15F;
#IN2	EEDIEIIPIQEEEY

#OUT	GC2E,SC3E,DC4D,WC5I,RC6E,FC7I,LC8I,RC9P,GC10I,YC11Q,HC12E,QC13E,YC14E,AC15Y;

$four='';
open(IN1,"$ARGV[0]");
$four=(<IN1>);
chomp($four);
chop($four);
#print "four = $four\n";

@four1=();
@four1=split(',',$four);
close IN1;

#print "\$four1[0]=".$four1[0]."\n";
#die;

open(IN2,"$ARGV[1]");
open(OUT,">individual_list.txt");

while(<IN2>)
{
	chomp;
	@pep1=();
	@pep1=split('',$_);

	$i=0;
	for($i=0;$i<($#pep1-1);$i++)
	{
		($new1,$new2)='';
		$new1=$four1[$i];
		$new2=$pep1[$i];
		$new1 =~ s/.$/$new2/;
		print OUT $new1.",";
		
	}
#	print "\nAFTER FOR LOOP\n";
	($new1,$new2)='';
	$new1=$four1[$#pep1-1];
	$new2=$pep1[$#pep1-1];
	$new1 =~ s/.$/$new2/;
	print OUT $new1.";\n";
}
close IN2;
close OUT;

$out2='';
$out2=$ARGV[2];
chomp($out2);
$out3='';
$out3=$out2.".pdb";

#	RUNNING FOLDX
print "\n......Running foldx........\n";

$cmd3='';
$cmd3="./foldx --command=BuildModel --pdb=".$out3." --mutant-file=individual_list.txt";

#print "command3 = $cmd3\n";

system("$cmd3");

system("rm WT*");

$text_u='';
$text_u=$out2."_";

$cmd4="ls|grep \"".$text_u."\"|sort -V";
$cmd4_1=`$cmd4`;

#print "cmd4_1 = $cmd4_1\n";

@f_arr1=();
@f_arr1=split('\n',$cmd4_1);

$j='';
for($j=0;$j<=$#f_arr1;$j++)
{
	$newf='';
	$newf="Lig_".$f_arr1[$j];
	print "f_arr1[$j] = $f_arr1[$j]\n";
	$cmd5='';
	$cmd5="mv $f_arr1[$j] $newf";
	system($cmd5);
}

















