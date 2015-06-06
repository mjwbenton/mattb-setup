#!zsh -e

# Assumes you've already run install_vundle.zsh

command_t_dir=$HOME/.vim/bundle/command-t
ruby_subdir=$command_t_dir/ruby/command-t/

cd $ruby_subdir
ruby extconf.rb
make
