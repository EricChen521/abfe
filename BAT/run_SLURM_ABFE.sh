# first put a reference.pdb(the proten structure) into the build_files 



python /home/eric_clyang521_gmail_com/github/abfe/BAT/BAT.py -i input-sdr-openmm.in -s equil 

cd equil

for pose in pose*
do
	cd $pose
	echo $(sbatch --parsable SLURMM-run) > job.id
	cd ..
done

# check the eq for each pose

for pose in pose*
do
	cd $pose
	srun -N 1 -n 1 -p g2 -J check_eq -d afterany:$(cat job.id) echo "${pose} eq is done!"
	cd ..
done

cd ../



# run fe step

python /home/eric_clyang521_gmail_com/github/abfe/BAT/BAT.py -i input-sdr-openmm.in -s fe 


# do the calculation for each pose

cd fe/

for pose in pose*
do
	cd $pose
	bash run-op-express.bash
	cd ../
done

# check if fe jobs are finished

for pose in pose*
do
	cd $pose
	dependency_ids=$(cat job_ids | awk '{print $NF}' | paste -sd:)
	echo "The fe job ids for ${pose}: ${dependency_ids}"
	srun -N 1 -n 1 -p g2 -J check_fe -d afterany:${dependency_ids} echo "$pose fe is done"
	cd ..
done
cd ../

python /home/eric_clyang521_gmail_com/github/abfe/BAT/BAT.py -i input-sdr-openmm.in -s analysis 
