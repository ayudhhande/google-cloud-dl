# ensure system is updated and has basic build tools
sudo apt-get update
sudo apt-get --assume-yes upgrade
sudo apt-get --assume-yes install tmux build-essential gcc g++ make binutils
sudo apt-get --assume-yes install software-properties-common

# download and install GPU drivers

# see https://cloud.google.com/compute/docs/gpus/add-gpus#install-gpu-driver
echo "Checking for CUDA and installing."
# Check for CUDA and try to install.
if ! dpkg-query -W cuda; then
  curl -O http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  dpkg -i ./cuda-repo-ubuntu1604_8.0.61-1_amd64.deb
  sudo apt-get update
  sudo apt-get install cuda -y
fi

# verify that GPU driver installed
sudo modprobe nvidia
nvidia-smi

sudo apt-get install libcupti-dev

# install Anaconda for current user
mkdir downloads
cd downloads
wget "https://repo.continuum.io/archive/Anaconda2-5.0.1-Linux-x86_64.sh" -O "Anaconda2-5.0.1-Linux-x86_64.sh"

bash "Anaconda2-5.0.1-Linux-x86_64.sh" -b

echo "export PATH=\"$HOME/anaconda2/bin:\$PATH\"" >> ~/.bashrc
export PATH="$HOME/anaconda2/bin:$PATH"
conda install -y bcolz
conda upgrade -y --all

# install and configure theano
conda install theano pygpu
echo "[global]
device = cuda0
floatX = float32
[cuda]
root = /usr/local/cuda" > ~/.theanorc

# install and configure keras
conda install keras
mkdir ~/.keras
echo '{
    "epsilon": 1e-07,
    "floatx": "float32",
    "backend": "theano",
    "image_data_format": "channels_first"
}' > ~/.keras/keras.json

# install cudnn libraries
wget "http://files.fast.ai/files/cudnn.tgz" -O "cudnn.tgz"
tar -zxf cudnn.tgz
cd cuda
sudo cp lib64/* /usr/local/cuda/lib64/
sudo cp include/* /usr/local/cuda/include/

# configure jupyter and prompt for password
jupyter notebook --generate-config
jupass=`python -c "from notebook.auth import passwd; print(passwd())"`
echo "c.NotebookApp.ip = '*'
c.NotebookApp.password = u'"$jupass"'
c.NotebookApp.open_browser = False
c.NotebookApp.port = 5000" >> $HOME/.jupyter/jupyter_notebook_config.py

# clone the fast.ai course repo and prompt to start notebook
cd ~
git clone https://github.com/fastai/courses.git
echo "\"jupyter notebook\" will start Jupyter on port 5000"
echo "If you get an error instead, try restarting your session so your $PATH is updated"

