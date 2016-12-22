//
//  BDGImagePicker.h
//
//  Created by Bob de Graaf on 05-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BDGImagePicker : NSObject
{
    
}

/*** LOCALISATIONS ***/
//  BDGImagePicker_Cancel
//  BDGImagePicker_TakePhoto
//  BDGImagePicker_ChoosePhoto

//Quick constructors
-(instancetype)initWithAllowsEditing:(BOOL)allowsEditing;
-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing;
-(instancetype)initWithAllowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll;
-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll;
-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing takePhoto:(NSString *)takePhoto choosePhoto:(NSString *)choosePhoto;
-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll takePhoto:(NSString *)takePhoto choosePhoto:(NSString *)choosePhoto;
-(instancetype)initWithTitle:(NSString *)title allowsEditing:(BOOL)allowsEditing saveInCameraRoll:(BOOL)saveInCameraRoll takePhoto:(NSString *)takePhoto choosePhoto:(NSString *)choosePhoto cancel:(NSString *)cancel;

//Optional properties
@property(nonatomic) bool video;
@property(nonatomic) bool frontCamera;
@property(nonatomic) bool allowsEditing;
@property(nonatomic) bool statusBarHidden;
@property(nonatomic) bool saveInCameraRoll;
@property(nonatomic) UIStatusBarStyle statusBarStyle;

//Optional references
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *cancel;
@property(nonatomic,strong) NSString *takePhoto;
@property(nonatomic,strong) NSString *choosePhoto;

//Completion blocks
@property(nonatomic, copy) void (^pickerDismissed)(void);
@property(nonatomic, copy) void (^imagePicked)(UIImage *image);

//Public methods
-(void)pickImageFromViewController:(UIViewController *)viewController;
-(void)pickImageFromViewController:(UIViewController *)viewController sourceRect:(CGRect)sourceRect;
-(void)pickImageFromViewController:(UIViewController *)viewController imagePicked:(void(^)(UIImage *image))imagePicked;
-(void)pickImageFromViewController:(UIViewController *)viewController sourceRect:(CGRect)sourceRect imagePicked:(void(^)(UIImage *image))imagePicked;
-(void)pickImageFromViewController:(UIViewController *)viewController imagePicked:(void(^)(UIImage *image))imagePicked pickerDismissed:(void(^)())pickerDismissed;
-(void)pickImageFromViewController:(UIViewController *)viewController sourceRect:(CGRect)sourceRect imagePicked:(void(^)(UIImage *image))imagePicked pickerDismissed:(void(^)())pickerDismissed;

@end
