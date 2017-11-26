//
//  BlazeTextField.swift
//  Blaze-Swift
//
//  Created by Sebastiaan Seegers on 17-11-17.
//  Copyright © 2017 ZoinksInteractive. All rights reserved.
//

import UIKit

class BlazeTextField: UITextField {

    /**
     Use floating title-label
     */
    @IBInspectable var useFloatingLabel: Bool = false
    
    /**
     * Read-only access to the floating label.
     */
    var floatingLabel: UILabel?
    
    /**
     * Padding to be applied to the y coordinate of the floating label upon presentation.
     * Defaults to zero.
     */
    @IBInspectable var flYPadding: Float = 0.0
    
    /**
     * Padding to be applied to the x coordinate of the floating label upon presentation.
     * Defaults to zero
     */
    var floatingLabelXPadding: Float = 0.0
    
    /**
     * Padding to be applied to the y coordinate of the placeholder.
     * Defaults to zero.
     */
    var placeholderYPadding: Float = 0.0
    
    /**
     * Font to be applied to the floating label.
     * Defaults to the first applicable of the following:
     * - the custom specified attributed placeholder font at 70% of its size
     * - the custom specified textField font at 70% of its size
     */
    var flFont: UIFont?
    
    /**
     * Text for the floating label
     */
    @IBInspectable var flText: String?
    
    /**
     * Text color to be applied to the floating label.
     * Defaults to `[UIColor grayColor]`.
     */
    @IBInspectable var flTextColor: UIColor?
    
    /**
     * Text color to be applied to the floating label while the field is a first responder.
     * Tint color is used by default if an `floatingLabelActiveTextColor` is not provided.
     */
    @IBInspectable var flActiveTextColor: UIColor?
    
    /**
     * Indicates whether the floating label's appearance should be animated regardless of first responder status.
     * By default, animation only occurs if the text field is a first responder.
    */
    var animateEvenIfNotFirstResponder: Bool = false
    
    /**
     * Duration of the animation when showing the floating label.
     * Defaults to 0.3 seconds.
     */
    var floatingLabelShowAnimationDuration: TimeInterval = 0.3
    
    /**
     * Duration of the animation when hiding the floating label.
     * Defaults to 0.3 seconds.
     */
    var floatingLabelHideAnimationDuration: TimeInterval = 0.3
    
    /**
     * Indicates whether the clearButton position is adjusted to align with the text
     * Defaults to 1.
     */
    var adjustsClearButtonRect: Bool = true
    
    /**
     * Indicates whether or not to drop the baseline when entering text. Setting to YES (not the default) means the standard greyed-out placeholder will be aligned with the entered text
     * Defaults to false (standard placeholder will be above whatever text is entered)
     */
    @IBInspectable var flAlterBaseline: Bool = false
    
    /**
     * Force floating label to be always visible
     * Defaults to false
     */
    @IBInspectable var flAlwaysShow: Bool = false
    
    /**
     * Color of the placeholder
     */
    @IBInspectable var placeholderColor: UIColor?
    
    private var isFloatingLabelFontDefault: Bool = true;
    
    convenience init () {
        self.init()
        self.floatingLabel = UILabel()
        self.floatingLabel!.alpha = 0
        self.addSubview(self.floatingLabel!)
        
        // some basic default fonts/colors
        self.flFont = defaultFloatingLabelFont()
        self.floatingLabel!.font = self.flFont!
        self.floatingLabel!.text = self.flText!
        self.setCorrentPlaceHolder(self.placeholderColor!)
    }
    
    func mergeBlazeRowWithInspectables(withRow row: BlazeRow, placeholder: String, attributedPlaceholder: NSAttributedString, PlaceholderColor placeholderColor: UIColor?, andFloatingTitle floatingTitle: String) {
        
        // Update placeholders
        if attributedPlaceholder.length > 0 {
            self.attributedPlaceholder = attributedPlaceholder
        } else if placeholder.count > 0 && placeholderColor != nil {
            self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [.foregroundColor: placeholderColor!])
        } else if placeholder.count > 0 {
            self.placeholder = placeholder
        }
        
