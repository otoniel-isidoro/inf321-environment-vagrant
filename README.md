### INF321 LAB01 ENVIRONMENT 

#### PRÉ-REQUISITOS

  * Windows
      * Instalar o gerenciador de pacotes [Chocolatey](https://chocolatey.org/) 

         `@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"` (rodar em prompt de comando com permissão de administrador)

      * Instalar [VirtualBox](https://www.virtualbox.org/wiki/Downloads) 

          `choco install virtualbox`
      
      * Instalar [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads) 

          `choco install VirtualBox.ExtensionPack`
      
      * Instalar [Vagrant](https://www.vagrantup.com/downloads.html) 

          `choco install vagrant`

      * Intalar [Vagrant plugin vbguest](https://github.com/dotless-de/vagrant-vbguest) 

          `vagrant plugin install vagrant-vbguest`

  * Linux / Mac
      * Instalar [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
      * Instalar [VirtualBox Extension Pack](https://www.virtualbox.org/wiki/Downloads)
      * Instalar [Vagrant](https://www.vagrantup.com/downloads.html)
      * Intalar [Vagrant plugin vbguest](https://github.com/dotless-de/vagrant-vbguest) 

        `vagrant plugin install vagrant-vbguest`


#### Iniciar ambiente

  `vagrant up`

#### Parar ambiente

  `vagrant halt`

#### Apagar ambiente

  `vagrant destroy`