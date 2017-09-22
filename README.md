# MMLocalization

[![CI Status](http://img.shields.io/travis/Millman/MMLocalization.svg?style=flat)](https://travis-ci.org/Millman/MMLocalization)
[![Version](https://img.shields.io/cocoapods/v/MMLocalization.svg?style=flat)](http://cocoapods.org/pods/MMLocalization)
[![License](https://img.shields.io/cocoapods/l/MMLocalization.svg?style=flat)](http://cocoapods.org/pods/MMLocalization)
[![Platform](https://img.shields.io/cocoapods/p/MMLocalization.svg?style=flat)](http://cocoapods.org/pods/MMLocalization)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

It's help you to change localization string easily

![circledemo](https://github.com/MillmanY/MMLocalization/blob/master/mid.gif)

Step

1.Import your table.string file

![circledemo](https://github.com/MillmanY/MMLocalization/blob/master/string.png)

Generate your file convenience you can use

https://github.com/MillmanY/Localize-String-Help

2.Setting your string table at didFinishLaunchingWithOptions

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions:     [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MMLocalization.start()
        let scuess =  MMLocalization.loadSetting()
        if !scuess {
            MMLocalization.set(type: .custom(tableName: "ILocalizable_CH"))
        }
        return true
    }
    
3.Just setting your key on your UI

![circledemo](https://github.com/MillmanY/MMLocalization/blob/master/ui.png)

4.If you want to set up your string by program , your can use 

     "log_in".localize()       
     "log_in".localize(table:"ILocalizable_ID")

## Installation

MMLocalization is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "MMLocalization"
```

## Author

Millman, millmanyang@gmail.com

## License

MMLocalization is available under the MIT license. See the LICENSE file for more info.
