//
//  Location.h
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/14.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Location : NSObject{
    NSString* latitude;
    NSString* longitude;
    NSString* time;
    NSString* identificationCode; // ID
}

@property (nonatomic, assign) NSString* latitude;
@property (nonatomic, assign) NSString* longitude;
@property (nonatomic, assign) NSString* time;
@property (nonatomic, assign) NSString* identificationCode; // ID

@end
