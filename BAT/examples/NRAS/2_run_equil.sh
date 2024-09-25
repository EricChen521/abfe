cd equil

for lig in ligand*
do
	cd $lig
	echo $(sbatch --parsable SLURMM-run) > job.id
	cd ..
done

lig_array=()

for lig in ligand*
do
	lig_array+=($lig)
done

last_lig=${lig_array[-1]}

cd ${last_lig}

srun -N 1 -n 1 -p g2 -J check_eq -d afterany:$(cat job.id) echo "${last_lig} eq is done!"

cd ..

cd ../ # out of equil dir
