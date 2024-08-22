cd rest
cd m-comp
echo $(sbatch SLURMM-run) >> ../../job_ids
cd ../
cd n-comp
echo $(sbatch SLURMM-run) >> ../../job_ids
cd ../
cd ../
cd sdr

cd e-comp
x=0
while [  $x -lt 10 ]; do
cd e0$x
echo $(sbatch SLURMM-run) >> ../../../job_ids
cd ../
let x=x+1
done
if [ $x -ge 10 ]; then
while [  $x -lt 12 ]; do
cd e$x
echo $(sbatch SLURMM-run) >> ../../../job_ids
cd ../
let x=x+1
done
fi
cd ../

cd v-comp
x=0
while [  $x -lt 10 ]; do
cd v0$x
echo $(sbatch SLURMM-run) >> ../../../job_ids
cd ../
let x=x+1
done
if [ $x -ge 10 ]; then
while [  $x -lt 12 ]; do
cd v$x
echo $(sbatch SLURMM-run) >> ../../../job_ids
cd ../
let x=x+1
done
fi
cd ../

cd ../
