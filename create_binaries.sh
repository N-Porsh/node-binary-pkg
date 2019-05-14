#!/usr/bin/env bash
#
# ************* CONFIGURATION
#
: '
Targets
pkg can generate executables for several target machines at a time.You can specify a comma-separated
list of targets via --targets option. A canonical target consists of 3 elements, separated by dashes,
for example node6-macos-x64 or node4-linux-armv6:

* nodeRange node${n} or latest
* platform freebsd, linux, alpine, macos, win
* arch x64, x86, armv6, armv7

You may omit any element (and specify just node6 for example). The omitted elements will be taken
from current platform or system-wide Node.js installation (its version and arch).
There is also an alias host, that means that all 3 elements are taken from current platform/Node.js.
By default targets are linux,macos,win for current Node.js version and arch
'

#comma-separated, without whitespace
TARGETS="node8-linux-x64,node8-macos-x64,node8-win-x64"
SAVE_DIR="binaries"

CONFIG="SAVE_DIR=$SAVE_DIR; TARGETS=$TARGETS;"
printf "Config:\n$CONFIG\n\n"


#
# ************* EXECUTION
#

echo "Delete old binaries from '${SAVE_DIR}' folder"
rm -rf ${SAVE_DIR}

echo "Building executable binaries..."

if [[ ! -d "$SAVE_DIR" ]]; then
  mkdir -m 755 ${SAVE_DIR}
fi


NPM_VERSION=$(npm -v | cut -c1-3) # get npm version
if [[ ${NPM_VERSION} > 5.2 ]]; then
	npx pkg . --out-path ${SAVE_DIR} --targets $TARGETS
else
	./node_modules/.bin/pkg . --out-path ${SAVE_DIR} --targets ${TARGETS}
fi

# create config folder and copy config files that will be used for this binary package
cd ${SAVE_DIR}
mkdir -m 755 external_config && cp -R ../config/. external_config/

echo "Script finished, check '$SAVE_DIR' folder for newly generated files"
