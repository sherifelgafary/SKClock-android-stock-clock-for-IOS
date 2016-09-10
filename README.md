# SKClock-android-stock-clock-for-IOS
Have you ever wanted a new time picker for your app instead of the IOS default time picker SKClockView is customisable time picker which resembles the stock android clock picker and it's so easy to integrate and use in your project hope you enjoy using it and contact me for any improvements needed for this module

## Requirements

- iOS 7.0+
- Xcode 7.3.1

## Installation

### Manual
- Simply add the `SKClockView` folder to your workspace.
- Create a SKClock object from the XIB file and add it to you View.



## Usage
To use the SKClockView, instantiate it as you would instantiate SKClock object. Then modify it as you like (colors, Start date, Clock background color) then call the configureClockViews function. 


### code

```swift
  		let clock = NSBundle.mainBundle().loadNibNamed("SKClock", owner: self, options: nil)[0] as? SKClock
        clock.frame = clockContainerView.bounds
        clockContainerView.addSubview(clock)
        clock.startDate = NSDate()
        clock.primaryColor = UIColor(hexCode: "#474645")!
        clock.secondryColor = UIColor(hexCode: "#d1e152")!
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.01 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue())
        {
            clock.configureClockViews()
        }

```
