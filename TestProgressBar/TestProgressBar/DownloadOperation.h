//
//  DownloadOperation.h
//  downloadImage
//
//  Created by DLTA Studio on 13/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownloadOperation : NSOperation
@property (nonatomic,strong) NSURL* url;
@property (nonatomic,strong) NSString* username;
@property (nonatomic,strong) NSString* password;
@property (nonatomic,strong) NSURLResponse* URLResponse;
@property(nonatomic,strong) NSError* URLError;
@property(nonatomic,strong) NSURLConnection* connection;
@property(nonatomic,strong) NSMutableData* requestData;
@property(nonatomic,assign)  BOOL connectionFinished;
@property(nonatomic,assign) int expectedSize;

-(DownloadOperation*) initWithUrl:(NSURL*) url ;

@end
