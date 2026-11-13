
## Create basic directories
mkdir -pv $HOME/westerndigital/
mkdir -pv $HOME/restored_data

# Temporary gpg location
export RESTIC_PASSWORD_COMMAND="gpg --quiet --decrypt ${HOME}/Downloads/myTrueResticPasswd.gpg.asc"


export mountpoint="$HOME/westerndigital/"

sudo mount -v /dev/disk/by-uuid/b3a9c52a-92a4-4e05-b533-026874f544b6 $mountpoint

export RESTIC_PASSWORD_COMMAND="gpg --quiet --decrypt ${HOME}/Documents/playingwithgpg/myTrueResticPasswd.gpg.asc"
restic --password-command "$RESTIC_PASSWORD_COMMAND" -r $mountpoint/ snapshots

# Document
restic --password-command "$RESTIC_PASSWORD_COMMAND" \
-r $mountpoint --verbose \
backup $HOME/Documents/

# Downloads
restic --password-command "$RESTIC_PASSWORD_COMMAND" \
-r $mountpoint --verbose \
backup $HOME/Downloads/

# gitrepos
restic --password-command "$RESTIC_PASSWORD_COMMAND" \
-r $mountpoint --verbose \
backup $HOME/gitrepos


restic --password-command "$RESTIC_PASSWORD_COMMAND" \
-r $mountpoint --verbose \
backup $HOME/Pictures/


# projects
restic --password-command "$RESTIC_PASSWORD_COMMAND" \
-r $mountpoint --verbose \
backup $HOME/projects

# unmount
sudo umount $mountpoint

#power off
sudo udisksctl power-off -b /dev/disk/by-uuid/b3a9c52a-92a4-4e05-b533-026874f544b6


# Restoring

restic --password-command "$RESTIC_PASSWORD_COMMAND" \
-r $mountpoint --verbose \
restore --target $HOME/restored_data be0aa679


## Restoring to original location

cd $HOME/restored_data

# e.g. --> cp -vR  home/$USERNAME/gitrepos $HOME/

cp -vR Documents $HOME/ # no need to provide dir name at destination
cp -vR $HOME/Documents/dotfiles/.ssh ~/
cp -vR $HOME/Documents/dotfiles/.vim ~/

