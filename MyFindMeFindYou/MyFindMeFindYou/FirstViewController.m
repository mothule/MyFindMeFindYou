//
//  FirstViewController.m
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/14.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import "FirstViewController.h"
#import <MapKit/MapKit.h>

#import "PinAnnotation.h"
#import "Location.h"

@interface FirstViewController ()
@property (retain, nonatomic) IBOutlet UITextField *codeTextField;
@property (retain, nonatomic) IBOutlet UIButton *logStartButton;
@property (retain, nonatomic) IBOutlet MKMapView *findMeMapView;

@end

@implementation FirstViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)dealloc {
    [_codeTextField release];
    [_logStartButton release];
    [_findMeMapView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCodeTextField:nil];
    [self setLogStartButton:nil];
    [self setFindMeMapView:nil];
    [super viewDidUnload];
}

- (IBAction)logButtonAction:(id)sender {
    if (locationManager==nil) {
        locationManager = [[CLLocationManager alloc] init];
    }
    
    locationManager.delegate = self;
    [locationManager startUpdatingLocation]; //位置情報取得の開始.
}

-(NSString*)currentDateString{
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    
    NSString* dateFormat = @"yyyy/MM/dd-HH:mm:ss:SSS";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    [dateFormatter setDateFormat:dateFormat];
    NSString* date = [dateFormatter stringFromDate:[NSDate date]];
    
    return date;
}

-(void)locationManager:(CLLocationManager*)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    // 取得した緯度経度を地図の中心に設定
    [self.findMeMapView setCenterCoordinate:newLocation.coordinate animated:NO];
    
    // 地図の縮尺を設定 1度は111キロ
    MKCoordinateRegion zoom = self.findMeMapView.region;
    zoom.span.latitudeDelta = 0.005;
    zoom.span.longitudeDelta = 0.005;
    
    [self.findMeMapView setRegion:zoom animated:YES];
    
    // 位置情報の記録
    Location* myLocation = [[[Location alloc] init] autorelease];
    myLocation.latitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.latitude];
    myLocation.longitude = [NSString stringWithFormat:@"%f", newLocation.coordinate.longitude];
    myLocation.time = [self currentDateString];
    myLocation.identificationCode = [self.codeTextField text];
    
    
    // pin
    PinAnnotation* pinAnnotation = [[[PinAnnotation alloc] initWithCoordinate:[self.findMeMapView centerCoordinate] title:[self currentDateString]] autorelease];
    
    [self.findMeMapView addAnnotation:pinAnnotation];
}

-(void)locationManager:(CLLocationManager*)manager didFailWithError:(NSError *)error
{
    
}

@end
