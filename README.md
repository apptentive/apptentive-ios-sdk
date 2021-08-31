# ApptentiveKit

ApptentiveKit is a ground-up rewrite of the Apptentive iOS SDK in Swift. 

It currently supports UIKit-based apps on iOS and iPadOS. 

## Release Notes

The initial beta release does not support the following features:

- Message Center
- Multi-user (login/logout) support
- Dismiss All Interactions method
- Event custom and extended data

### Primary Changes from Previous SDK

- The module name has changed from `Apptentive` to `ApptentiveKit`. 
- Most existing method calls should continue to work, albeit with some deprecation warnings. 
- Events are now represented by an `Event` object, rather than a string literal. However the `Event` object conforms to `ExpressibleByStringLiteral`, so most method calls should continue to work. If not, wrap your event name in the `Event(named:)` constructor. 
- The `register` method is now a method on the shared instance rather than a static/class method. 
- The `register` now accepts an `Apptentive.AppCredentials` object rather than the (now deprecated) `ApptentiveConfiguration` object. 
- The previous styling system has been dropped in favor of properties added to UIKit classes via extensions. See the `UIKit+Apptentive.swift` file. You can remove the default Apptentive UI style overrides by setting your Apptentive instance's `theme` property to `.none`. 

Additional documentation will be forthcoming. 
