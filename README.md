# MHAppKit

[![Build Status](https://app.bitrise.io/app/60b260ea609dcb8d/status.svg?token=AGhinI_EbjyWbGuefsMpHg&branch=master)](https://app.bitrise.io/app/60b260ea609dcb8d)

A collection of useful tools that makes developer's life easier

## Documentation

Any documentation can be found inline in the source files.

## Installation

[Embed]:
https://developer.apple.com/library/content/technotes/tn2435/_index.html#//apple_ref/doc/uid/DTS40017543-CH1-PROJ_CONFIG-APPS_WITH_MULTIPLE_XCODE_PROJECTS

#### [Swift Package Manager](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

Add `MHAppKit` to your Swift Package Dependencies.

**Limitations and issues when using Swift Package Manager**

Since SPM does not yet support bundles and resources, the following limitations are present:

- `PickerViewController.nib` is not available - do not use the convenience `init()` and `init(items:selectedItemIndex:)`, because they are relying on the missing NIB file. Use `(nibName:bundle:)` and provide your own NIB file.
- `DatePickerViewController.nib` is not available - do not use the convenience `init()`, because it relies on the missing NIB file. Use `(nibName:bundle:)` and provide your own NIB file.
- UI tests are disabled, because test host cannot be specified.
- Several tests are separated as `HostDependantTests` - they are excluded from SPM, because test host cannot be specified.

Since SPM is multi platform by nature, the source code has been updated to build for all platforms. Even that originally it was designed to work for iOS only, there are some extensions that work for other plaforms as well. However extensions and components are not guaranteed to be available for all platforms.

- target availability is market trough code using the following: 
    - `@avaialbe` attribute
    - `#if canImport()` preprocessor macro
    - `#if os()` preprocessor macro
- building the target for watchOS simjlator fails due to incompatibility with XCTest framework - it should build and run fine, when linked agains real watchOS target 

#### [Carthage](https://github.com/Carthage/Carthage)

Add `github "KoCMoHaBTa/MHAppKit"` to your `Cartfile`, then [Embed] the framework directly into your project.

#### [Cocoapods](https://cocoapods.org)

Add `pod 'MHAppKit'` to your  `Podfile`

#### [Submodules](http://git-scm.com/docs/git-submodule)

[Add a submodule](https://git-scm.com/docs/git-submodule#git-submodule-add-bltbranchgt-f--force--nameltnamegt--referenceltrepositorygt--depthltdepthgt--ltrepositorygtltpathgt) to your repostiroy, then [Embed] the framework directly into your project

#### Manually

[Download](https://github.com/KoCMoHaBTa/MHAppKit/releases), then [Embed] the framework directly into your project

