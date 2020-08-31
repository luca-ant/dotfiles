# dotfiles
My dotfiles and basic configurations.

## Getting started
* Download Arch image from [here](https://www.archlinux.org/download/), Manjaro i3 from [here](https://manjaro.org/download/community/i3/) or Ubuntu minimal from [here](https://wiki.ubuntu-it.org/Installazione/CdMinimale)
* Create a live USB.
* Boot your computer from USB and install the system.

## **RESTORE SYSTEM**

```
git clone https://github.com/luca-ant/dotfiles.git
cd dotfiles
./start.sh
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
UUID=XXXXXXXXXXXXXXXX /media/luca/DATA	ntfs-3g	defaults,auto,fmask=003,dmask=002,uid=1000,gid=1000	0	0
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