        // Check first if it's enabled, row has preference
        // TODO check this!
//        if row.floatingLabelEnabled == FloatingLabelStateUndetermined {
//            row.floatingLabelEnabled = self.useFloatingLabel
//        } else {
//            self.useFloatingLabel = row.floatingLabelEnabled == FloatingLabelStateEnabled;
//        }
        
        if (!self.useFloatingLabel) {
            return
        }
        
        // Update font if applicable
        self.flFont = row.floatingTitleFont
        
        // Update titlecolor - row has preference
        if row.floatingTitleColor != nil {
            self.flTextColor = row.floatingTitleColor
        } else if self.flTextColor != nil {
            row.floatingTitleColor = self.flTextColor
        }
        
        //Update active titlecolor - row has preference
        if row.floatingTitleActiveColor != nil {
            self.flActiveTextColor = row.floatingTitleActiveColor;
        } else if self.flActiveTextColor != nil {
            row.floatingTitleActiveColor = self.flActiveTextColor;
        }
        
        // Update title - row has preference
        // TODO check this!
//        if floatingTitle.count > 0 {
//            self.flText = floatingTitle;
//        } else if self.flText?.count > 0 {
//            floatingTitle = self.flText!;
//        } else if self.placeholder.count > 0 {
//            self.flText = self.placeholder;
//        }
    }
    
    func mergeBlazeRowWithInspectables(row: BlazeRow) {
        self.mergeBlazeRowWithInspectables(withRow: row, placeholder: row.placeholder!, attributedPlaceholder: row.attributedPlaceholder!, PlaceholderColor: row.placeholderColor!, andFloatingTitle: row.floatingTitle!)
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.layoutSubviews()
        self.setCorrectPlaceholder(self.placeholder!)
        self.updateFloatingLabelFont()
        floatingLabel!.text = flText!
    }
    
    func defaultFloatingLabelFont() -> UIFont {
        var textFieldFont: UIFont?
        
        if textFieldFont == nil && attributedPlaceholder != nil && attributedPlaceholder!.length > 0 {
            textFieldFont = attributedPlaceholder!.attribute(.font, at: 0, effectiveRange: nil) as? UIFont
        }
        
        if textFieldFont == nil && attributedText != nil && attributedText!.length > 0 {
            textFieldFont = attributedText?.attribute(.font, at: 0, effectiveRange: nil) as? UIFont
        }
        
        if textFieldFont == nil {
            textFieldFont = font
        }
        
        return UIFont(name: textFieldFont!.fontName, size: textFieldFont!.pointSize)!
    }
    
    func updateDefaultFloatingLabelFont() {
        let derivedFont = defaultFloatingLabelFont()
        
        if isFloatingLabelFontDefault {
            flFont = derivedFont
        } else {
            // dont apply to the label, just store for future use where floatingLabelFont may be reset to nil
            flFont = derivedFont
        }
    }
    
    func labelActiveColor() -> UIColor {
        if flActiveTextColor != nil {
            return flActiveTextColor!
        } else if flTextColor != nil {
            return flTextColor!
        } else if self.responds(to: #selector(getter: tintColor)) {
            return tintColor
        }
        
        return .blue
    }
    
    func setFlFont(flFont: UIFont?) {
        if flFont != nil {
            self.flFont = flFont
        } else if self.flFont == flFont {
            return
        }
        
        floatingLabel?.font = self.flFont != nil ? self.flFont : self.defaultFloatingLabelFont()
        isFloatingLabelFontDefault = flFont != nil ? true : false
        self.invalidateIntrinsicContentSize()
    }
    
    func showFloatingLabel(animated: Bool) {
        
    }
}
