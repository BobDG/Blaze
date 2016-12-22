//
//  BlazeRow.h
//  Blaze
//
//  Created by Bob de Graaf on 16-04-15.
//  Copyright (c) 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, InputAccessoryViewType) {
    InputAccessoryViewDefault,
    InputAccessoryViewCancelSave,
};

typedef NS_ENUM(NSInteger, FloatingLabelEnabledState) {
    FloatingLabelStateUndetermined = -1,
    FloatingLabelStateDisabled = 0,
    FloatingLabelStateEnabled = 1,
};

@interface BlazeRow : NSObject
{
    
}

+(instancetype)rowWithTitle:(NSString *)title;
+(instancetype)rowWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier;

//Constructors with ID
-(instancetype)initWithID:(int)ID;
-(instancetype)initWithID:(int)ID title:(NSString *)title;
-(instancetype)initWithID:(int)ID xibName:(NSString *)xibName;
-(instancetype)initWithID:(int)ID title:(NSString *)title xibName:(NSString *)xibName;
-(instancetype)initWithID:(int)ID title:(NSString *)title placeholder:(NSString *)placeholder;
-(instancetype)initWithID:(int)ID title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder;
-(instancetype)initWithID:(int)ID title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder xibName:(NSString *)xibName;

//Constructors with XibName
+(instancetype)rowWithXibName:(NSString *)xibName;
+(instancetype)rowWithXibName:(NSString *)xibName title:(NSString *)title;
-(instancetype)initWithXibName:(NSString *)xibName;
-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title;
-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title segueIdentifier:(NSString *)segueIdentifier;
-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title placeholder:(NSString *)placeholder;
-(instancetype)initWithXibName:(NSString *)xibName title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder;
-(id)initWithXibName:(NSString *)xibName title:(NSString *)title value:(id)value placeholder:(NSString *)placeholder segueIdentifier:(NSString *)segueIdentifier;

//Constructors with Title
-(instancetype)initWithTitle:(NSString *)title;
-(instancetype)initWithtitle:(NSString *)title value:(id)value;
-(instancetype)initWithtitle:(NSString *)title placeholder:(NSString *)placeholder;
-(instancetype)initWithTitle:(NSString *)title segueIdentifier:(NSString *)segueIdentifier;
-(instancetype)initWithtitle:(NSString *)title value:(id)value placeholder:(NSString *)placeholder segueIdentifier:(NSString *)segueIdentifier;

//Methods
-(void)updatedValue:(id)value;
-(void)didUpdateValue:(id)value;
-(void)setAffectedObject:(id)affectedObject affectedPropertyName:(NSString *)affectedPropertyName;

//CompletionBlocks
@property(nonatomic,copy) void (^cellTapped)(void);
@property(nonatomic,copy) void (^valueChanged)(void);
@property(nonatomic,copy) void (^valueChangedWithValue)(id value);
@property(nonatomic,copy) void (^buttonLeftTapped)(void);
@property(nonatomic,copy) void (^buttonRightTapped)(void);
@property(nonatomic,copy) void (^buttonCenterTapped)(void);
@property(nonatomic,copy) void (^doneChanging)(void);
@property(nonatomic,copy) void (^configureCell)(UITableViewCell *cell);
@property(nonatomic,copy) void (^multipleSelectionFinished)(NSMutableArray *selectedIndexPaths);

//Row primitives
@property(nonatomic) int ID;
@property(nonatomic) int rowHeight;
@property(nonatomic) float rowHeightRatio;
@property(nonatomic) bool disableEditing;
@property(nonatomic) bool rowHeightDynamic;

//Row Reference types
@property(nonatomic,strong) id value;
@property(nonatomic,strong) NSString *xibName;
@property(nonatomic,strong) NSString *segueIdentifier;
@property(nonatomic,strong) NSString *storyboardID;
@property(nonatomic,strong) NSString *storyboardName;
@property(nonatomic,strong) UIColor *selectionBackgroundColor;

//Object & Possible property name
@property(nonatomic,strong) id object;
@property(nonatomic, strong) NSString *propertyName;

//InputAccessoryViewType
@property(nonatomic) InputAccessoryViewType inputAccessoryViewType;

//Title
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) UIColor *titleColor;
@property(nonatomic,strong) NSAttributedString *attributedTitle;

//Subtitle
@property(nonatomic,strong) NSString *subtitle;
@property(nonatomic,strong) UIColor *subtitleColor;
@property(nonatomic,strong) NSAttributedString *attributedSubtitle;

//SubSubtitle
@property(nonatomic,strong) NSString *subsubtitle;
@property(nonatomic,strong) UIColor *subsubtitleColor;
@property(nonatomic,strong) NSAttributedString *attributedSubSubtitle;

//Buttons
@property(nonatomic,strong) NSString *buttonLeftTitle;
@property(nonatomic,strong) NSString *buttonCenterTitle;
@property(nonatomic,strong) NSString *buttonRightTitle;
@property(nonatomic,strong) UIColor *buttonLeftTitleColor;
@property(nonatomic,strong) UIColor *buttonCenterTitleColor;
@property(nonatomic,strong) UIColor *buttonRightTitleColor;
@property(nonatomic,strong) UIColor *buttonLeftBackgroundColor;
@property(nonatomic,strong) UIColor *buttonCenterBackgroundColor;
@property(nonatomic,strong) UIColor *buttonRightBackgroundColor;
@property(nonatomic,strong) NSAttributedString *buttonLeftAttributedTitle;
@property(nonatomic,strong) NSAttributedString *buttonCenterAttributedTitle;
@property(nonatomic,strong) NSAttributedString *buttonRightAttributedTitle;

