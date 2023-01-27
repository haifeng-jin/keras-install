#!/usr/bin/env bash
read -r -p "Are you sure? [y/N] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(yes|y)$ ]]
then
    echo "YES"
else
    echo "NO"
fi

read -r -p "Are you sure? [Y/n] " response
response=${response,,}    # tolower
if [[ "$response" =~ ^(no|n)$ ]]
then
    echo "NO"
else
    echo "YES"
fi

read -p "Enter your name [Richard]: " name
name=${name:-Richard}
echo $name

conda create --name=test python=3.10 -y
conda run -n test conda install cuda-nvcc=11.3.58 cudatoolkit=11.2.2 cudnn=8.1.0 -c conda-forge -c nvidia -y
conda run -n test pip install tensorflow
conda run -n test mkdir -p $CONDA_PREFIX/etc/conda/activate.d
conda run -n test printf 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$CONDA_PREFIX/lib/\nexport XLA_FLAGS=--xla_gpu_cuda_data_dir=$CONDA_PREFIX/lib/\n' > $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
# source $CONDA_PREFIX/etc/conda/activate.d/env_vars.sh
conda run -n test mkdir -p $CONDA_PREFIX/lib/nvvm/libdevice
conda run -n test cp $CONDA_PREFIX/lib/libdevice.10.bc $CONDA_PREFIX/lib/nvvm/libdevice/
