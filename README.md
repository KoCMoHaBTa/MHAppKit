# MHAppKit

[![Build Status](https://app.bitrise.io/app/60b260ea609dcb8d/status.svg?token=AGhinI_EbjyWbGuefsMpHg&branch=master)](https://app.bitrise.io/app/60b260ea609dcb8d)

A collection of useful tools that makes developer's life easier

## Documentation

Any documentation can be found inline in the source files.

## Installation

[embedding]:
https://developer.apple.com/library/content/technotes/tn2435/_index.html#//apple_ref/doc/uid/DTS40017543-CH1-PROJ_CONFIG-APPS_WITH_MULTIPLE_XCODE_PROJECTS

- using [Carthage](https://github.com/Carthage/Carthage) by adding `github "KoCMoHaBTa/MHAppKit" "master"` to your `Cartfile`
- by [downloading](https://github.com/KoCMoHaBTa/MHAppKit/archive/master.zip) and [embedding] the framework directly into your project
- using [submodules](http://git-scm.com/docs/git-submodule) and [embedding] the framework directly into your project

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
