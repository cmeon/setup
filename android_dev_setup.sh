#!/bin/bash

# Installs Android SDK and sets environment variables
# for development in emacs.
DROID_SDK_ROOT=~/android-sdk-linux
TMP=tmp/android-sdk-linux
mkdir $TMP

if [ ! -d $DROID_SDK_ROOT ]; then
    DROID_SDK_URL=`
        curl -s https://developer.android.com/sdk/index.html#ExistingIDE | 
        grep 'id="linux-tools"' |
        sed 's/.*href="\([^"]*\)".*$/\1/'`
# courtesy of http://sed.sourceforge.net/grabbag/scripts/list_urls.sed
    sudo apt-get install ant

    cd $TMP
    wget $DROID_SDK_URL --output-document=android-sdk.tgz
    tar -xvzf android-sdk.tgz
    mv android-sdk-linux $HOME
    cd $HOME
fi

DROID_SDK_PATH=`grep android-sdk-linux ~/.bashrc_custom`
if [ -z "$DROID_SDK_PATH" ]; then
    echo nigga
    echo $SDK_PATH
    cat >> $HOME/.bashrc_custom <<EOF

# Android tools

export PATH=\$PATH:$DROID_SDK_ROOT/tools
export PATH=\$PATH:$DROID_SDK_ROOT/platform-tools
EOF

fi

if [ ! -f ~/.emacs.d/android-mode.el ]; then
    wget https://raw.github.com/cmeon/android-mode/master/android-mode.el
    mv android-mode.el ~/.emacs.d
fi

android
