//
//  UIScrollView+Reload.h
//  BDGReloadDataSet
//
//  Created by Bob de Graaf on 6/20/14.
//  Copyright (c) 2016 GraafICT. All rights reserved.
//

#import <objc/runtime.h>
#import "UIScrollView+Reload.h"


@interface BDGWeakObjectContainer : NSObject

@property (nonatomic, readonly, weak) id weakObject;

- (instancetype)initWithWeakObject:(id)object;

@end

static char const * const kReloadDataSetDelegate =   "reloadDataSetDelegate";

@implementation UIScrollView (Reload)

#pragma mark - Getters (Public)

-(id<BDGReloadDataSetDelegate>)reloadDataSetDelegate
{
    BDGWeakObjectContainer *container = objc_getAssociatedObject(self, kReloadDataSetDelegate);
    return container.weakObject;
}

-(void)BDG_willReload
{
    if(!self.reloadDataSetDelegate) {
        return;
    }
    if(![self.reloadDataSetDelegate respondsToSelector:@selector(dataSetWillReload:)]) {
        return;
    }
    [self.reloadDataSetDelegate dataSetWillReload:self];
}

#pragma mark - Setters (Public)

-(void)setReloadDataSetDelegate:(id<BDGReloadDataSetDelegate>)delegate
{
    if(!delegate) {
        return;
    }
    
    objc_setAssociatedObject(self, kReloadDataSetDelegate, [[BDGWeakObjectContainer alloc] initWithWeakObject:delegate], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // We add method sizzling for injecting -BDG_reloadData implementation to the native -reloadData implementation
    [self swizzleIfPossible:@selector(reloadData)];
    
    //Perhaps also add reloadSections in the future...
    
    // Exclusively for UITableView, we also inject -BDG_reloadData to -endUpdates
    if ([self isKindOfClass:[UITableView class]]) {
        [self swizzleIfPossible:@selector(endUpdates)];
    }
}

#pragma mark - Method Swizzling

static NSMutableDictionary *_impLookupTable;
static NSString *const BDGSwizzleInfoOwnerKey = @"owner";
static NSString *const BDGSwizzleInfoPointerKey = @"pointer";
static NSString *const BDGSwizzleInfoSelectorKey = @"selector";

void BDG_original_implementation(id self, SEL _cmd)
{
    // Fetch original implementation from lookup table
    Class baseClass = BDG_baseClassToSwizzleForTarget(self);
    NSString *key = BDG_implementationKey(baseClass, _cmd);
    
    NSDictionary *swizzleInfo = [_impLookupTable objectForKey:key];
    NSValue *impValue = [swizzleInfo valueForKey:BDGSwizzleInfoPointerKey];
    
    IMP impPointer = [impValue pointerValue];
    
    // We then inject the additional implementation for reloading the empty dataset
    // Doing it before calling the original implementation does update the 'isEmptyDataSetVisible' flag on time.
    [self BDG_willReload];
    
    // If found, call original implementation
    if (impPointer) {
        ((void(*)(id,SEL))impPointer)(self,_cmd);
    }
}

NSString *BDG_implementationKey(Class class, SEL selector)
{
    if (!class || !selector) {
        return nil;
    }
    
    NSString *className = NSStringFromClass([class class]);
    
    NSString *selectorName = NSStringFromSelector(selector);
    return [NSString stringWithFormat:@"%@_%@", className, selectorName];
}

Class BDG_baseClassToSwizzleForTarget(id target)
{
    if([target isKindOfClass:[UITableView class]]) {
        return [UITableView class];
    }
    else if ([target isKindOfClass:[UICollectionView class]]) {
        return [UICollectionView class];
    }
    else if ([target isKindOfClass:[UIScrollView class]]) {
        return [UIScrollView class];
    }
    return nil;
}

-(void)swizzleIfPossible:(SEL)selector
{
    // Check if the target responds to selector
    if (![self respondsToSelector:selector]) {
        return;
    }
    
    // Create the lookup table
    if (!_impLookupTable) {
        _impLookupTable = [[NSMutableDictionary alloc] initWithCapacity:3]; // 3 represent the supported base classes
    }
    
    // We make sure that setImplementation is called once per class kind, UITableView or UICollectionView.
    for (NSDictionary *info in [_impLookupTable allValues]) {
        Class class = [info objectForKey:BDGSwizzleInfoOwnerKey];
        NSString *selectorName = [info objectForKey:BDGSwizzleInfoSelectorKey];
        
        if ([selectorName isEqualToString:NSStringFromSelector(selector)]) {
            if ([self isKindOfClass:class]) {
                return;
            }
        }
    }
    
    Class baseClass = BDG_baseClassToSwizzleForTarget(self);
    NSString *key = BDG_implementationKey(baseClass, selector);
    NSValue *impValue = [[_impLookupTable objectForKey:key] valueForKey:BDGSwizzleInfoPointerKey];
    
    // If the implementation for this class already exist, skip!!
    if (impValue || !key || !baseClass) {
        return;
    }
    
    // Swizzle by injecting additional implementation
    Method method = class_getInstanceMethod(baseClass, selector);
    IMP BDG_newImplementation = method_setImplementation(method, (IMP)BDG_original_implementation);
    
    // Store the new implementation in the lookup table
    NSDictionary *swizzledInfo = @{BDGSwizzleInfoOwnerKey: baseClass,
                                   BDGSwizzleInfoSelectorKey: NSStringFromSelector(selector),
                                   BDGSwizzleInfoPointerKey: [NSValue valueWithPointer:BDG_newImplementation]};
    [_impLookupTable setObject:swizzledInfo forKey:key];
}

@end

#pragma mark - BDGWeakObjectContainer

@implementation BDGWeakObjectContainer

- (instancetype)initWithWeakObject:(id)object
{
    self = [super init];
    if (self) {
        _weakObject = object;
    }
    return self;
}

@end
