 #quick-cocos2d-x v3.6

 
## 使用指南

###新功能
- 使用Luajit2.1支持arm64
- 集成iosIAP
- CCSUILoader2完善中


###使用方法
#### 安装 
setup.py

####  创建工程 
cocos new MyGame -p com.cocoslua.mygame -l lua [-d NEW_PROJECTS_DIR]

####  编译运行
#####win
-  cocos run -p win32 

#####android
-  cocos run -p android -j 4

#####mac
-  cocos run -p mac

#####ios
-  cocos run -p ios

####  其他
-  UI编辑器使用Cocos v2.1
-  模拟器 simulator请自行编译:tools\simulator\libsimulator 
-  如果编译了模拟器，可以用命令创建 cocos new MyGame -p com.cocoslua.mygame -l lua [-d NEW_PROJECTS_DIR] --no-native 

