# 2021-11-05 - 6.0.0-beta.4

#### Bug Fixes

- Fix a bug that caused conversation data to double every time the device was unlocked with the app in the foreground
- Fix an access to the backend object from the main queue
- Move a number of completion handlers to be called on the main queue

# 2021-10-04 - 6.0.0-beta.3

#### Bug Fixes

- Fix a memory leak when presenting interactions
- Fix the delay calculation for retrying failed network requests
- Fix warnings due to setting translatesAutoresizingMaskIntoConstraints for table view cells
- Fix spelling of apptentiveTextInput extension property on UIFont
- Fix a bug where retried request could become stuck in the event of a particular class of network error
- Work around an iOS 15 bug that led to clear navigation and tool bars

#### Improvements

- Add a toggle to disable the toolbar in Surveys
- Make the Payload Sender module use a background task to finish sending payloads on app exit
- Add ability to set an image for the survey navigation bar's title view
- Add documentation comments to remaining public methods and properties

# 2021-09-01 - 6.0.0-beta.2

#### Improvements

- Add support for iOS 11 deployment targets

# 2021-08-31 - 6.0.0-beta.1

Initial beta release of Apptentive's Swift SDK for iOS
