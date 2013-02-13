//
//  PinAnnotation.m
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/14.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import "PinAnnotation.h"

@implementation PinAnnotation
@synthesize coordinate;
@synthesize title;

-(id) initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString*) aTitle
{
    self = [super init];
    if(self){
        coordinate = coord;
        title = [aTitle retain];
    }
    return self;
}

-(void)dealloc{
    [title release];
    [super dealloc];
}


@end
