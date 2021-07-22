cnt=1
for i in `ls|grep pdb|grep -v out1|grep -v protein|sort -V`
do
	j="out1_Peptide"$cnt".pdb"
	k="$(grep -w B $i -n|tail -n 1|cut -d ":" -f 1|awk '{print $0+1}')"
#	echo "value = $k"
	sed -n "$k,$"p $i >$j
	cnt=$((cnt+1))
done

echo "=======Step1 : cut from 2995 to end completed"

cnt=1
for i in `ls|grep out1|sort -V`
do
	j="out2_Peptide"$cnt".pdbqt"
	obabel $i -O $j
	cnt=$((cnt+1))
done

echo "=======Step2 : PDBQT generation DONE....."

echo "MODEL and other info insertion"

echo "---------	CONDA ACTIVATION ------------"

#conda activate base
#conda activate hippos

cnt=1
for fl in `ls|grep out2|grep pdbqt|sort -V`
do
	j="out2_Peptide"$cnt"_out.pdbqt"
	echo "MODEL $cnt" >> $j
	echo "REMARK VINA RESULT:      -1.0      0.000      0.000" >>$j
	cat $fl >> $j
	echo "ENDMDL" >> $j

	k1="out3_Vinaconf1_Peptide"$cnt".conf"
	sed -e "s/filex.pdbqt/$fl/" vina.conf >$k1

	k2="out4_Vinaconf2_Peptide"$cnt".txt"
	sed -e "s/vina.conf/$k1/" config-vina-na-notc.txt >$k2

#	RUNNING HIPPOSE
	hippos $k2

#	Storing result
	m="out5_VinaResult"$cnt".csv"
	cp vina_ifp.csv $m

	echo ".................................................peptide-$cnt hippos done....................................................."
	cnt=$(( cnt + 1 ))
done

echo "Concatinating out5 files........"
ls|grep out5|grep VinaResult|sort -V|sed ':a;N;$!ba;s/\n/ /g'|awk '{print "cat "$0" >out6_VinaResult_CONCAT.csv"}' >test2.sh

sh test2.sh

echo "Concatinating out4 files DONE"

echo "Removing intermediate files"

rm out1* out2* out3* out4* out5*




