//
//  BlazeImagePickerTableViewCell.m
//  BlazeExample
//
//  Created by Bob de Graaf on 22-12-16.
//  Copyright © 2016 GraafICT. All rights reserved.
//

#import "BDGImagePicker.h"
#import "BlazeImagePickerTableViewCell.h"

@interface BlazeImagePickerTableViewCell ()
{
    
}

@property(nonatomic,strong) BDGImagePicker *imagePicker;
@property(nonatomic,weak) IBOutlet UIImageView *imagePickerImageView;

@end

@implementation BlazeImagePickerTableViewCell

-(void)updateCell
{
    if(self.row.value) {
        self.imagePickerImageView.image = [UIImage imageWithData:self.row.value];
    }
}

-(IBAction)pickImage:(id)sender
{
    if(!self.imagePicker) {
        self.imagePicker = [[BDGImagePicker alloc] initWithTitle:self.row.title allowsEditing:self.row.imagePickerAllowsEditing saveInCameraRoll:self.row.imagePickerSaveInCameraRoll];
    }
    
    CGRect sourceRect = self.row.imagePickerSourceRect;
    if(CGRectIsEmpty(sourceRect)) {
        sourceRect = self.imagePickerImageView.frame;
    }
    [self.imagePicker pickImageFromViewController:self.row.imagePickerViewController sourceRect:sourceRect imagePicked:^(UIImage *image) {
        self.imagePickerImageView.image = image;
        self.row.value = UIImagePNGRepresentation(image);
        [self.row updatedValue:self.row.value];
    }];
}

@end
