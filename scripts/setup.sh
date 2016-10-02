#!/bin/bash

sudo echo "LANG=en_US.UTF-8" >> /etc/environment
sudo echo "LANGUAGE=en_US.UTF-8" >> /etc/environment
sudo echo "LC_ALL=en_US.UTF-8" >> /etc/environment
sudo echo "LC_CTYPE=en_US.UTF-8" >> /etc/environment

echo ">>>>>>>>>>>>> Upgrading and installing libs and add repositories"
sudo apt-get install -y linux-headers-$(uname -r) build-essential dkms
sudo dpkg --add-architecture i386
sudo apt-get upgrade 
sudo add-apt-repository -y ppa:webupd8team/java
sudo add-apt-repository ppa:xubuntu-dev/xfce-4.12 -y && sudo apt-get update && sudo apt-get dist-upgrade -y
echo ">>>>>>>>>>>>> install extra packages "
sudo apt-get install -y qt4-qtconfig xinit
sudo apt-get install -y xfce4 libncurses5:i386 libstdc++6:i386 zlib1g:i386
sudo apt-get install -y curl virtualbox-guest-dkms virtualbox-guest-utils virtualbox-guest-x11
sudo apt-get install -y unzip firefox leafpad expect ant python-software-properties terminator
echo ">>>>>>>>>>>>> fix dictionaries package"
sudo /usr/share/debconf/fix_db.pl
# diff -u /var/cache/debconf/config.dat{-old,}    | grep ^[+-]Name
# diff -u /var/cache/debconf/templates.dat{-old,} | grep ^[+-]Name
sudo dpkg-reconfigure dictionaries-common
sudo apt-get upgrade -y
echo ">>>>>>>>>>>>> Installing JAVA 8"
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections 
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer > /home/vagrant/java8_install.log

echo ">>>>>>>>>>>>> Download ECLIPSE"
cd /home/vagrant && curl http://www.students.ic.unicamp.br/~otoniel/downloads/inf321_lab01/eclipse_android_inf321_lab01.zip -O --retry 999 --retry-max-time 0 -C - >> /home/vagrant/downloads.log
cd /home/vagrant && unzip eclipse_android_inf321_lab01.zip
sudo chown vagrant. eclipse -R

echo ">>>>>>>>>>>>> Download yEd"
cd /home/vagrant && curl https://www.yworks.com/resources/yed/demo/yEd-3.16.1.zip -o yed.zip --retry 999 --retry-max-time 0 -C - >> /home/vagrant/downloads.log
cd /home/vagrant && unzip yed.zip
sudo chown vagrant. yed-3.16.1 -R 
 
echo ">>>>>>>>>>>>> Download android tools"
ANDROID_SDK_FILENAME=android-sdk_r24.4.1-linux.tgz
ANDROID_SDK=https://dl.google.com/android/$ANDROID_SDK_FILENAME
cd /home/vagrant
curl $ANDROID_SDK -O --retry 999 --retry-max-time 0 -C - >> /home/vagrant/downloads.log
sudo tar -xzvf $ANDROID_SDK_FILENAME -C /opt/
cd /opt/
sudo chown -R vagrant. android-sdk-linux/

echo "export ANDROID_HOME=/opt/android-sdk-linux" >> /etc/profile
echo "export ANDROID_HOME=/opt/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /etc/profile
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /home/vagrant/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools" >> /home/vagrant/.bashrc
echo "export PATH=\$PATH:\$JAVA_HOME/bin:/opt/android-sdk-linux/tools:/opt/android-sdk-linux/platform-tools" >> /etc/profile
echo "Install SDK Android"
expect -c '
set timeout -1   ;
spawn /opt/android-sdk-linux/tools/android update sdk -u --all --filter tools,platform-tools,build-tools-23.0.1,android-23
expect { 
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'
echo "##############################################"
echo "End installation of android tools"


echo ">>>>>>>>> Enable USB devices"
# Add New Devices to the 51.android rules
sudo cp /vagrant/51-android.rules /etc/udev/rules.d/51-android.rules
sudo chmod 644   /etc/udev/rules.d/51-android.rules
sudo chown root. /etc/udev/rules.d/51-android.rules
sudo service udev restart
sudo killall adb

echo ">>>>>>>>>>>>> Installing Appium"
curl -sL https://deb.nodesource.com/setup_0.12 --retry 999 --retry-max-time 0 -C - | bash - \
  && apt-get -qqy install \
    nodejs \
    python \
    make \
    build-essential \
    g++

APPIUM_VERSION=1.5.3
sudo mkdir /home/vagrant/appium && cd /home/vagrant/appium
sudo npm install appium-doctor && sudo ln -s /home/vagrant/appium/node_modules/.bin/appium-doctor /usr/bin/appium-doctor
sudo npm install appium@$APPIUM_VERSION && sudo ln -s /home/vagrant/appium/node_modules/.bin/appium /usr/bin/appium

sudo cp /vagrant/xfce4.zip /home/vagrant/.config/
cd /home/vagrant/.config
sudo unzip xfce4.zip
sudo chown -R vagrant. xfce4 
echo "Finished. REBOOTING!"
sudo reboot 0