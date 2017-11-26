//
//  BlazeRow.swift
//  Blaze-Swift
//
//  Created by Sebastiaan Seegers on 10-11-17.
//  Copyright © 2017 ZoinksInteractive. All rights reserved.
//

import UIKit
import Foundation

class BlazeRow: NSObject {

    enum InputAccessoryViewType: Int {
        case InputAccessoryViewDefaultArrows
        case InputAccessoryViewDefaultStrings
        case InputAccessoryViewCancelSave
    }
    
    public enum FloatingLabelEnabledState: Int {
        case FloatingLabelStateUndetermined = -1
        case FloatingLabelStateDisabled = 0
        case FloatingLabelStateEnabled = 1
    }
    
    enum ImageType: Int {
        case ImageFromURL
        case ImageFromData
        case ImageFromBundle
        case ImageFromBlazeMediaData
    }
    
    // Row primitives
    var ID: Int = 0
    var disableBundle: Bool = false
    var enableDeleting: Bool = false
    var disableEditing: Bool = false
    var rowHeightDynamic: Bool = false
    var disableFirstResponderOnCellTap: Bool = false
    
    // Row heights
    var rowHeight: Int = 0
    var rowHeightRatio: Int = 0
    var estimatedRowHeight: Int = 0
    
    // Row reference types
    var value: AnyObject?
    var xibName: String?
    var selectedBackgroundColor: UIColor?
    
    // For tapped cells - push using segue/storyboard
    var navigationTableViewStyle: UITableViewStyle?
    var navigationViewControllerClassName: String?
    var navigationTableViewControllerClassName: String?
    
    // Object & Possible property name
    var object: AnyObject?
    var propertyName: String?
    
    // Additional rows for additional fields
    var additionalRows: Array<Any>?
    
    // InputAccessoryViewType
    var inputAccessoryViewType: InputAccessoryViewType?
    
    // Constraints
    var constraintConstants: Array<NSNumber>?
    
    // Title
    var title: String?
    var titleColor: UIColor?
    var attributedTitle: NSAttributedString?
    
    // Subtitle
    var subtitle: String?
    var subtitleColor: String?
    var attributedSubtitle: NSAttributedString?
    
    // SubSubtitle
    var subsubtitle: String?
    var subsubtitleColor: String?
    var attributedSubSubtitle: NSAttributedString?
    
    // Additional labels
    var additionalTitles: Array<String>?
    
    // Buttons
    var buttonLeftTitle: String?
    var buttonCenterTitle: String?
    var buttonRightTitle: String?
    var buttonLeftTitleColor: UIColor?
    var buttonCenterTitleColor: UIColor?
    var buttonRightTitleColor: UIColor?
    var buttonLeftBackgroundColor: UIColor?
    var buttonCenterBackgroundColor: UIColor?
    var buttonRightBackgroundColor: UIColor?
    var buttonLeftAttributedTitle: NSAttributedString?
    var buttonCenterAttributedTitle: NSAttributedString?
    var buttonRightAttributedTitle: NSAttributedString?
    
    // ImageView left
    var imageDataLeft: Data?
    var imageNameLeft: String?
    var imageURLStringLeft: String?
    var imageTintColorLeft: UIColor?
    var contentModeLeft: UIViewContentMode = .scaleToFill
    var imageRenderModeLeft: UIImageRenderingMode = .automatic
    
    //ImageView center
    var imageDataCenter: Data?
    var imageNameCenter: String?
    var imageURLStringCenter: String?
    var imageTintColorCenter: UIColor?
    var contentModeCenter: UIViewContentMode = .scaleToFill
    var imageRenderModeCenter: UIImageRenderingMode = .automatic
    
    //ImageView right
    var imageDataRight: Data?
    var imageNameRight: String?
    var imageURLStringRight: String?
    var imageTintColorRight: UIColor?
    var contentModeRight: UIViewContentMode = .scaleToFill
    var imageRenderModeRight: UIImageRenderingMode = .automatic
    
    //ImageView background
    var imageDataBackground: Data?
    var imageNameBackground: String?
    var imageURLStringBackground: String?
    var imageTintColorBackground: UIColor?
    var contentModeBackground: UIViewContentMode = .scaleToFill
    var imageRenderModeBackground: UIImageRenderingMode = .automatic
    
    //Slider
    var sliderMin: Int = 0
    var sliderMax: Int = 100
    var sliderLeftText: String?
    var sliderCenterText: String?
    var sliderRightText: String?
    var sliderBackroundImageName: String?
    
    //Tiles
    var tileHeight: Int  = 0
    var tilesPerRow: Int = 0
    var tileSelectAutomatically: Bool = false
    var tileValues: Array<Any>?
    var tileCellXibName: String?
    var tilesMultipleSelection: Bool = false
    
    //Pickerview
    var pickerUseIndexValue: Bool = false
    var selectorOptions: Array<Any>?
    var pickerObjectPropertyName: String?
    
    //Pickerview - multiple columns & ranges
    var mainColumnIndex: Int = 0
    var rangesColumnIndex: Int = 0
    var selectorOptionsColumnRanges: Array<Any>?
    
    //Checkbox
    var checkboxImageActive: String?
    var checkboxImageInactive: String?
    
    //PageControl
    var currentPage: Int = 0
    var numberOfPages: Int = 1
    
    //ScrollImages
    var scrollImagesWidth: Int = 0
    var scrollImagesPadding: Int = 0
//    var imageType: scrollImageType?
    var scrollImageContentMode: UIViewContentMode = .scaleToFill
    var scollImageHidePageControlForOneImage: Bool = false
    var scrollImages: Array<UIImage>?
    
    //Date
    var minDate: Date?
    var maxDate: Date?
    var dateMinuteInterval: Int = 0
    var placeHolderDate: Date?
    var datePickerMode: UIDatePickerMode = .dateAndTime
    var dateFormatCapitalizedString: Bool = false
    var dateFormatter: DateFormatter?
    
    //TextField/TextView
    var secureTextEntry: Bool = false
    var keyboardType: UIKeyboardType = .default
    var autoCorrectionType: UITextAutocorrectionType = .default
    var placeholder: String?
    var formatter: Formatter?
    var placeholderColor: UIColor?
    var textFieldPrefix: String?
    var textFieldSuffix: String?
    var capitalizationType: NSNumber?
    var attributedPlaceholder: NSAttributedString?
    
    //Floating placeholder options
    var floatingLabelEnabled: FloatingLabelEnabledState = .FloatingLabelStateUndetermined
    var floatingTitle: String?
    var floatingTitleFont: UIFont?
    var floatingTitleColor: UIColor?
    var floatingTitleActiveColor: UIColor?
    
    //MultipleSelector
    var disableMultipleSelection: Bool = false
    var multipleSelectorTitle: String?
    var multipleSelectorValues: Array<Any>?
    var selectedIndexPaths: Array<IndexPath>?
    
    //View Colors
    var viewLeftBackgroundColor: UIColor?
    var viewCenterBackgroundColor: UIColor?
    var viewRightBackgroundColor: UIColor?
    
    //ImagePicker
    var imagePickerSourceRect: CGRect = .zero
    var imagePickerAllowsEditing: Bool = false
    var imagePickerSaveInCameraRoll: Bool = false
    var imagePickerViewController: UIViewController?

}
