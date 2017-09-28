#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "NSDate+Helper.h"
#import "NSDateFormatter+Helper.h"
#import "NSManagedObject+Mapping.h"
#import "NSNotificationCenter+UniqueObserver.h"
#import "NSNumberFormatter+Helper.h"
#import "NSObject+Helper.h"
#import "UIImage+Helper.h"
#import "UIView+RoundedCorners.h"

FOUNDATION_EXPORT double BDGCategoriesVersionNumber;
FOUNDATION_EXPORT const unsigned char BDGCategoriesVersionString[];

