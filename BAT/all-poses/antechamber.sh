antechamber -i GTP.pdb -fi pdb -o gtp.mol2 -fo mol2 -c bcc -s 2 -at gaff2 -nc -4
parmchk2 -i gtp.mol2 -f mol2 -o gtp.frcmod -s 2
rm ANTECHAMBER*
rm sqm*
rm ATOMTYPE.INF 


