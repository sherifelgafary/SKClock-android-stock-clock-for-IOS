# SKClock-android-stock-clock-for-IOS

![simulator screen shot sep 11 2016 3 02 39 am](https://cloud.githubusercontent.com/assets/5552822/18414522/edab7986-77d4-11e6-8ba1-4b82dcf1294b.png)        ![simulator screen shot sep 11 2016 3 03 03 am](https://cloud.githubusercontent.com/assets/5552822/18414528/0800b29c-77d5-11e6-9cb1-ae7f5f16ac56.png)

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

you can get the selected date in the clock by invoking one of two functions :
- getSelectedDate()
 which will return an NSDate object with the selected time 

- getSelecteStringdDate()
 which will return a String object with the selected time in the hh:mm a format


