# do the calculation for each pose

cd fe/

lig_array=()
for lig in ligand*
do
	lig_array+=($lig)
done

last_lig=${lig_array[-1]}

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
