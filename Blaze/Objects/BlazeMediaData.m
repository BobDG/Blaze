//
//  BlazeMediaData.m
//  BlazeExample
//
//  Created by Bob de Graaf on 10-05-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazeMediaData.h"

@implementation BlazeMediaData

+(instancetype)mediaDataWithData:(NSData *)data
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.data = data;
    return imageData;
}

+(instancetype)mediaDataWithName:(NSString *)name
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.name = name;
    return imageData;
}

+(instancetype)mediaDataWithImage:(UIImage *)image
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.image = image;
    return imageData;
}

+(instancetype)mediaDataWithUrlStr:(NSString *)urlStr
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.urlStr = urlStr;
    return imageData;
}

+(instancetype)mediaDataWithData:(NSData *)data mediaType:(MediaType)mediaType
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.mediaType = mediaType;
    imageData.data = data;
    return imageData;
}

+(instancetype)mediaDataWithName:(NSString *)name mediaType:(MediaType)mediaType
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.mediaType = mediaType;
    imageData.name = name;
    return imageData;
}

+(instancetype)mediaDataWithImage:(UIImage *)image mediaType:(MediaType)mediaType
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.mediaType = mediaType;
    imageData.image = image;
    return imageData;
}

+(instancetype)mediaDataWithUrlStr:(NSString *)urlStr mediaType:(MediaType)mediaType
{
    BlazeMediaData *imageData = [BlazeMediaData new];
    imageData.mediaType = mediaType;
    imageData.urlStr = urlStr;
    return imageData;
}

@end
