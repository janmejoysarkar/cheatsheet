## Fix touchpad not working
Lenovo Ideapad Slim 3 uses ELAN touchpad which is not included in the Linux c=kernel that comes with Ubuntu 20.04LTS. DO the following to solve the issue.
```
Open sudo nano etc/default/grub 
Edit- GRUB_CMDLINE_LINUX="i18042.nopnp=1 pci=nocrs"
Save (Ctrl+O) and exit (Ctrl+X)
Update grub- sudo update-grub
Reboot.
Touchpad will work as normal.
Ref- https://www.youtube.com/watch?v=ZFs8rsTVLtc&list=LL&index=1
```

## Video tearing
Fix Tearing of video while in fullscreen in Totem video player and Firefox-
Use VLC and Google Chrome instead and the problem will be fixed.

## Fix Monitor Brightness buttons not working-

Install `xdotool`
`xdotool` key 232 and `xdotool` key 233 commands decreases and increases screen brightness respectively.
Map the two commands to F11 and F12 from the custom shortcuts in settings.
Now this changes brightness directly in Gnome.
Fact: `/sys/class/backlight/intel_backlight/brightness gives current monitor brightness.`
Ref- https://itectec.com/ubuntu/ubuntu-lenovo-ideapad-brightness-keys-not-generating-any-events-in-ubuntu-16-04-1/

Update: For use with i3wm, the screen backlight brightness can be changed with 
brightnessctl set 40% #setbacklight to 40%
But this requires root previliges. To remove root access use chown to make yourself the owner of this file- /sys/class/backlight/intel_backlight/brightness

`xrandr --output [device name] --brightness [0-1] # can be used to change the LCD brightness. This does not reduce backlight. Good for desktop monitors.`

## Change windows partition to Read Only-

Open Disks.
Edit Mount Options for Windows system partition.
Turn off auto mount.
Add ,ro at the end of the mount conditions.
Remount the drive.

## Check log of installed packages-
grep " install" /var/log/dpkg.log*


## PopOS tiling window manager extention-
```
sudo apt install node-typescript make
git clone https://github.com/pop-os/shell
cd shell
make local-install
```
OR, use the downloaded zip. Extract and copy to Home. Run the make command in the directory.


## Enable or disable Conservation Mode for Lenovo Ideapad.

In Conservation mode batteru charges to 60% and stays that much. This can be toggled in 
Lenovo Vantage application on Windows.

Commands:
```
reading the current status:                          
cat /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

Before toggling Conservation mode, run-
sudo su
Otherwise permission denied will come up.

enable Conservation mode:
echo 1 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode

disable conservation mode:
echo 0 > /sys/bus/platform/drivers/ideapad_acpi/VPC2004:00/conservation_mode
```
Source: https://www.youtube.com/watch?v=d1l2Fg1Nx4E


## Modified icons pack (KDE Plasma)
 Place the folders in
 `/home/janmejoy/.local/share/icons/`
 
 Browse for the theme in the KDE Icon Settings.
 Papirus is parent folder. Most other icons are linked to this directory.
 
 Icon pack- https://drive.google.com/file/d/12XyS0YGeuQNdscofanVVGtNyP5al7vtj/view?usp=sharing
 

## Transparent Taskbar and menus (KDE Plasma)
Method 2. This will require altering the default theme. Make a backup of `/usr/share/plasma/desktoptheme/default/metadata.desktop`. Open it with root rights. Change in the [ContrastEffect] section enabled=true to false. Re-login.\
Now the panel(s) become semi-transparent. As a bonus the main menu also becomes semi-transparent with blur effect under it.\
https://itectec.com/ubuntu/ubuntu-how-to-make-kde-plasma-taskbar-panel-transparent/

## Icon Pack used
```ePapirus```

## KDE Plasma Window Tiling:
Krohnkite script on Kwin scripts in KDE Plasma

Enable Krohnkite settings:
```
mkdir -p ~/.local/share/kservices5/
ln -s ~/.local/share/kwin/scripts/krohnkite/metadata.desktop ~/.local/share/kservices5/krohnkite.desktop
```
Use KWin Global shortcuts to modify key bindings.

