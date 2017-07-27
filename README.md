# CustomSubviewLabel
A UILabel subclass (written in Swift) that draws UIView subviews at the frames of substrings within the label's text.

In it's current form, the class only provides a basic example as to how NSLayoutManager can be used. It currently simply draws a red square at the calculated frames. The class should be extended to draw more customisable UIViews. 

# Preview
![alt text](https://user-images.githubusercontent.com/5374404/28672675-ab4882f2-72e0-11e7-8a2c-4cda681e466c.png)

# Documentation
The class uses Apple's [NSLayoutManager](https://developer.apple.com/documentation/uikit/nslayoutmanager) as it's main tool to calculate the frames of substrings with a UILabel.

# Use
Use as you would any other UILabel, either via Storyboard or programmatically. 

Once the label has a frame, simply call ```drawSubviews(text: String, tag: String)```

e.g
```swift
let testString = Test <tag> string <tag>.
let tag = "<tag>"
label.drawSubviews(text: testString, tag: tag)
```

Example project is provided to show basic use.

# Author
James Shaw | Twitter: [@jsh8w](https://www.twitter.com/jsh8w) | Website: [shaw-james.com](https://shaw-james.com)
