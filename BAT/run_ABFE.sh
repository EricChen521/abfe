# first put a reference.pdb(the proten structure) into the build_files 



python BAT.py -i input-sdr-openmm.in -s equil > equil.log

cd equil

for pose in pose*
do
	cd $pose
	bash run-local.bash
	cd ..
done

cd ../



# run fe step

python BAT.py -i input-sdr-openmm.in -s fe


# do the calculation for each pose

cd fe/

for pose in pose*
do
	cd $pose
	cp ../../run_files/run-op-express.bash .
	bash run-op-express.bash
	cd ../
done

cd ../

python BAT.py -i input-sdr-openmm.in -s analysis 