## Networking
- See devices on network-
`sudo nmap -sn [default gateway ip]/24`

- See the default gateway of a network.
`route` #The flag U indicates that route is up and G indicates that it is gateway


## Keyboard button and mouse responses.
`xev`

## See running processes
`ps -e`

## File Sorting

- To sort files in a folder based on filesize:
  ```du -h --max-depth=1 | sort -h```
- To sort files based on file key
   ```ls | sort -t '<sort key>' -k 2 # sort based on the second segment after the delimiter```


## To change screen brightness / to change monitor config from teminal
```xrandr --output HDMI-1 --brightness 0.7```

## Using Dolphin in i3wm
Dolphin icons dont show up by default as it is a Qt application and i3wm is not a Qt environment. So a Qt emulator has to be installed.
```
sudo apt install qt5ct
```
- create ~/.bash_profile
- add the line export QT_QPA_PLATFORMTHEME=qt5ct 
- This asks bash to qt5ct as the Qt platform theme.
- Launch qt5ct to modify fonts and iconpacks.
- Logout and login to see the changes.


## Enable tap to click on touchpad with X11. Works to enable tap to click on i3wm.

- https://cravencode.com/post/essentials/enable-tap-to-click-in-i3wm/
- X11 provides configurations in a directory “X11/xorg.conf.d/” this directory could live in various places on your system depending on your distribution.
- However, X11 will always attempt to also load configurations from /etc/X11/xorg.conf.d/ when present.
- To ensure the directory exists, run:
```
sudo mkdir -p /etc/X11/xorg.conf.d
```
- Copy code
- Next we’ll create a new file “90-touchpad.conf”. The configuration file names end with .conf and are read in ASCII order—by convention file names begin with two digits followed by a dash.
```
sudo touch /etc/X11/xorg.conf.d/90-touchpad.conf
```
- Copy code
- Now open up the file your editor of choice (with suitable write permission of course) and paste the following:
```
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
EndSection
```
- Copy code
- Additional libinput options
- Libinput support additional options beyond tapping, you can add and configure each one by adding them on new lines after Option "Tapping" "on" in your /etc/X11/xorg.conf.d/90-touchpad.conf, for example:
```
Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "TappingButtonMap" "lrm"
        Option "NaturalScrolling" "on"
        Option "ScrollMethod" "twofinger"
EndSection
```
- Copy code
- Two and three finger tap
- Two and three finger tap configurations can be set with to have two finger tap to cause a right-click and three finger tap to cause a middle-click with:
```
Option "TappingButtonMap" "lrm"
```
- Copy code
- Or two make a two finger tap do a middle-click and a three finger tap to cause a right-click:
```
Option "TappingButtonMap" "lmr"
```
- Copy code
- Natural scrolling
- Natural scrolling can be enabled with:
```
Option "NaturalScrolling" "on"
```
- Copy code
- Scroll method
- Two scroll with two fingers, the default:

        Option "ScrollMethod" "twofinger"
-Copy code
- If you prefer to use the edge of your touchpad:

        Option "ScrollMethod" "edge"
-Copy code


## Bluetooth speakers connection

http://leetschau.github.io/manage-bluetooth-in-i3wm.html

Turn ON or OFF BT adapter:
```
rfkill list #shows which devices are blocked
rfkill unblock bluetooth #enable bluetooth
rfkill block bluetooth  #disable bluetooth

systemctl status bluetooth.service #(if it is enabled)
#(other options- systemctl [start/stop] bluetooth.service)

bluetoothctl power on
scan on
devices #to see list of devices
connect [MAC ID]
scan off
```

## Suspend session
```systemctl suspend #this does not lock the screen```

## Use ` brightnessctl ` without sudo:
As per udev rules in /usr/lib/udev/rules.d/90-brightnessctl.rules user in video group can change brightness without sudo.

Add user to video group-
```sudo usermod -aG video ${USER}```


## Enable/Disable conda base environment from starting in bash

