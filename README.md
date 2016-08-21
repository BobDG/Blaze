Blaze
========

With Blaze I develop Apps 70% faster than normal. Blaze is not a small framework for one task, it's a big framework created to develop Apps at lightning speed.  
__When should you use Blaze?__
- When you're getting annoyed with designers not taking the smaller devices into account, thus creating the need that every screen needs to be scrollable
- When you love auto-layout (not in code) and want to use it as much as you can
- When you create many Apps with different designs and you need high flexibility to support those designs
- When you have textfields and you're tired of making sure the keyboard does not overlap the textfield
- When you're sick of writing the same boilerplate code over and over

There have been multiple versions of Blaze but the final version is so awesome that I (and everyone at the company I work) use Blaze for every screen in very App and we can't imagine not using Blaze anymore. Interested in reading the long version of how and why I created Blaze and how it came to this final version? 
Read the blogpost here! (LINK) (STILL WRITING IT AT THE MOMENT.. COMING SOON!)

Extremely short version:
- The new iPhone6 and 6+ sized caused a design change to iPhone6.
- This caused the problem that 99% didn't fit on an iPhone4, thus creating the need to make every screen scrollable.
- I want to use autolayout but using scrollviews in autolayout is *dramatic*. So I had to use either collectionviews or tableviews and then use autolayout within the cells.
- UITableviewcells combined with UITableViewAutomaticDimension is awesome as long as you set your constraints right. In collectionviews unfortunately these automatic dimension calculations are still too buggy... So UITableView it is!
- I do not want to use frameworks that scroll content to avoid keyboard overlapping like TPKeyboardAvoiding or write my own versions because it's too fragile and they never work 100% correctly. So I can't use a custom UIViewController with a tableview in it. The UITableViewcontroller comes with it's own perfect-working version of scrolling content upwards so the keyboard never overlaps an inputfield. So UITableViewController it is!
- __Conclusion__ - I started using UITableViewController for every screen! (Or containerviews for screens that have an always visible button somewhere)
- This caused a great annoyance at the enormous amount of boilerplate code for every screen...
- I experimented with 'Form frameworks' that can quickly create tableviews based on objects and such. The problem with most of these frameworks are that there are no options to have custom designs at all! It used mainly code to purely change the font or something. But I have to create Apps with such difference in designs I needed the highest flexibility available. Next to that these frameworks were often not compatible with dynamic cells. For example, I needed functionality that when you flip a UISwitch in one cell, another cell was dynamically added/removed. 
- Conclusion - I created Blaze and added tons of crazy fast features - see the next section below!

## Basic Features

### First install it using CocoaPods
```
pod 'Blaze'
```

### Then what?

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

One of the coolest things of Blaze is that it automatically knows which code to use for the cells based on the Xibnames. This is because XIB's can point to any code file you want, the name of the XIB does not have to be the same as the name of the code file.
All these input-cells above have awesome completion blocks and you don't need to write any code at all like UITextField delegate stuff. More on this further on.

I also found out that I often had cells that simply had an image and nothing else. So I created a base-cell called __BlazeTableViewCell__ (which all the input cells subclass) that has many outlets that you can choose to connect. It currently supports:
- 3 UILabels (supports both normal and attributed text)
- 3 UIImageViews (supports UIImage, NSData and NSURL - for the URL it uses the awesome UIImageview category from AFNetworking)
- 3 UIViews
- 3 UIButtons
Should cover most cells right? And in case it doesn't, I've created an awesome addition that returns your UITableViewCell in a completion block so you can customize it (read on to see some code for this :)

# How to actually use it?

I recommend creating one subclass first called something like *BaseTableViewController* and then subclass this class for every screen in your App. This way if you have certain section heights you only have to set it up at one place. Also you can register all the cells you reuse in different screens in 1 place.

Then when you create your screen you can create sections and rows with a couple of lines.
```
BlazeSection *section = [[BlazeSection alloc] initWithHeaderXibName:xibName title:@"Title"];
[self addSection:section];

BlazeRow *row = [[BlazeRow alloc] initWithXibName:xibName title:@"Title"];
[section addRow:row];
```

And there it is, you just created a whole screen with a section header and one cell in it. That's all the code that you need to some easy cells. Of course there are tons of additional options for __BlazeSection__ and __BlazeRow__. The sections can have header/footer titles and xibnames and the rows have many options for all the possible celltypes, so for textfields you can set keyboardType, capitalizationType, etc. Here are some more examples (but definitely check out the example project as well!)

### Cells without input
For cells without input you should always create a XIB-file that points to the base __BlazeTableViewCell__. Then assign the labels/images correctly in interface builder and set up the row like this:
```
BlazeRow *row = [[BlazeRow alloc] initWithXibName:xibName];
row.imageNameLeft = @"PictureImageFromBundle";
row.title = @"Title for the cell";
row.subtitle = @"Subtitle";
row.imageURLRight = @"Url for the image on the right";
[section addRow:row];
```

