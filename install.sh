# Installer for my dotfiles
set -e
which stow
if [ "$?" -eq "1" ]
then
	echo "Stow is required to install stuff you big dummy!"
	exit 1
fi
# Install top level dotfiles  
pushd files

mkdir -p ~/.local || true
mkdir -p ~/.config || true

stow bin -t ~/.local/bin
stow .config -t ~/.config
stow dots -t ~

touch ~/.bashrc
touch ~/.bash_profile

# DELETE OLD Bash CONFIG
sed -i '/^### BEGIN FROM DOTFILES/,/^### END FROM DOTFILES/d' ~/.bashrc
sed -i '/^### BEGIN FROM DOTFILES/,/^### END FROM DOTFILES/d' ~/.bash_profile

# Append bashrc and bash_profile
echo "### BEGIN FROM DOTFILES" >> ~/.bashrc
echo "### BEGIN FROM DOTFILES" >> ~/.bash_profile
cat .bashrc >> ~/.bashrc
cat .bash_profile >> ~/.bash_profile
echo "### END FROM DOTFILES" >> ~/.bashrc
echo "### END FROM DOTFILES" >> ~/.bash_profile

popd

