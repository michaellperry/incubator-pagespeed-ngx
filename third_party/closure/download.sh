#!/bin/bash

# Copyright 2014 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Script to assist downloading of the closure compiler from the gclient DEPS
# file. This is handled differently than the other DEPS because the compiler
# requires downloading and unzipping a jar file instead of checking out a
# svn/git repo. This avoids downloading the compiler every time gclient syncs.

# If the version of the compiler is updated, the closure library verison in DEPS
# should be updated as well.
VERSION=20160208
ZIP=compiler-$VERSION.zip
DIR=src/tools/closure
JAR=$DIR/compiler.jar

# Download and unzip the compiler if we haven't before or if it is the wrong
# verison.
if [[ ! -e $JAR || -z "$(java -jar $JAR --version | grep $VERSION)" ]]
then
  curl https://dl.google.com/closure-compiler/$ZIP --create-dirs -o $DIR/$ZIP
  unzip -o $DIR/$ZIP -d $DIR
fi
