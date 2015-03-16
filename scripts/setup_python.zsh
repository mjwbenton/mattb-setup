#!zsh -e
if [ `which python` != /usr/local/bin/python ]; then
    echo "not using brew python! - exiting"
    exit 1
fi
pip install --upgrade setuptools
pip install --upgrade pip
pip install --upgrade virtualenv
