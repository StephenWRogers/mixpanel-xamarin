# Mixpanel bindings for Xamarin (Monotouch)

[MixPanel](https://mixpanel.com/) is an advanced analytics platform for mobile & web.

This project provides bindings for using in [Xamarin](https://xamarin.com) iOS projects.

Current Mixpanel version: **2.8.3**

## How to build?

1. Clone repository.
2. Run `make` command in Terminal.
3. Use `Mixpanel.dll` from `Build/` directory.

## How to update?

1. Clone repository
1. In terminal cd to repo 
1. In Terminal run `git submodule update --init`, this must pull `XCodeProject/mixpanel-iphone` repo
1. Open `XCodeProject/Mixpanel/Mixpanel.xcodeproj` in XCode and remove all Mixpanel source file references and add it again to ensure every source file is in place
1. In repo root folder run `make libMixpanel.a` to build binaries. Binaries will be in `Build/` directory
1. Install sharpie if not installed https://files.xamarin.com/~abock/ObjectiveSharpie/latest
1. Create binings with sharpie `sharpie bind -output Mixpanel -namespace Mixpanel -sdk iphoneos8.4 [full_path_to_repo]/mixpanel-xamarin/XCodeProject/mixpanel-iphone/Mixpanel/Mixpanel.h`
1. Copy content of `Mixpanel/ApiDefinitions.cs` to `BindingProject/ApiDefinition.cs` and make diff to ensure no `[Verify]` tags left and everything looks OK
1. Run 'make' command in Terminal
1. Use `Mixpanel.dll` from `Build/` directory.

**Notes:** If you use Xamarin Indie or Starter editions you should build the binding project in Xamarin Studio (command line tools are not supported).
