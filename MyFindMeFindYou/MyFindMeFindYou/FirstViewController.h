//
//  FirstViewController.h
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/14.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface FirstViewController : UIViewController<CLLocationManagerDelegate, UITextFieldDelegate>{
    CLLocationManager* locationManager;
}

@end
