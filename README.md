# ZPPSafeObject

[![CI Status](https://img.shields.io/travis/ZPP506/ZPPSafeObject.svg?style=flat)](https://travis-ci.org/ZPP506/ZPPSafeObject)
[![Version](https://img.shields.io/cocoapods/v/ZPPSafeObject.svg?style=flat)](https://cocoapods.org/pods/ZPPSafeObject)
[![License](https://img.shields.io/cocoapods/l/ZPPSafeObject.svg?style=flat)](https://cocoapods.org/pods/ZPPSafeObject)
[![Platform](https://img.shields.io/cocoapods/p/ZPPSafeObject.svg?style=flat)](https://cocoapods.org/pods/ZPPSafeObject)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

ZPPSafeObject is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'ZPPSafeObject'
```
## App常见崩溃，方法找不到,容器越界，字典空值

* NSObject+UnrecognizedSelector
 
   dubug: 方法找不到 崩溃提示
   release: 进行容错处理
 
* 数组下标越界

示例代码：

```objc       
- (void)testArrayOutOfBounds
{
    NSArray *testArray = @[@1,@2,@3];
    
    NSNumber *num = testArray[3];
}
```

* 字典构造造与修改

示例代码：

```objc       
- (void)testDicSetNilValueCrash
{
    // 构造不可变字典时 key和value都不能为空
    NSString *nilValue = nil;
    NSString *nilKey = nil;
    NSDictionary *dic1 = @{@"key" : nilValue};
    NSDictionary *dic2 = @{nilKey : @"value"};
}

```


## Author

ZPP506, 944160330@qq.com

## License

ZPPSafeObject is available under the MIT license. See the LICENSE file for more info.
