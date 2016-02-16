# Mixpanel bindings for Xamarin (Monotouch)

[MixPanel](https://mixpanel.com/) is an advanced analytics platform for mobile & web.

This project provides bindings for using in [Xamarin](https://xamarin.com) iOS projects.

Current Mixpanel version: **2.9.4**

## How to build?

1. Clone repository.
2. Run `make` command in Terminal.
3. Use `Mixpanel.dll` from `Build/` directory.

## How to update?

1. Update `XCodeProject/mixpanel-iphone` submodule to latest **release** version.
1. Open `XCodeProject/Mixpanel/Mixpanel.xcodeproj` in xCode and remove Mixpanel folder. Then add Mixpanel folder from `XCodeProject/mixpanel-iphone` (no copy; target: Mixpanel).
1. In repo root folder run `make libMixpanel.a` to build binaries. Binaries will be in `Build/` directory.
1. Install latest [ObjectiveSharpie](https://files.xamarin.com/~abock/ObjectiveSharpie/latest), if not installed.
1. Create binings with sharpie `sharpie bind -output Mixpanel -namespace Mixpanel -sdk iphoneos9.2 [full_path_to_repo]/mixpanel-xamarin/XCodeProject/mixpanel-iphone/Mixpanel/Mixpanel.h`.
1. Copy content of `Mixpanel/ApiDefinitions.cs` to `BindingProject/ApiDefinition.cs` and make diff to ensure no `[Verify]` tags left and everything looks OK.
1. Run 'make' command in Terminal.
1. Use `Mixpanel.dll` from `Build/` directory.

**Notes:** If you use Xamarin Indie or Starter editions you should build the binding project in Xamarin Studio (command line tools are not supported).
