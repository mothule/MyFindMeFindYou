//
//  PinAnnotation.h
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/14.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface PinAnnotation : NSObject<MKAnnotation>{
    CLLocationCoordinate2D coordinate;
    NSString* title;
}

@property(nonatomic) CLLocationCoordinate2D coordinate;
@property(nonatomic, retain)    NSString* title;

-(id) initWithCoordinate:(CLLocationCoordinate2D)coord title:(NSString*) aTitle;

@end
