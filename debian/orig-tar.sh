#!/bin/bash

#######################################################
# This script fetches the latest commit of the branch #
# with the specified revision.                        #
#######################################################

if [ -d androidsdk-tools -o -f androidsdk-tools ]
then
    echo "The file/directory 'androidsdk-tools' exists .. aborting."
    exit
fi

REVISION=22.2

git clone -b tools_r$REVISION https://android.googlesource.com/platform/tools/swt androidsdk-tools
git clone -b tools_r$REVISION https://android.googlesource.com/platform/tools/base androidsdk-base

# Merge sources into a single directory
mv androidsdk-base/common androidsdk-base/sdklib androidsdk-base/ddmlib androidsdk-tools
rm -fr androidsdk-base

VERSION=`git --git-dir=androidsdk-tools/.git log -1 --format=%cd~%h --date=short | sed s/-//g`
echo "Version "$VERSION
echo "Deleting not needed files ..."
rm -fr `find androidsdk-tools -maxdepth 1 -type d ! -name androidsdk-tools ! -name common ! -name sdklib ! -name sdkmanager ! -name sdkstats ! -name swtmenubar ! -name ddms ! -name ddmlib ! -name hierarchyviewer2 ! -name traceview ! -name uiautomatorviewer`
rm -fr androidsdk-tools/common/src/test
rm -fr androidsdk-tools/sdklib/src/test
rm -fr androidsdk-tools/sdkstats/src/test
rm -fr androidsdk-tools/ddms/src/test
rm -fr androidsdk-tools/ddmlib/src/test
rm -fr androidsdk-tools/sdkmanager/app
rm -fr androidsdk-tools/sdkmanager/libs/sdkuilib
rm -fr androidsdk-tools/ddms/ddmuilib/src/test
rm -fr `find androidsdk-tools/sdklib/src/main/java/com/android/sdklib -maxdepth 1 ! -name sdklib ! -name build ! -name util ! -name internal`
rm -fr `find androidsdk-tools/sdklib/src/main/java/com/android/sdklib/internal -type d ! -name internal ! -name build`
rm -fr androidsdk-tools/sdklib/src/main/java/com/android/sdklib/build
rm -fr androidsdk-tools/sdklib/src/main/java/com/android/sdklib/internal/build
# rm -fr `find androidsdk-tools -name ".*"` # this might be too strict in some later versions
rm -fr androidsdk-tools/sdkmanager/.gitignore
rm -fr androidsdk-tools/sdkmanager/libs/sdklib/.settings
rm -fr androidsdk-tools/sdkmanager/libs/sdklib/.classpath
rm -fr androidsdk-tools/sdkmanager/libs/sdklib/.project
rm -fr androidsdk-tools/common/.classpath
rm -fr androidsdk-tools/common/.project
rm -fr androidsdk-tools/common/.settings
rm -fr androidsdk-tools/common/.gitignore
rm -fr androidsdk-tools/.gitignore
find androidsdk-tools -type f -name *gradle* -delete

echo "Packaging archive into ../android-sdk-tools_$REVISION+git$VERSION.orig.tar.xz ..."
tar -cJf ../androidsdk-tools_$REVISION+git$VERSION.orig.tar.xz androidsdk-tools
echo "Deleting folder 'androidsdk-tools'"
rm -Ir androidsdk-tools
