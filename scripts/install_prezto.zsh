git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto

setup_path=$HOME/.zprezto/runcoms
files=$(find $setup_path/* -not -name README.md -not -name zshrc -exec basename {} \;)
for file in $files; do
  out_file=~/.$file
  in_file=$setup_path/$file
  if [ -e $out_file ] ; then
      echo "Backed up existing $out_file"
      mv $out_file $out_file.bak
  fi
  ln -s $in_file $out_file
done