//ImageView left
@property(nonatomic,strong) NSData *imageDataLeft;
@property(nonatomic,strong) NSString *imageNameLeft;
@property(nonatomic,strong) NSString *imageURLStringLeft;
@property(nonatomic,strong) UIColor *imageTintColorLeft;
@property(nonatomic) UIViewContentMode contentModeLeft;
@property(nonatomic) UIImageRenderingMode imageRenderModeLeft;

//ImageView center
@property(nonatomic,strong) NSData *imageDataCenter;
@property(nonatomic,strong) NSString *imageNameCenter;
@property(nonatomic,strong) NSString *imageURLStringCenter;
@property(nonatomic,strong) UIColor *imageTintColorCenter;
@property(nonatomic) UIViewContentMode contentModeCenter;
@property(nonatomic) UIImageRenderingMode imageRenderModeCenter;

//ImageView right
@property(nonatomic,strong) NSData *imageDataRight;
@property(nonatomic,strong) NSString *imageNameRight;
@property(nonatomic,strong) NSString *imageURLStringRight;
@property(nonatomic,strong) UIColor *imageTintColorRight;
@property(nonatomic) UIViewContentMode contentModeRight;
@property(nonatomic) UIImageRenderingMode imageRenderModeRight;

//ImageView background
@property(nonatomic,strong) NSData *imageDataBackground;
@property(nonatomic,strong) NSString *imageNameBackground;
@property(nonatomic,strong) NSString *imageURLStringBackground;
@property(nonatomic,strong) UIColor *imageTintColorBackground;
@property(nonatomic) UIViewContentMode contentModeBackground;
@property(nonatomic) UIImageRenderingMode imageRenderModeBackground;

//Slider
@property(nonatomic) int sliderMin;
@property(nonatomic) int sliderMax;
@property(nonatomic,strong) NSString *sliderLeftText;
@property(nonatomic,strong) NSString *sliderCenterText;
@property(nonatomic,strong) NSString *sliderRightText;
@property(nonatomic,strong) NSString *sliderBackgroundImageName;

//Tiles
@property(nonatomic) int tileHeight;
@property(nonatomic) int tilesPerRow;
@property(nonatomic) bool tileSelectAutomatically;
@property(nonatomic,strong) NSArray *tilesValues;
@property(nonatomic,strong) NSString *tileCellXibName;
@property(nonatomic,assign) BOOL tilesMultipleSelection;

//Pickerview
@property(nonatomic,strong) NSArray *selectorOptions;
@property(nonatomic,strong) NSString *pickerObjectPropertyName;

//Checkbox
@property(nonatomic,strong) NSString *checkboxImageActive;
@property(nonatomic,strong) NSString *checkboxImageInactive;

//Date
@property(nonatomic,strong) NSDate *minDate;
@property(nonatomic,strong) NSDate *maxDate;
@property(nonatomic) NSUInteger dateMinuteInterval;
@property(nonatomic,strong) NSDate *placeholderDate;
@property(nonatomic) UIDatePickerMode datePickerMode;
@property(nonatomic,strong) NSDateFormatter *dateFormatter;

//TextField/TextView
@property(nonatomic) bool secureTextEntry;
@property(nonatomic) UIKeyboardType keyboardType;
@property(nonatomic) UITextAutocorrectionType autocorrectionType;
@property(nonatomic) UITextAutocapitalizationType capitalizationType;
@property(nonatomic,strong) NSString *placeholder;
@property(nonatomic,strong) NSFormatter *formatter;
@property(nonatomic,strong) NSString *placeholderText;
@property(nonatomic,strong) UIColor *placeholderColor;
@property(nonatomic,strong) NSString *textFieldSuffix;
@property(nonatomic,strong) NSAttributedString *attributedPlaceholder;

//Floating placeholder options
@property(nonatomic) FloatingLabelEnabledState floatingLabelEnabled;
@property(nonatomic,strong) NSString *floatingTitle;
@property(nonatomic,strong) UIFont *floatingTitleFont;
@property(nonatomic,strong) UIColor *floatingTitleColor;
@property(nonatomic,strong) UIColor *floatingTitleActiveColor;

//MultipleSelector
@property(nonatomic) bool disableMultipleSelection;
@property(nonatomic,strong) NSString *multipleSelectorTitle;
@property(nonatomic,strong) NSArray *multipleSelectorValues;
@property(nonatomic,strong) NSMutableArray *selectedIndexPaths;

//View Colors
@property(nonatomic,strong) UIColor *viewLeftBackgroundColor;
@property(nonatomic,strong) UIColor *viewCenterBackgroundColor;
@property(nonatomic,strong) UIColor *viewRightBackgroundColor;

//ImagePicker
@property(nonatomic) CGRect imagePickerSourceRect;
@property(nonatomic) bool imagePickerAllowsEditing;
@property(nonatomic) bool imagePickerSaveInCameraRoll;
@property(nonatomic,strong) UIViewController *imagePickerViewController;



@end











