//
//  BlazeMediaData.h
//  BlazeExample
//
//  Created by Bob de Graaf on 10-05-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, MediaType) {
    MediaImage,
    MediaVideo,
};

@interface BlazeMediaData : NSObject
{
    
}

@property(nonatomic) MediaType mediaType;

@property(nonatomic,strong) NSData *data;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *urlStr;

+(instancetype)mediaDataWithData:(NSData *)data;
+(instancetype)mediaDataWithName:(NSString *)name;
+(instancetype)mediaDataWithUrlStr:(NSString *)urlStr;

+(instancetype)mediaDataWithData:(NSData *)data mediaType:(MediaType)mediaType;
+(instancetype)mediaDataWithName:(NSString *)name mediaType:(MediaType)mediaType;
+(instancetype)mediaDataWithUrlStr:(NSString *)urlStr mediaType:(MediaType)mediaType;

@end
