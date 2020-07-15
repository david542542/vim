
# Check if we have vim version 8.1+ installed
VIM_PATH=$(which vim)
VIM_VERSION=$(vim --version |grep '8.[123]')
echo Vim path is: $VIM_PATH
echo Vim version is: $VIM_VERSION
if [ -z "$VIM_PATH" ] || [ -z "$VIM_VERSION" ]
then
    # Get OS
    source /etc/os-release
    if [ $NAME = 'Ubuntu' ]
    then
        echo 1/3. updating vim...
        sudo add-apt-repository ppa:jonathonf/vim
        sudo apt update
        sudo apt install vim
        apt-get install ctags # needs java if we want to do this
        cd ~
        echo 2/3. downloading vim from git...
        git clone git@github.com:david542542/.vim.git
        echo 3/3. installing plugins...
        vim +PlugInstall +qall
    else
        echo 'Not ubuntu -- install manually'
        exit
    fi
else
    echo Vim already installed
fi

if [ -z "$(grep 'VIM,TMUX' ~/.bash_profile)" ]
then
    echo '# VIM,TMUX stuff'                 >> ~/.bash_profile
    echo 'VIM="$(which vim)"'               >> ~/.bash_profile
    echo 'export EDITOR="$VIM"'             >> ~/.bash_profile
    echo 'export VISUAL="$VIM"'             >> ~/.bash_profile
    echo 'alias vi="$VIM"'                  >> ~/.bash_profile
    echo 'alias V="cd ~/.vim"'              >> ~/.bash_profile
    echo 'alias S="source ~/.bash_profile"' >> ~/.bash_profile
    echo 'alias ta="tmux -CC a -t"'         >> ~/.bash_profile
    echo 'alias tn="tmux -CC new -s"'       >> ~/.bash_profile
    echo 'alias tl="tmux ls"'               >> ~/.bash_profile
    echo 'alias td="tmux ls"'               >> ~/.bash_profile
    echo 'alias tk="tmux kill-session -t"'  >> ~/.bash_profile
    echo 'alias t="tmux -CC a"'             >> ~/.bash_profile
    echo ''                                 >> ~/.bash_profile
    echo added new lines
else
    echo lines already added
fi
