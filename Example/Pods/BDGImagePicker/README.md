BDGImagePicker
========

Great lightweight wrapper around UIImagePickerController with only a couple of lines and great completion blocks!

## Installation using CocoaPods
```
pod 'BDGImagePicker'
```

## Usage

Import
```
#import <BDGImagePicker.h>
```

Instance variable (currently creating a fix so you don't have to do this)
```
@property(nonatomic,strong) BDGImagePicker *imagePicker;
```

Use it from anywhere
```
self.imagePicker = [BDGImagePicker new];
self.imagePicker.allowsEditing = TRUE;
self.imagePicker.title = NSLocalizedString(@"Photo", @"");
[self.imagePicker setImagePicked:^(UIImage *image) {
    //Do something with the image!
}];
[self.imagePicker pickImageFromViewController:self];
```