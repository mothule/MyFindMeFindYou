//
//  ConnectionManager.h
//  MyFindMeFindYou
//
//  Created by mothule on 13/02/17.
//  Copyright (c) 2013年 motoki.kawakami. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ConnectionManager : NSObject{
    id _delegate;
    NSMutableData* receivedData;
    NSURLConnection* connection;
}

@property (readonly) NSMutableData* receiveData;
-(id)initWithDelegate:(id) delegate;
-(NSURLConnection*) connectionRequest:(NSMutableURLRequest*) urlRequest;


@end
