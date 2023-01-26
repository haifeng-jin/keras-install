#!/bin/bash -i
conda create --name=test python=3.10 -y
conda activate test
conda install cuda-nvcc=11.3.58 cudatoolkit=11.2.2 cudnn=8.1.0 -c conda-forge -c nvidia -y
pip install tensorflow
mkdir -p $CONDA_PREFIX/etc/conda/activate.d
printf 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/\nexport XLA_FLAGS=--xla_gpu_cuda_data_dir=$CONDA_PREFIX/lib/\n' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
mkdir -p $CONDA_PREFIX/lib/nvvm/libdevice
cp $CONDA_PREFIX/lib/libdevice.10.bc $CONDA_PREFIX/lib/nvvm/libdevice/
