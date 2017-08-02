#!/bin/bash
#
# Simple Script to Install EasyBuild
#

[ -f /etc/profile.d/z00_modules.sh ] && . /etc/profile.d/z00_modules.sh

sudo yum -y install python-setuptools

EB_BOOTSTRAP="https://raw.githubusercontent.com/easybuilders/easybuild-framework/develop/easybuild/scripts/bootstrap_eb.py"

if [ ! -f "bootstrap_eb.py" ]; then
	wget $EB_BOOTSTRAP
fi

#EASYBUILD_PREFIX=/opt/Core/EasyBuild/3.3.1
#export EASYBUILD_PREFIX

cat << EOF | sudo tee /etc/profile.d/z02_easybuild.sh
#!/bin/bash
EASYBUILD_MODULE_NAMING_SCHEME="HierarchicalMNS"
export EASYBUILD_MODULE_NAMING_SCHEME

EASYBUILD_MODULES_TOOL="Lmod"
export EASYBUILD_MODULES_TOOL

EASYBUILD_INSTALLPATH_SOFTWARE="/opt/Core/eb"
export EASYBUILD_INSTALLPATH_SOFTWARE

EASYBUILD_INSTALLPATH_MODULES="/opt/Core/lmod/mf/eb"
export EASYBUILD_INSTALLPATH_MODULES

module use /opt/Core/lmod/mf/eb/all/Core
EOF

if [ -f /etc/profile.d/z02_easybuild.sh ]; then
	. /etc/profile.d/z02_easybuild.sh
else
	echo "No profile script to source. Exiting." >&2
	exit
fi

#
# Install EasyBuild
#
python bootstrap_eb.py $EASYBUILD_INSTALLPATH_SOFTWARE

