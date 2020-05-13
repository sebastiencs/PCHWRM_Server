#!/usr/bin/env bash

export PATH_TO_FX=/home/sebastien/.jdks/javafx-sdk-14.0.1/lib
export PATH=/home/sebastien/.jdks/openjdk-14.0.1/bin:$PATH
export JAVA_HOME=/home/sebastien/.jdks/openjdk-14.0.1/

javac --module-path $PATH_TO_FX --add-modules=javafx.controls,javafx.fxml --add-modules javafx.base,javafx.graphics -classpath /home/sebastien/github/PCHWRM_Server/out/production/PCHWRM:/home/sebastien/.m2/repository/eu/hansolo/Medusa/11.2/Medusa-11.2.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/src.zip:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx-swt.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx.web.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx.base.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx.fxml.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx.media.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx.swing.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx.controls.jar:/home/sebastien/.jdks/javafx-sdk-14.0.1/lib/javafx.graphics.jar -d out $(find src/PCHWRMServer/ -name "*.java")

find $PATH_TO_FX/{javafx.base.jar,javafx.graphics.jar,javafx.controls.jar} -exec unzip -nq {} -d out \;
unzip -nq /home/sebastien/.m2/repository/eu/hansolo/Medusa/11.2/Medusa-11.2.jar -d out

#uncomment for Linux:
cp $PATH_TO_FX/{libprism*.so,libjavafx*.so,libglass*.so,libdecora_sse.so} out

cp -r ./src/PCHWRMServer/assets out/PCHWRMServer/

#uncomment for Mac:
#cp $PATH_TO_FX/{libprism*.dylib,libjavafx*.dylib,libglass.dylib,libdecora_sse.dylib} out

rm out/META-INF/MANIFEST.MF out/module-info.class
mkdir -p libs
jar --create --file=libs/hellofx.jar --main-class=PCHWRMServer.Main -C out .

java --module-path=$PATH_TO_FX --add-modules javafx.controls,javafx.fxml,javafx.graphics,javafx.web -jar libs/hellofx.jar
