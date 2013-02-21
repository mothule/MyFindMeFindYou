//
//  SecondViewController.m
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/14.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import "SecondViewController.h"
#import <MapKit/MapKit.h>
#import "SBJson.h"
#import "PinAnnotation.h"
#import "ConnectionManager.h"

@interface SecondViewController ()
@property (retain, nonatomic) IBOutlet UITextField *codeTextField;
@property (retain, nonatomic) IBOutlet MKMapView *findYouMapView;

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"FindYou", @"FindYou");
        self.tabBarItem.image = [UIImage imageNamed:@"findYou"];
    }
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_codeTextField release];
    [_findYouMapView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCodeTextField:nil];
    [self setFindYouMapView:nil];
    [super viewDidUnload];
}

- (IBAction)getLocationAction:(id)sender {
    [self.codeTextField resignFirstResponder];
    
        // パラメータ付きのURLを作成
    NSString* url = CONNECTION_URL; // @"http://myfindmefindyou.appspot.com/Location.json";
    
    NSString* parameter = [NSString stringWithFormat:@"identificationCode=%@&time=%@", self.codeTextField.text, [self getCurrentDate]];
    
    NSString* urlWithParameter = [NSString stringWithFormat:@"%@?%@", url, parameter];
//    NSString* urlWithParameter = [NSString stringWithFormat:@"%@", url];
    
    //サーバーと通信(URLリクエストを作成GET)
    NSURL* serviceURL = [NSURL URLWithString:urlWithParameter];
    NSMutableURLRequest* req = [NSMutableURLRequest requestWithURL:serviceURL];
    [req setHTTPMethod:@"GET"];
    [req addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // サーバーと通信(非同期)
    ConnectionManager* connectionManager = [[ConnectionManager alloc] initWithDelegate:self];
    [connectionManager connectionRequest:req];
    
//    //サーバーと通信(同期通信)
//    NSURLResponse* resp = nil;
//    NSError* error = nil;
//    NSData* receiveData = [NSURLConnection sendSynchronousRequest:req returningResponse:&resp error:&error];
//    if(error){
//        NSLog(@"Get Request Error");
//    }else{
//        NSLog(@"receveData:%@", receiveData);
//    }
    
//    // 受信データをNSStringにする
//    NSString* receivedString = [[[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding] autorelease];
//    NSLog(@"%@", receivedString);
    
}

-(void)receiveSucceed:(ConnectionManager*) connectionManager{
    NSString* receivedString = [[[NSString alloc] initWithData:connectionManager.receivedData encoding:NSUTF8StringEncoding] autorelease];
    [connectionManager release];
    NSLog(@"データ受信 %@", receivedString);
    
    
    // JSONデータをNSDictionaryに変換
    SBJsonParser* json = [[SBJsonParser new] autorelease];
    NSError* jsonError;
    NSDictionary* receivedLocations = [json objectWithString:receivedString error:&jsonError];
    for (id location in receivedLocations) {
        NSLog(@"receivedLocation: %@", location);
    }
    
    // 地図上にピンをドロップする
    for (id location in receivedLocations) {
        NSString* latitude = [location valueForKey:@"latitude"];
        NSString* longitude = [location valueForKey:@"longitude"];
        NSString* time = [location valueForKey:@"time"];
        
        CLLocationCoordinate2D coordinate;
        if (latitude && (id)latitude != [NSNull null]) {
            double val = [latitude doubleValue];
            coordinate.latitude = val;
        }
        if (longitude && (id)longitude != [NSNull null]) {
            coordinate.longitude = [longitude doubleValue];
        }
        
        // 取得した座標を中心に地図を表示
        [self.findYouMapView setCenterCoordinate:coordinate animated:NO];
        
        // 地図の縮尺を設定(1度は111キロ)
        MKCoordinateRegion zoom = self.findYouMapView.region;
        zoom.span.latitudeDelta = 0.005;
        zoom.span.longitudeDelta = 0.005;
        [self.findYouMapView setRegion:zoom animated:YES];
        
        // Pinをドロップ
        PinAnnotation* pinAnnotation = [[[PinAnnotation alloc] initWithCoordinate:[self.findYouMapView centerCoordinate] title:time]autorelease];
        [self.findYouMapView addAnnotation:pinAnnotation];
    }
}

-(void)receiveFailed:(ConnectionManager*)connectionManager{
    NSLog(@"Error!");
    [connectionManager release];
}


-(NSString*) getCurrentDate{
    NSDateFormatter* dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    NSString* dateFormat = @"yyy/MM/dd-HH:mm:ss:SSS";
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"JST"]];
    [dateFormatter setDateFormat:dateFormat];
    NSString* date = [dateFormatter stringFromDate:[NSDate date]];
    return date;
}
     
     
     
     
     
     
     
     
     
     
     
     
     
     

@end
