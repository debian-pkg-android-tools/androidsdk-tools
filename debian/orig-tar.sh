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

REVISION=21.1

git clone -b tools_r$REVISION https://android.googlesource.com/platform/sdk androidsdk-tools
VERSION=`git --git-dir=androidsdk-tools/.git log -1 --format=%cd~%h --date=short | sed s/-//g`
echo "Version "$VERSION
echo "Deleting not needed files ..."
rm -fr `find androidsdk-tools -maxdepth 1 -type d ! -name androidsdk-tools ! -name common ! -name sdkmanager ! -name sdkstats ! -name swtmenubar ! -name ddms ! -name hierarchyviewer2 ! -name traceview ! -name uiautomatorviewer`
rm -fr androidsdk-tools/common/src/test
rm -fr androidsdk-tools/sdkmanager/libs/sdklib/src/test
rm -fr androidsdk-tools/sdkmanager/app
rm -fr androidsdk-tools/sdkmanager/libs/sdkuilib
rm -fr androidsdk-tools/ddms/libs/ddmlib/src/test androidsdk-tools/ddms/libs/ddmuilib/tests
rm -fr `find androidsdk-tools/sdkmanager/libs/sdklib/src/main/java/com/android/sdklib -maxdepth 1 ! -name sdklib ! -name build ! -name util ! -name internal ! -name SdkConstants.java ! -name ISdkLog.java`
rm -fr `find androidsdk-tools/sdkmanager/libs/sdklib/src/main/java/com/android/sdklib/internal -type d ! -name internal ! -name build`
rm -fr androidsdk-tools/sdkmanager/libs/sdklib/src/main/java/com/android/sdklib/internal/build/MakeIdentity.java
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

echo "Packaging archive into ../android-sdk-tools_$REVISION+git$VERSION.orig.tar.gz ..."
tar -czf ../androidsdk-tools_$REVISION+git$VERSION.orig.tar.gz androidsdk-tools
echo "Deleting folder 'androidsdk-tools'"
rm -Ir androidsdk-tools