### Cells with input/values
For cells with input you should first check if Blaze already supports the input-type. Most basic input types like UITextfield, UITextView, UISwitch etc. are already supported and created in code. So you only need to create the XIB, assign the IBOutlets and point to the right class. All supported input cells have completion blocks that return the value to you so you don't have to write any additional code. For UITextfield, you would need to point the XIB to the __BlazeTextFieldTableViewCell__ class and set it up like this:
```
BlazeRow *row = [[BlazeRow alloc] initWithXibName:xibName];
row.title = @"Title possibly above textfield";
row.value = @"Current value for the textfield";
[row setValueChanged:^{
DLog(@"New value: %@", row.value);
}];
[section addRow:row];
```
### Custom cells
It doesn't happen often but sometimes I also had to create a cell that had something in it the base-cell didn't support. Don't worry, no need to override the UITableView cellForRow datasource method. The __BlazeRow__ simply returns the cell in a completion block so you can customize all you want:
```
BlazeRow *row = [[BlazeRow alloc] initWithXibName:xibName];
[row setConfigureCell:^(UITableViewCell *cell) {
//Cast the row to your custom cell and customize all you need!        
}];
```

If you create the custom cell in code don't forget to make it a subclass of __BlazeTableViewCell__!

### Custom section headers or footers
The headers and footers actually behave in the same way as the cells. You can create any custom XIB and simply point to the base class __BlazeTableHeaderFooterView__. Then when creating the section in code you can set the headerTitle, footerTitle, headerXibname and footerXibname. Also, if you have a very custom section header that needs customization you it can also be returned in the same way as a custom cell:
```
BlazeSection *section = [[BlazeSection alloc] initWithHeaderXibname:xibName];
[section setConfigureHeaderView:^(UITableViewHeaderFooterView *headerView) {
//Cast and customize!
}];
```

## Awesome Features

After creating this framework I started to use it in every App. Of course after a while I found certain returning features. Obviously I had to add all these awesome features within the framework itself! This way even more boilerplate code is eliminated :)

### Dynamic adding/removing cells
I want my tableviews as flexible as I can so I've created many functions to quickly add/remove a cell using an animation. Instead of using indexes it's more readable when you assign ID's to rows and use these for adding/removing cells:
```
[self addRow:row afterRowID:RowID withRowAnimation:UITableViewRowAnimationLeft];
[self removeRowWithID:RowID withRowAnimation:UITableViewRowAnimationRight];
```

### Automatic value setters (great when using CoreData)
For the input cells I used to use the completion block to use the returning value to set the value of a coredata object. Then I thought, if I simply give the object and the property name to the row, it can update the object itself and this eliminates another couple of lines of code! You don't have to provide the current value (because it retrieves it from the given object & property-name) and you can remove the completion block. Only 1 line left!
```
[row setAffectedObject:object affectedPropertyName:@selector(name)];
```

### Automatic next/previous arrows for inputfields
Blaze supports many inputfields that always use the keyboard. I believe this is the most user-friendly option. So whether it's text, a date or a pickerview, you quickly select your option in the keyboard. Blaze automatically adds a InputAccessoryView to any BlazeRow input-field type and a user can use these arrows to quickly switch between fields, whether these fields are in different sections or different types (date, pickerview, etc).

!EXAMPLE IMAGE FROM URL COMING SOON!

### Draggable zoom header view
Everyone has seen those headerviews that zoom in when you drag them down. It's a very cool effect and not that difficult to set it up. It's a couple of lines though and becomes boilerplate code when used a lot. So in Blaze you can set it with 1 line of code! :)
Simply create the XIB, set your constraints right and use this line of code:
```
self.zoomTableHeaderView = [[NSBundle mainBundle] loadNibNamed:@"ZoomHeaderView" owner:nil options:nil].firstObject;
```

### Empty state
Probably everyone knows the awesome DZNEmptyDataSet cocoapod to easily implement empty states for your tableview. Well don't worry about integrating it yourself, Blaze already covered you there! So you now easily set the images, backgroundcolor, title etc. as properties on your subclass of _BlazeTableViewController_.

### Dynamic row height options
The whole idea of Blaze is to use UITableViewCells and set your constraints right so the tableview calculates the correct height automatically. 
However, if you need specific rowheights there are 3 options:
```
row.rowHeight = 30; //30 pixels high
row.rowHeightRatio = 0.3f; //30% of the total tableview's height
row.rowHeightDynamic = TRUE; //Calculates all other rowheights first and sets the remaining space to this row
```

### Many quick setters
To remain blazingly fast __Blaze__ offers tons of quick setters that you can discover by checking out the source files. For example, if you use the same XIB-file for each row in a section you can simply set the __rowsXibname__  property of _BlazeSection_. Much better than typing the same line of code for each BlazeRow. And if you use the same xibName for the whole screen simply set the __rowsXibName__ of your _BlazeTableViewController_ subclass.


## Any awesome ideas to improve Blaze?
Let me know, send pull requests, whatever you like! I use Blaze myself for every screen in every App I make and I can't see myself not using it ever again. So I'll keep updating it as much as I can to make it more awesome!