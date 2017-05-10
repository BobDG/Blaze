//
//  BlazeImageData.m
//  BlazeExample
//
//  Created by Bob de Graaf on 10-05-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import "BlazeImageData.h"

@implementation BlazeImageData

+(instancetype)imageDataWithData:(NSData *)data
{
    BlazeImageData *imageData = [BlazeImageData new];
    imageData.data = data;
    return imageData;
}

+(instancetype)imageDataWithName:(NSString *)name
{
    BlazeImageData *imageData = [BlazeImageData new];
    imageData.name = name;
    return imageData;
}

+(instancetype)imageDataWithUrlStr:(NSString *)urlStr
{
    BlazeImageData *imageData = [BlazeImageData new];
    imageData.urlStr = urlStr;
    return imageData;
}

@end
