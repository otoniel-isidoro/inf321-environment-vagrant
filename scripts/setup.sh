#!/bin/bash

sudo echo "LANG=en_US.UTF-8" >> /etc/environment
sudo echo "LANGUAGE=en_US.UTF-8" >> /etc/environment
sudo echo "LC_ALL=en_US.UTF-8" >> /etc/environment
sudo echo "LC_CTYPE=en_US.UTF-8" >> /etc/environment

echo ">>>>>>>>>>>>> Upgrading and installing libs and add repositories"
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
diff -u /var/cache/debconf/config.dat{-old,}    | grep ^[+-]Name
diff -u /var/cache/debconf/templates.dat{-old,} | grep ^[+-]Name
sudo dpkg-reconfigure dictionaries-common
sudo apt-get upgrade -y
echo ">>>>>>>>>>>>> Installing JAVA 8"
echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections 
echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
sudo apt-get -y install oracle-java8-installer

echo ">>>>>>>>>>>>> Download ECLIPSE"
cd /home/vagrant && curl http://ftp.fau.de/eclipse/technology/epp/downloads/release/neon/R/eclipse-android-neon-R-incubation-linux-gtk-x86_64.tar.gz -O --retry 999 --retry-max-time 0 -C -
cd /home/vagrant && tar -zxvf eclipse-android-neon-R-incubation-linux-gtk-x86_64.tar.gz

echo ">>>>>>>>>>>>> Download yEd"
cd /home/vagrant && curl https://www.yworks.com/resources/yed/demo/yEd-3.16.1.zip -o yed.zip --retry 999 --retry-max-time 0 -C -
cd /home/vagrant && unzip yed.zip
 
echo ">>>>>>>>>>>>> Download android tools"
ANDROID_SDK_FILENAME=android-sdk_r24.4.1-linux.tgz
ANDROID_SDK=https://dl.google.com/android/$ANDROID_SDK_FILENAME
cd /home/vagrant
curl $ANDROID_SDK -O --retry 999 --retry-max-time 0 -C -
tar -xzvf $ANDROID_SDK_FILENAME
sudo chown -R vagrant android-sdk-linux/
rm $ANDROID_SDK_FILENAME
 
echo "export ANDROID_HOME=/home/vagrant/android-sdk-linux" >> /home/vagrant/.bashrc
echo "export JAVA_HOME=/usr/lib/jvm/java-8-oracle" >> /home/vagrant/.bashrc
echo "PATH=\$PATH:/home/vagrant/android-sdk-linux/tools:/home/vagrant/android-sdk-linux/platform-tools" >> /home/vagrant/.bashrc
echo "Install SDK Android 24"
expect -c '
set timeout -1   ;
spawn /home/vagrant/android-sdk-linux/tools/android update sdk -u --all --filter tools,platform-tools,build-tools-23.0.1,android-23,sys-img-armeabi-v7a-android-23
expect { 
    "Do you accept the license" { exp_send "y\r" ; exp_continue }
    eof
}
'
echo "##############################################"
echo "End installation of android tools"


echo ">>>>>>>>> Enable USB devices"
# Add New Devices to the 51.android rules
sudo cp /vagrant/android.rules /etc/udev/rules.d/51-android.rules
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
sudo npm install appium@$APPIUM_VERSION && sudo ln -s /home/vagrant/appium/node_modules/.bin/appium /usr/bin/appium

echo "Finished. REBOOTING!"
sudo reboot 0