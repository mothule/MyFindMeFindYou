//
//  ConnectionManager.m
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/17.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import "ConnectionManager.h"

@implementation ConnectionManager
@synthesize receivedData;

-(id) initWithDelegate:(id)delegate{
    self = [super init];
    if(self){
        _delegate = delegate;
    }
    return self;
}

-(void)dealloc{
    [connection release];
    [receivedData release];
    [super dealloc];
}

// 通信開始
-(NSURLConnection*) connectionRequest:(NSMutableURLRequest*) urlRequest
{
    // 受信データを初期化
    receivedData = [[NSMutableData alloc] initWithLength:0];
    
    // 通信先と接続
    connection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    return connection;
}


- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    [receivedData setLength:0];
}

-(void)connection:(NSURLConnection*)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
    NSLog(@"Did receive datas. receiveData:%@", data);
}

-(void)connectionDidFinishLoading:(NSURLConnection*) connection{
    [_delegate performSelector:@selector(receiveSucceed:) withObject:self];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [_delegate performSelector:@selector(receiveFailed:) withObject:self];
    NSLog(@"Did fail with error Error:%@", error.userInfo);
}


@end
