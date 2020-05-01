# dotfiles
My dotfiles and basic configurations.

## Getting started
* Download Arch image from [here](https://www.archlinux.org/download/), Manjaro i3 from [here](https://manjaro.org/download/community/i3/) or Ubuntu minimal from [here](https://wiki.ubuntu-it.org/Installazione/CdMinimale)
* Create a live USB.
* Boot your computer from USB and install the system.

## Restore all configurations

### **START RESTORE SYSTEM**

```
git clone https://github.com/luca-ant/dotfiles.git
cd dotfiles
./start.sh
```


### Setup Github SSH key

* Generate RSA key pair with ssh-keygen and add it to ssh agent.
```
ssh-keygen -t rsa -b 4096
ssh-add ~/.ssh/id_rsa
```

* Add your public key (~/.ssh/id_rsa.pub ) to Github account on [Github Settings](https://github.com/settings/keys).

* Run this command to change from HTTPS remote origin to SSH remote origin. 
```
git remote set-url origin git@github.com:luca-ant/dotfiles.git
```

* Run this command to restore HTTPS remote origin. 
```
git remote set-url origin https://github.com/luca-ant/dotfiles.git
```


## Settings

### Fix time dual boot linux/windows
Run this command to disable UTC and use local time. Then turn on Windows and set time.
```
timedatectl set-local-rtc 1 --adjust-system-clock
```

Run this command to restore original configuration in Linux.
```
timedatectl set-local-rtc 0 --adjust-system-clock
```

### Auto mount data partition
Add these lines in file */etc/fstab* to mount data partition at boot
```
# Entry for data partition
UUID=XXXXXXXXXXXXXXXX /media/luca/DATA	ntfs-3g	defaults,locale=it_IT.UTF-8,auto,fmask=003,dmask=002,uid=1000,gid=1000	0	0
```

### Copy SSH Public Key

* Generate RSA key pair with ssh-keygen.
```
ssh-keygen -t rsa -b 4096
```
* Copy your Public Key to the other machine.
```
ssh-copy-id luca@192.168.1.100
```



### Set favourite terminal

### Remove Chromium asking for password to unlock keyring on startup 
Edit the file */usr/share/applications/chromium-browser.desktop* or */usr/share/applications/google-chrome.desktop* and  change the line starting with "Exec" into **Exec=chromium-browser --temp-profile --password-store=basic**
```
sudo vim /usr/share/applications/chromium-browser.desktop
```
### WakeOnLAN command
```
wakeonlan -i 'IPorDNSname' 'mac'
```
```
wol -i 'IPorDNSname' -p 9 'mac'
```

## Install extra software - Arch

```
yay jdk
archlinux-java status
sudo archlinux-java set java-12-jdk

sudo archlinux-java fix
```

## Install extra software - Ubuntu


### Grub Customizer
```
sudo add-apt-repository ppa:danielrichter2007/grub-customizer
sudo apt-get update
sudo apt-get install grub-customizer
```

### Java
```
sudo apt install software-properties-common dirmngr
sudo add-apt-repository ppa:linuxuprising/java
sudo apt update
sudo apt install oracle-java12-installer-local oracle-java12-set-default-local
```

