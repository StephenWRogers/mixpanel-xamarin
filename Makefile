BUILD_DIR=Build
XBUILD=/Applications/Xcode.app/Contents/Developer/usr/bin/xcodebuild
PROJECT_ROOT=XCodeProject/Mixpanel
PROJECT=$(PROJECT_ROOT)/Mixpanel.xcodeproj
TARGET=Mixpanel
XAMARIN_BUILD=/Applications/Xamarin\ Studio.app/Contents/MacOS/mdtool
BINDING_PROJECT_ROOT=BindingProject

all: Mixpanel.dll

libMixpanel-i386.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphonesimulator -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphonesimulator/lib$(TARGET).a $(BUILD_DIR)/$@
	
libMixpanel-armv7.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7 -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphoneos/lib$(TARGET).a $(BUILD_DIR)/$@

libMixpanel-armv7s.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch armv7s -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphoneos/lib$(TARGET).a $(BUILD_DIR)/$@
	
libMixpanel-arm64.a:
	$(XBUILD) -project $(PROJECT) -target $(TARGET) -sdk iphoneos -arch arm64 -configuration Release clean build
	-mv $(PROJECT_ROOT)/build/Release-iphoneos/lib$(TARGET).a $(BUILD_DIR)/$@
	
libMixpanel.a: libMixpanel-i386.a libMixpanel-armv7.a libMixpanel-armv7s.a libMixpanel-arm64.a
	lipo -create -output $(BUILD_DIR)/$@ $(addprefix $(BUILD_DIR)/,$^)
	
MPNotification.storyboardc:
	ibtool --output-format binary1 --compile $(BUILD_DIR)/$@ ./XCodeProject/mixpanel-iphone/MixPanel/MPNotification.storyboard

MPSurvey.storyboardc:
	ibtool --output-format binary1 --compile $(BUILD_DIR)/$@ ./XCodeProject/mixpanel-iphone/MixPanel/MPSurvey.storyboard

Mixpanel.dll: libMixpanel.a MPNotification.storyboardc MPSurvey.storyboardc
	-cp $(BUILD_DIR)/libMixpanel.a $(BINDING_PROJECT_ROOT)/libMixpanel.a
	-cp -r $(BUILD_DIR)/MPNotification.storyboardc $(BINDING_PROJECT_ROOT)/Resources/MPNotification.storyboardc
	-cp -r $(BUILD_DIR)/MPSurvey.storyboardc $(BINDING_PROJECT_ROOT)/Resources/MPSurvey.storyboardc
	$(XAMARIN_BUILD) -v build "--configuration:Release" $(BINDING_PROJECT_ROOT)/Mixpanel.sln
	-cp $(BINDING_PROJECT_ROOT)/bin/Release/Mixpanel.dll $(BUILD_DIR)/Mixpanel.dll

clean:
	-rm -f *.a *.dll