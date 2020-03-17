#!/bin/bash

#SBATCH --job-name=e-gamf-lhc
#SBATCH --output=log_evaluate_gamf_lhc2_%a.log
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32GB
#SBATCH --time=3-00:00:00
# #SBATCH --gres=gpu:1

source activate ml
export OMP_NUM_THREADS=1
cd /scratch/jb6504/manifold-flow/experiments

run=$((task / 2))
task=$((task % 2))
echo "SLURM_ARRAY_TASK_ID = ${SLURM_ARRAY_TASK_ID}, task = ${task}, run = ${run}"

case ${task} in
0) python -u evaluate.py --modelname april --dataset lhc --algorithm gamf --modellatentdim 14 --splinebins 10 --observedsamples 50 -i ${run} ;;
1) python -u evaluate.py --modelname alternate_april --dataset lhc --algorithm gamf --modellatentdim 14 --splinebins 10 --observedsamples 50 -i ${run} ;;
*) echo "Nothing to do for job ${task}" ;;
esac
