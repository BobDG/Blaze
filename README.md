Blaze
========

This framework is the mother of all tableviewcontroller frameworks, created by a need to:
1. Easily create scrollable screens so it always fits on the smallest device sizes (yes you iPhone4)
2. Still being able to use Auto-layout
3. Still have the automatic keyboard-non-overlap UITableViewController offers

Interested in reading the long version of how and why I created Blaze?
Read the blogpost here! (LINK) (STILL WRITING IT AT THE MOMENT.. COMING SOON!)

The short version:
-> The new iPhone6 and 6+ sized caused a design change to iPhone6.
-> This caused the problem that 99% didn't fit on an iPhone4.
-> Thus creating the need to make every screen scrollable.
-> I want to use autolayout but using scrollviews in autolayout is dramatic...
-> I love auto-layout combined with uitableviewcells using UITableViewAutomaticDimension. In collectionviews it's still too buggy...
-> I do not want to use frameworks like TPKeyboardAvoiding or write my own versions because it's too fragile and never works 100% correctly. The UITableViewcontroller comes with it's own perfect-working version of scrolling content upwards so the keyboard never overlaps an inputfield.
-> Conclusion - I started using UITableViewController for every screen! (Or containerviews for screens that have an always visible button somewhere)
-> This caused a great annoyance at the enormous amount of boilerplate code for every screen...
-> I looked for frameworks like 'Form frameworks' that can quickly create tableviews based on object and such. The problem with most of these frameworks work 2-fold:
1. There were no options to have custom designs at all! It used mainly code to purely change the font or something. But I have to create Apps with such difference in designs I needed the highest flexibility available.
2. The frameworks were not compatible with dynamic cells. For example, I needed functionality that when you flip a UISwitch in one cell, another cell was dynamically added/removed. 
-> Conclusion - I created Blaze and added tons of crazy fast features - see the next section below!

## Basic Features

You use Blaze by creating a subclass of __BlazeTableViewController__. The fundamentals of Blaze are based on the idea that you can create multiple XIB's that point to the same code. (Yes that's possible and awesome :)
Since I create Apps that have many input fields I created many base-cells that you can point your XIB-file to. Like I said above, I set it up like this so you can have any crazy design you want but you still don't need to edit any code. So you can just create XIB-files and mess with auto-layout, which is fun to do right?
So I created base-code cells for:
- UITextField input
- UITextView input (yes with automatically increasing rowheight when typing a lot)
- UISwitch input
- UISlider input
- UIDate input (within the keyboard using inputView)
- UIPickerview input (within the keyboard using inputView)
- UISegmentedControl input
- Checkbox input (kind of a checkmark cell)
- Two options input (for example to choose gender - male/female)
- Etc. the list is growing as I type :)

But I also found out that I often had cells that simply had an image and nothing else. So I created a base-cell called __BlazeTableViewCell__ that has many outlets that you can choose to connect. It currently supports 3 UILabels, 3 UIImageViews, 3 UIViews and 3 UIButtons. Should cover most cells right? And in case it doesn't, I've created an awesome addition that returns your UITableViewCell in a completion block so you can customize it (read on to see some code for this :)





## Awesome Features



## Installation using CocoaPods
```
pod 'Blaze'
```

## Usage

It's best to check out the example project.