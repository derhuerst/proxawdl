#!/bin/bash
set -x
set -e

project_dir=$(pwd)
build_dir=$project_dir'/build/proxawdl.build'

export DEVELOPER_DIR='/Library/Developer/CommandLineTools'
export SDKROOT=$DEVELOPER_DIR'/SDKs/MacOSX.sdk'

mkdir -p $build_dir/Release/proxawdl.build/Objects-normal/x86_64

swift -frontend -c $project_dir/proxawdl/main.swift -emit-module-path $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl.swiftmodule -emit-objc-header-path $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl-Swift.h -emit-dependencies-path $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl-master.d -target x86_64-apple-macos10.12 -enable-objc-interop -sdk $SDKROOT -I $project_dir/build/Release -F $project_dir/build/Release -g -swift-version 4 -enforce-exclusivity=checked -O -serialize-debugging-options -Xcc -working-directory -Xcc $project_dir -Xcc -iquote -Xcc -iquote -Xcc -I$project_dir/build/Release/include -Xcc -I$build_dir/Release/proxawdl.build/DerivedSources-normal/x86_64 -Xcc -I$build_dir/Release/proxawdl.build/DerivedSources/x86_64 -Xcc -I$build_dir/Release/proxawdl.build/DerivedSources -import-objc-header $project_dir/proxawdl/proxawdl-Bridging-Header.h -pch-output-dir $project_dir/build/SharedPrecompiledHeaders -module-name proxawdl -o $build_dir/Release/proxawdl.build/Objects-normal/x86_64/main.o

/usr/bin/ditto -rsrc $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl-Swift.h $build_dir/Release/proxawdl.build/DerivedSources/proxawdl-Swift.h
/usr/bin/ditto -rsrc $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl.swiftmodule $project_dir/build/Release/proxawdl.swiftmodule/x86_64-apple-macos.swiftmodule
/usr/bin/ditto -rsrc $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl.swiftmodule $project_dir/build/Release/proxawdl.swiftmodule/x86_64.swiftmodule

export LANG=en_US.US-ASCII
clang -x objective-c -target x86_64-apple-macos10.12 -fmessage-length=0 -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit=0 -std=gnu11 -fobjc-arc -fmodules -gmodules -Werror=non-modular-include-in-framework-module -Wno-trigraphs -fpascal-strings -Os -fno-common -isysroot $SDKROOT -fasm-blocks -fstrict-aliasing -I$project_dir/build/Release/include -I$build_dir/Release/proxawdl.build/DerivedSources-normal/x86_64 -I$build_dir/Release/proxawdl.build/DerivedSources/x86_64 -I$build_dir/Release/proxawdl.build/DerivedSources -F$project_dir/build/Release -MMD -MT dependencies -MF $build_dir/Release/proxawdl.build/Objects-normal/x86_64/GCDAsyncUdpSocket.d -c $project_dir/proxawdl/GCDAsyncUdpSocket.m -o $build_dir/Release/proxawdl.build/Objects-normal/x86_64/GCDAsyncUdpSocket.o

export LANG=en_US.US-ASCII
clang -x objective-c -target x86_64-apple-macos10.12 -fmessage-length=0 -fdiagnostics-show-note-include-stack -fmacro-backtrace-limit=0 -std=gnu11 -fobjc-arc -fmodules -gmodules -Werror=non-modular-include-in-framework-module -Wno-trigraphs -fpascal-strings -Os -fno-common -isysroot $SDKROOT -fasm-blocks -fstrict-aliasing -I$project_dir/build/Release/include -I$build_dir/Release/proxawdl.build/DerivedSources-normal/x86_64 -I$build_dir/Release/proxawdl.build/DerivedSources/x86_64 -I$build_dir/Release/proxawdl.build/DerivedSources -F$project_dir/build/Release -MMD -MT dependencies -MF $build_dir/Release/proxawdl.build/Objects-normal/x86_64/GCDAsyncSocket.d -c $project_dir/proxawdl/GCDAsyncSocket.m -o $build_dir/Release/proxawdl.build/Objects-normal/x86_64/GCDAsyncSocket.o

ls $build_dir/Release/proxawdl.build/Objects-normal/x86_64/*.o >$build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl.LinkFileList


clang -target x86_64-apple-macos10.12 -isysroot $SDKROOT -L$project_dir/build/Release -F$project_dir/build/Release -filelist $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl.LinkFileList -Xlinker -rpath -Xlinker /usr/lib/swift -Xlinker -rpath -Xlinker @executable_path/../Frameworks -Xlinker -rpath -Xlinker @loader_path/../Frameworks -Xlinker -object_path_lto -Xlinker $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl_lto.o -fobjc-arc -fobjc-link-runtime -L$DEVELOPER_DIR/usr/lib/swift/macosx -L/usr/lib/swift -Xlinker -add_ast_path -Xlinker $build_dir/Release/proxawdl.build/Objects-normal/x86_64/proxawdl.swiftmodule -o $project_dir/build/Release/proxawdl

# dsymutil $project_dir/build/Release/proxawdl -o $project_dir/build/Release/proxawdl.dSYM
