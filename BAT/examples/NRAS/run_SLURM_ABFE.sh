# first put a reference.pdb(the proten structure) into the build_files 



python /home/eric_clyang521_gmail_com/github/abfe/BAT/BAT.py -i input-sdr-openmm.in -s equil 

cd equil

for lig in ligand*
do
	cd $lig
	echo $(sbatch --parsable SLURMM-run) > job.id
	cd ..
done

# check the eq for each pose
lig_array=()
for lig in ligand*
do
	lig_array+=($lig)
done

last_lig=${lig_array[-1]}

cd ${last_lig}
srun -N 1 -n 1 -t 2-00:00:00 -p g2 -J check_eq -d afterany:$(cat job.id) echo "${last_lig} eq is done!"
cd ..

cd ../



# run fe step

python /home/eric_clyang521_gmail_com/github/abfe/BAT/BAT.py -i input-sdr-openmm.in -s fe 


# do the calculation for each pose

cd fe/

for lig in ligand*
do
	cd $lig
	bash run-op-express.bash
	cd ../
done

# check if fe jobs are finished


cd ${last_lig}
dependency_ids=$(cat job_ids | awk '{print $NF}' | paste -sd:)
echo "The fe job ids for last ligand ${lats_lig}: ${dependency_ids}"
srun -N 1 -n 1 -p g2 -J check_fe -d afterany:${dependency_ids} echo "${last_lig} fe is done"
cd ..

cd ../

python /home/eric_clyang521_gmail_com/github/abfe/BAT/BAT.py -i input-sdr-openmm.in -s analysis 
