
#	protein file selection
	prot=`ls|grep "^Prot"`

cnt=1
for i in `ls|grep "^Lig"|grep -v "_m.pdb$"|sort -V`
do	
#	echo "i=$i"
	#mark_sur outfile making
	j=`echo $i| sed 's/.pdb/_m.pdb/'`
	echo "mark_sur OUTFILE=$j"

	#mark_sur running
	./mark_sur $i $j

	#zdock outfile making
	k=`echo $i | sed 's/.pdb/_zdock.out/'`
	echo "zdock OUTFILE=$k"

	#zdock running
	./zdock -R $prot -L $j -F -N 1 -o $k
	

done
#	CREATE.SH
for fn in `ls *.out`
do
	perl create.pl $fn
        mv 'complex.1.pdb' $fn\.pdb
	echo "$fn pdb created"
done

