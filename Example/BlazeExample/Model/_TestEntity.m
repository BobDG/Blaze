// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to TestEntity.m instead.

#import "_TestEntity.h"

@implementation TestEntityID
@end

@implementation _TestEntity

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"TestEntity" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"TestEntity";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"TestEntity" inManagedObjectContext:moc_];
}

- (TestEntityID*)objectID {
	return (TestEntityID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"indexValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"index"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic date;

@dynamic index;

- (int32_t)indexValue {
	NSNumber *result = [self index];
	return [result intValue];
}

- (void)setIndexValue:(int32_t)value_ {
	[self setIndex:@(value_)];
}

- (int32_t)primitiveIndexValue {
	NSNumber *result = [self primitiveIndex];
	return [result intValue];
}

- (void)setPrimitiveIndexValue:(int32_t)value_ {
	[self setPrimitiveIndex:@(value_)];
}

@dynamic name;

@end

@implementation TestEntityAttributes 
+ (NSString *)date {
	return @"date";
}
+ (NSString *)index {
	return @"index";
}
+ (NSString *)name {
	return @"name";
}
@end

