cd rest
cd m-comp
bash SLURMM-run
cd ../
cd n-comp
bash SLURMM-run
cd ../
cd ../

cd sdr

cd e-comp
x=0
while [  $x -lt 10 ]; do
cd e0$x
bash SLURMM-run
cd ../
let x=x+1
done
if [ $x -ge 10 ]; then
while [  $x -lt 12 ]; do
cd e$x
bash SLURMM-run
cd ../
let x=x+1
done
fi
cd ../

cd v-comp
x=0
while [  $x -lt 10 ]; do
cd v0$x
bash SLURMM-run
cd ../
let x=x+1
done
if [ $x -ge 10 ]; then
while [  $x -lt 12 ]; do
cd v$x
bash SLURMM-run
cd ../
let x=x+1
done
fi
cd ../

cd ../
