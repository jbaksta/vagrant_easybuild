#!/bin/bash
#
# Build and Install Lmod
#

#
# Clone the Git repo
#
git clone https://github.com/TACC/Lmod.git

# Build the software
cd Lmod

LMOD_PREFIX="/opt/Core"

./configure \
	--prefix=$LMOD_PREFIX \
	--with-module-root-path=$LMOD_PREFIX/lmod/mf
make
make install

sudo ln -s $LMOD_PREFIX/lmod/lmod/init/profile /etc/profile.d/z00_lmod.sh
sudo ln -s $LMOD_PREFIX/lmod/lmod/init/cshrc /etc/profile.d/z00_lmod.csh

cat << EOF | sudo tee /etc/profile.d/z01_lmod.sh
#!/bin/bash
export LMOD_SYSTEM_DEFAULT=""
EOF

cat << EOF | sudo tee /etc/profile.d/z01_lmod.csh
#!/bin/csh
setenv LMOD_SYSTEM_DEFAULT ""
EOF
