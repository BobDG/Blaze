//
//  BlazeImageData.h
//  BlazeExample
//
//  Created by Bob de Graaf on 10-05-17.
//  Copyright © 2017 GraafICT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlazeImageData : NSObject
{
    
}

+(instancetype)imageDataWithData:(NSData *)data;
+(instancetype)imageDataWithName:(NSString *)name;
+(instancetype)imageDataWithUrlStr:(NSString *)urlStr;

@property(nonatomic,strong) NSData *data;
@property(nonatomic,strong) NSString *name;
@property(nonatomic,strong) NSString *urlStr;

@end