```conda config --set auto_activate_base false```
The first time you run it, it'll create a .condarc in your home directory with that setting to override the default. This wouldn't de-clutter your .bash_profile but it's a cleaner solution without manual editing that section that conda manages.

To enable base environ- `conda config --set auto_activate_base true`


## Set power key to lock and suspend
install `xss-lock` to lock the screen before it suspends. `xss-lock` is started by the `i3config` by default.

edit the file- `/etc/systemd/logind.conf`
Uncomment 2 options and edit them as follows-
```
HandlePowerKey=suspend
PowerKeyIgnoreInhibited=yes
```

### Replace spaces with underscore- Batch rename
```
for file in *; do mv "$file" `echo $file | tr ' ' '_'` ; done
for i in `ls`; do mv $i `echo $i | sed 's/_/-/'` ; done
```

## Share files online through null pointer
```curl -F "file=@filename" 0x0.st```


## Change Running CPUs:
```
echo 0 > /sys/devices/system/cpu/cpu3/online #disable CPUs
echo 1 > /sys/devices/system/cpu/cpu3/online #enable CPUs
```
Change intel turbo boost (Saves a lot of battery power. Increases battery life > 2x)

Disable turbo boost (with root):
```
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo #Disable
echo 0 > /sys/devices/system/cpu/intel_pstate/no_turbo #Enable
```

## gpg encryption with default AES-256

- Encryption: `gpg -c --no-symkey-cache file.txt`
- Decryption: `gpg -d --no-symkey-cache file.txt`

`--no-symkey-cache` Prevents adding the passphrase to the gpg pw cache (or keyring). So passphrase has to be entered for decryption and encryption every time.

## Password generator
``` pwgen```

## Enable autosuspend in i3wm-
```exec --no-startup-id xautolock -time 60 -locker "systemctl suspend"```

## View .nef files
Use `XnView Multiplatform` to view `.nef` images as they are in linux

Display Thumbnails for .nef files-  
NEF files (and probably lots of other formats) have embedded JPEG's previews in them.  
Edit the file `/usr/share/thumbnailers/gdk-pixbuf-thumbnailer.thumbnailer` to add the missing MIME types.
Append just `image/x-nef;image/x-nikon-nef;` for NEF if you want, or you can add all RAW formats (I just did that):
`image/x-3fr;image/x-adobe-dng;image/x-arw;image/x-bay;image/x-canon-cr2;image/x-cano`

## Monitor power management:
```
xset dpms 300 600 900
xset -dpms #disables Digital Power Management System
```
Disable screen blanking or screen saver- 
```
xset s noblank & #disables screensaver screenblanking
xset s off & #disables screensaver
```
Use KDE powerdevil in i3wm for power management-

`/usr/lib/x86_64-linux-gnu/libexec/org_kde_powerdevil & #starts powerdevil` to manage power settings from kde settings.
KDE powerdevil uses xset dpms to set monitor power management. So Enabling powerdevil automatically enables dpms.

## Show dropbox or other program icons in GNOME 44:
Use extention- `AppIndicator` and `KStatusNotifierItem` Support

## Start ssh service to send/ recieve files:
```
sudo systemctl start sshd
```

## Start bluetooth service:
```
sudo pacman -S bluez
sudo pacman -S bluez-utils
sudo pacman -S blueman
```
Blueman is optional, if you do not have a bluetooth manager in the WM or DE.
```
sudo systemctl start bluetooth.service #to start the service
sudo systemctl enable bluetooth.service #to enable it automatically
```

## Rclone backup command for backup_esentials.
```rclone sync -nv /run/media/janmejoy/backup/backup_essentials/ google_drive:backup/backup_essentials/```
+ `-n Dry-run`
+ `-v Verbose`

## Use gnome shell extention 
Disable unredirect fullscreen windows to prevent tearing of video in vlc or other video players.

## Bluetooth audio connection issues- 
* SL-BD106 BT audio adapter * 
```
bluetoothctl
power on
scan on
remove XX:XX:XX:XX:XX:XX, if it had already been paired
trust XX:XX:XX:XX:XX:XX
pair XX:XX:XX:XX:XX:XX
connect XX:XX:XX:XX:XX:XX
```

