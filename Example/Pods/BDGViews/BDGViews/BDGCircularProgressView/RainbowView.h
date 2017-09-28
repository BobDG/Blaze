//
//  RainbowView.h
//
//  Created by Bob de Graaf on 27-11-15.
//  Copyright © 2015 GraafICT. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RainbowView : UIView
{
    
}

-(instancetype)initWithFrame:(CGRect)frame colors:(NSArray<UIColor*>*)colors locations:(NSArray<NSNumber*>*)locations;

@end
