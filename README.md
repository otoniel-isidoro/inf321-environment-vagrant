### INF321 LAB01 ENVIRONMENT 

#### PRÉ-REQUISITOS

  * Windows
      * Instalar o gerenciador de pacotes [Chocolatey](https://chocolatey.org/) 
      
         Para instalar rodar o comando abaixo em um prompt de comando com permissão de administrador:
         
         `@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"` 

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

      * No linux para o virtualbox reconhecer os devices conectados via usb é necessário adicionar o usuario ao grupo `vboxusers`:

        `sudo usermod -a -G vboxusers <nome do usuario>`

        Para verificar se o usuario foi adicionado ao grupo:

         `groups <nome do usuario>`
        
        Se o grupo vboxusers aparecer na listagem então a configuração está correta.
        Após adicionar o usuário é necessario reiniciar o linux.

#### Iniciar ambiente

  `vagrant up`

#### Parar ambiente

  `vagrant halt`

#### Apagar ambiente

  `vagrant destroy`