## Change screen brightness in GNOME 44
- Step up
```gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepUp```
- Step down
```gdbus call --session --dest org.gnome.SettingsDaemon.Power --object-path /org/gnome/SettingsDaemon/Power --method org.gnome.SettingsDaemon.Power.Screen.StepDown```


## Convert image to black and white
Removes RGB channels and keeps gray only. Uses imagemagick.
```convert image.jpg -colorspace Gray image_bw.jpg```

## Remove orphaned dependencies from arch linux
```
sudo pacman -Rsn `pacman -Qdtq`
```

## Connect to remote kernel in spyder python
ensure `spyder-kernels` is installed on remote machine.

## On remote computer-
```
jupyter --runtime-dir #copy the output. Gives the console files location.
python -m spyder_kernels.console #this gives the console file
```
On local computer-
+ `scp` the console file from remote host to local client.
+ Open `spyder`
+ `Consoles menu > Connect` to an existing kernel
+ Add the console file.
+ Enable `ssh` and enter credentials.
+ The files in the console will be that of the remote machine.


## For fetching old, out of date packages unavailable normally.
They are downloaded from mirrors.
Uncomment `[multilib]` and the next line in `/etc/pacman.conf`. Do `-Sy`, and then it found.

## Enable newly added fonts
Add new fonts to `.fonts` and run this to see the fonts enabled in all apps without logout and login
```fc-cache```


## Mount remote file system to local machine.
```
sshfs janmejoy@192.168.11.226:/[folder] [mount-location]/
sshfs -o follow_symlinks janmejoy@192.168.11.226:/scratch sftp_drive/ #to follow remote symlinks
```
To unmount- 
```
fusermount -u [mount-location]
```

Same can be done by mounting sftp using nautilus.
sftp://janmejoy@192.168.11.226
Unmount can be done with nautilus.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
To print every 4th line starting from 1st line in file.txt:
sed -n '1~4p' file.txt
-n prevents printing everything and gives only what is needed.

To replace a string with a replacement in the terminal:
standard string | sed 's/string/replacement/g'
s: Substitute
g: global replacement- Make replacements everywhere in the text. Ommit the g for replacin in first instance only.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Update yay. Yay cannot be updated with pacman.

git clone https://aur.archlinux.org/yay-bin
cd yay-bin/
makepkg -si
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
tmux
tmux new -s session-name #make new session
tmux ls #list sessions
tmux a #attach to last detached session
tmux a -t session-name #attach to any particular session
# within a session-
Ctrl+b > d #detach from session
Ctrl+b > % #Vertical split the pane
Ctrl+b > " #Horizontal split the pane
Ctrl+b > arrow key #Go to window within a pane
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Make a tarball:
tar -zcvf tarball.tar file1 file2 file3
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Keep Firefox top panel from disappearing in Full Screen mode
Type about:config on Firefox address bar.
Search for browser.fullscreen.autohide
Toggle to false
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Make video from still images- ffmpeg
ffmpeg -framerate 1 -pattern_type glob -i '*.jpg' -c:v libx264 -r 30 -pix_fmt yuv420p output.mp4
https://shotstack.io/learn/use-ffmpeg-to-convert-images-to-video/
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Format a disk partition with the ext4 file system using the following command:
sudo mkfs -t ext4 /dev/sdb1 #replace ext4 with fat32 or ntfs

