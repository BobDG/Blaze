//
//  BDGImagePicker.h
//
//  Created by Bob de Graaf on 05-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import "BDGImagePicker.h"

@interface BDGImagePicker () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    
}

//Primitives
@property(nonatomic) bool takingPicture;
@property(nonatomic) bool statusBarStyleSet;

//References
@property(nonatomic) UIPopoverController *popoverController;

@end

@implementation BDGImagePicker

#pragma mark Constructors

-(instancetype)initWithAllowsEditing:(BOOL)allowsEditing
{
    return [self initWithAllowsEditing:allowsEditing saveInCameraRoll:FALSE];
}

-(instancetype)initWithAllowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll
{
    return [self initWithTitle:nil allowsEditing:allowsEditing saveInCameraRoll:saveInCameraRoll takePhoto:nil choosePhoto:nil cancel:nil];
}

-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing
{
    return [self initWithTitle:title allowsEditing:allowsEditing saveInCameraRoll:FALSE];
}

-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll
{
    return [self initWithTitle:title allowsEditing:allowsEditing saveInCameraRoll:FALSE takePhoto:nil choosePhoto:nil];
}

-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing takePhoto:(NSString *)takePhoto choosePhoto:(NSString *)choosePhoto
{
    return [self initWithTitle:title allowsEditing:allowsEditing saveInCameraRoll:FALSE takePhoto:nil choosePhoto:nil];
}

-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll takePhoto:(NSString *)takePhoto choosePhoto:(NSString *)choosePhoto
{
    return [self initWithTitle:title allowsEditing:allowsEditing saveInCameraRoll:FALSE takePhoto:nil choosePhoto:nil cancel:nil];
}

-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll takePhoto:(NSString *)takePhoto choosePhoto:(NSString *)choosePhoto cancel:(NSString *)cancel
{
    self = [super init];
    if(!self) {
        return nil;
    }
    
    self.title = title;
    self.cancel = cancel;
    self.takePhoto = takePhoto;
    self.choosePhoto = choosePhoto;
    self.allowsEditing = allowsEditing;
    self.saveInCameraRoll = saveInCameraRoll;
    
    return self;
}

#pragma mark PickImage methods

-(void)pickImageFromViewController:(UIViewController *)viewController
{
    [self pickImageFromViewController:viewController sourceRect:CGRectZero];
}

-(void)pickImageFromViewController:(UIViewController *)viewController sourceRect:(CGRect)sourceRect
{
    NSString *title = self.title.length ? self.title : @"";
    NSString *cancel = self.cancel.length ? self.cancel : NSLocalizedString(@"BDGImagePicker_Cancel", @"");
    NSString *takePhoto = self.takePhoto.length ? self.takePhoto : NSLocalizedString(@"BDGImagePicker_TakePhoto", @"");
    NSString *choosePhoto = self.choosePhoto.length ? self.choosePhoto : NSLocalizedString(@"BDGImagePicker_ChoosePhoto", @"");
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    if([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
        [alertController addAction:[UIAlertAction actionWithTitle:takePhoto style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            self.takingPicture = TRUE;
            UIImagePickerController * picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = self.allowsEditing;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            if(self.frontCamera) {
                picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            if(self.video) {
                picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
            }
            [viewController presentViewController:picker animated:TRUE completion:^{
            }];
            CFRunLoopWakeUp(CFRunLoopGetCurrent());
        }]];
    }
    [alertController addAction:[UIAlertAction actionWithTitle:choosePhoto style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.takingPicture = FALSE;
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = self.allowsEditing;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            self.popoverController = [[UIPopoverController alloc] initWithContentViewController:picker];
            [self.popoverController presentPopoverFromRect:sourceRect inView:viewController.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
        }
        else {
            [viewController presentViewController:picker animated:TRUE completion:^{
            }];
        }
        CFRunLoopWakeUp(CFRunLoopGetCurrent());
    }]];
    [alertController addAction:[UIAlertAction actionWithTitle:cancel style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        
    }]];
    if(!CGRectIsEmpty(sourceRect)) {
        alertController.popoverPresentationController.sourceView = viewController.view;
        alertController.popoverPresentationController.sourceRect = sourceRect;
    }
    [viewController presentViewController:alertController animated:TRUE completion:nil];
    CFRunLoopWakeUp(CFRunLoopGetCurrent());
}

-(void)pickImageFromViewController:(UIViewController *)viewController imagePicked:(void(^)(UIImage *image))imagePicked
{
    self.imagePicked = imagePicked;
    [self pickImageFromViewController:viewController];
}

-(void)pickImageFromViewController:(UIViewController *)viewController imagePicked:(void(^)(UIImage *image))imagePicked pickerDismissed:(void(^)())pickerDismissed
{
    self.pickerDismissed = pickerDismissed;
    [self pickImageFromViewController:viewController imagePicked:imagePicked];
}

-(void)pickImageFromViewController:(UIViewController *)viewController sourceRect:(CGRect)sourceRect imagePicked:(void(^)(UIImage *image))imagePicked
{
    self.imagePicked = imagePicked;
    [self pickImageFromViewController:viewController sourceRect:sourceRect];
}

-(void)pickImageFromViewController:(UIViewController *)viewController sourceRect:(CGRect)sourceRect imagePicked:(void(^)(UIImage *image))imagePicked pickerDismissed:(void(^)())pickerDismissed
{
    self.imagePicked = imagePicked;
    self.pickerDismissed = pickerDismissed;
    [self pickImageFromViewController:viewController sourceRect:sourceRect];
}

#pragma mark Custom Setter

-(void)setStatusBarStyle:(UIStatusBarStyle)statusBarStyle
{
    _statusBarStyle = statusBarStyle;
    
    self.statusBarStyleSet = TRUE;
}

#pragma mark UIImagePickerDelegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectedImage = nil;
    //Edited
    if(self.allowsEditing) {
        selectedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    //Original
    if(!selectedImage) {
        selectedImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    }
    
    //Completion block
    if(!self.imagePicked) {
        NSLog(@"CRASHING: You haven't set a imagePicked completion block yet....");
        //Will crash now because this is important :)
    }
    self.imagePicked(selectedImage);
    
    //Save camera roll
    if(self.takingPicture && self.saveInCameraRoll) {
        UIImageWriteToSavedPhotosAlbum(selectedImage, nil, nil, nil);
    }
    
    //Dismiss
    [picker dismissViewControllerAnimated:TRUE completion:^{
        if(self.pickerDismissed) {
            self.pickerDismissed();
        }
    }];
}

#pragma mark UINavigationController delegate methods

-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //Necessary for UIImagePickerController
    if(self.statusBarHidden) {
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
    }
    else if(self.statusBarStyleSet) {
        [[UIApplication sharedApplication] setStatusBarStyle:self.statusBarStyle];
    }
}

@end
