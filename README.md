# MHAppKit

[![Build Status](https://app.bitrise.io/app/60b260ea609dcb8d/status.svg?token=AGhinI_EbjyWbGuefsMpHg&branch=master)](https://app.bitrise.io/app/60b260ea609dcb8d)

A collection of useful tools that makes developer's life easier

## Documentation

Any documentation can be found inline in the source files.

## Installation

[Embed]:
https://developer.apple.com/library/content/technotes/tn2435/_index.html#//apple_ref/doc/uid/DTS40017543-CH1-PROJ_CONFIG-APPS_WITH_MULTIPLE_XCODE_PROJECTS

#### [Carthage](https://github.com/Carthage/Carthage)

Add `github "KoCMoHaBTa/MHAppKit"` to your `Cartfile`, then [Embed] the framework directly into your project.

#### [Cocoapods](https://cocoapods.org)

Add `pod 'MHAppKit'` to your  `Podfile`

#### [Submodules](http://git-scm.com/docs/git-submodule)

[Add a submodule](https://git-scm.com/docs/git-submodule#git-submodule-add-bltbranchgt-f--force--nameltnamegt--referenceltrepositorygt--depthltdepthgt--ltrepositorygtltpathgt) to your repostiroy, then [Embed] the framework directly into your project

#### Manually

[Download](https://github.com/KoCMoHaBTa/MHAppKit/releases), then [Embed] the framework directly into your project

## SegueCoordinator (removed) 

**SegueCoordinator** has been evolved into [MHDependencyKit](https://github.com/KoCMoHaBTa/MHDependencyKit)

## SegueCoordinator -> MHDependencyKit migration Guide

Chart with commonly used SegueCoordinator symbols and their MHDepencyKit representation

| SegueCoordinator 							| MHDepencyKit |
|:-------------------------------------:|:-------------------------------------:|
| SegueCoordinator      					| DependencyCoordinator |
| UIViewController.segueCoordinator		| UIViewController.dependencyCoordinator |
| SegueCoordinator.addContextHandler(:) 	| DependencyCoordinator.register(dependencyResolver:) + UIViewControllerContextDependencyResolver|
| SegueCoordinator.addContextHandler(:) | DependencyCoordinator.register(dependencyResolver:) + UIViewControllerDependencyResolver |
| SegueCoordinator.prepare(source:destination)| DependencyCoordinator.resolveDependencies(from:to:)|
