#!/bin/bash

odin build . -debug -build-mode:shared -target:linux_arm64 -subtarget:android -out:build/lib/arm64-v8a/libnative.so &&

cd build &&

aapt2 link -o native-unaligned.apk --manifest ../AndroidManifest.xml -I $ANDROID_LIB &&

zip -u native-unaligned.apk ./lib/arm64-v8a/libnative.so &&

zipalign -f 4 native-unaligned.apk native-aligned.apk &&

apksigner sign \
  --ks ../debug.keystore \
  --ks-pass pass:123456 \
  --out native.apk \
  native-aligned.apk &&

adb install -r -d native.apk &&
adb shell monkey -p com.example.native 1
