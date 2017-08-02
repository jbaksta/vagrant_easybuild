#!/bin/bash
#
# Jared D. Baker <jared.baker@uwyo.edu>
#
# Vagrant Shell Script For Basics
#   - Put SELinux in permissive mode
#   - Install development tools
#   - Install InfiniBand Support (distro OFED, not MLNX)
#   - Install EPEL
#

#
# SELinux is permissive mode
#
echo 0 | sudo tee /sys/fs/selinux/enforce

# 
# Install Packages
#
sudo yum shell -y << EOF
makecache fast
install vim epel-release
run
EOF

sudo yum shell -y << EOF
makecache fast
groupinstall "Development Tools"
groupinstall "InfiniBand Support"
install lua lua-devel lua-posix lua-filesystem lua-lpeg lua-json lua-term wget bash-completion bash-completion-extras readline-devel libibverbs-devel
run
EOF

mkdir -p /opt/Core
chown vagrant:vagrant /opt/Core