2. Next, verify the file system change using the command:
lsblk -f
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Install gvim to emable copying to system clipboard in X display server.
Install jedi-vim to enable python support in vim.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Update all packages in a Conda environment
conda update -n ENVIRONMENT --all
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Follow symlinks in SSHFS:
sshfs -o follow_symlinks remote-folder mount-loc
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Update conda- Updates conda itself. This has to be done in the base environ.
conda update -n base -c defaults conda
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Copy outside to clipboard from Vim:
Install gvim. It installs dependencies that allows to copy outside.
In vim- 
Select by Visual Block
Press "+y to yank to the + register. 
Paste outside.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Connect Logitech MX Master 3S to arch linux:
The sequence that always works for me is remove device (if I messed up last time and the pairing ended up in a broken state) → put mouse into pairing mode → search for devices → trust mouse → pair mouse.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Apply TMUX config file
tmux source ~/.tmux.conf
Default config file location: ~/.tmux.conf
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Remove all package cache except those installed:
sudo pacman -Sc
Remove all package cache (not recommended)
sudo pacman -Scc
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Check kernel version:
uname -a
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Shows which package uses a file
pacman -Qo file-name
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Add black padding to make square images-
for img in *; do echo $img;
magick $img -auto-orient -gravity center -background black -extent "%[fx:max(w,h)]x%[fx:max(w,h)]" square_$img;
done
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Enable CoC-vim
Install nodejs-lts from pacman (vim-plug dependency)
Install npm
Install and automatically run vim-plug
#Place the following code in your .vimrc before plug#begin() call
'''
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
'''
# Note that --sync flag is used to block the execution until the installer finishes.
# https://github.com/junegunn/vim-plug/wiki/tips#automatic-installation

#Add coc-vim as a plugin in the ~/.vimrc
call plug#begin()
" Use release branch (recommended)
'''
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
'''
#restart Vim and run 
:PlugInstall

#Install python interpreter
:CocInstall coc-jedi
Note: this extension is incompatible with coc-python. Uninstall coc-python before using coc-jedi.

Use the following example vim config for better keybinds- 
https://github.com/neoclide/coc.nvim?tab=readme-ov-file#example-vim-configuration
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

Install the CoC plugin in vim-
:CocInstall coc-snippets

Make and write python snippets file. Add required snippets here:
~/.config/coc/ultisnips/python.snippets

xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Download files of a filetype from a website with wget in present directory

BASE_URL="give_url_here"
wget -r -A -nd "*.jpg, *.JPG" . "$BASE_URL"

-r: Enables recursive downloading.
-A "*.jpg": Specifies file types to accept
-nd: Saves all files in the output directory without recreating the folder structure.

Other options:
-l1: Limits recursion to 1 level.
-P "$OUTPUT_DIR": Specifies the output directory.
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Branch management in Git and Git Remote
#Make a new branch-
git branch <branch-name>
#Go to new branch
git checkout <branch-name>
#Merge branch
git checkout master
git merge <branch-name> #Merges branch with branch you are currently in
git push origin <branch-name> # To push the branch to remote
#Delete branch
git branch -d <branch-name>
git push origin --delete <branch-name> #Deletes branch from remote
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
Disable auto indenting in vim while pasting
:set paste
Enable auto indenting
:set nopaste
xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

## Remove Gnome and all Gnome related software-
``` pacman -Runs gnome ```

-u, --unneeded
           Removes the targets that are not required by any other packages.
           This is mostly useful when removing a group without using the -c
           option, to avoid breaking any dependencies.
           

## Disable automatic activation of conda environment:

```conda config --set auto_activate_base false```
Enable:
```conda activate <env>```

## Using CPUPOWER to manage power usage by CPU-
```sudo cpupower frequency-set --max 800MHz #Sets max frequency```


## To check battery devices and battery capacity:
```
upower -e #Shows battery devices
upower -i /org/freedesktop/UPower/devices/battery_BAT0 #Shows battery capacity. 
```
The argument can be found as an output from upower -e


## Add new user:
```
sudo mkdir /home/username
sudo useradd username
sudo passwd username #Set password
```

## Change default apps:
Modify the file `~/.config/mimeapps.list`

## Setup nvim
- Install nvim.
- mkdir ~/.config/nvim
- make file init.vim
- install vimplug from junegunn/vimplug
- Use CoC for python completion


## Latex compilation with short output-
`latexmk -pdf -silent THESIS.tex`

## Make bare repo for dotfiles:
The repo will be called `dot`. It will be managed in a folder called .dotfiles
```
git init --bare $HOME/.dotfiles
alias dot='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME' >> ~/.bashrc
```
## Git: Show/Add only tracked files
Show status of tracked files
```git status -uno```

Stage files that have been changed.
```git add -u```
