#import "DownloadOperation.h"

@implementation DownloadOperation
@synthesize username,password;
@synthesize URLResponse;
@synthesize URLError;
@synthesize connection;
@synthesize requestData;
@synthesize connectionFinished;
@synthesize url;
@synthesize expectedSize;

-(DownloadOperation*) initWithUrl:(NSURL*) u 
{
    self=[super init];
    if (nil!=self)
    {
        self.username=@"valtech";
        self.password=@"training";
        self.url = u;
          }
    return(self);
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace 
{
	if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])    // SSL v2
        return(true);
    
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodDefault])    // userName/password
        return(true);
    
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])    // userName/password
        return(true);
    return(NO);
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge 
{
	NSURLCredential* credential;
    
	credential=nil;

    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodDefault])
        credential=[NSURLCredential credentialWithUser:self.username password:self.password persistence:NSURLCredentialPersistenceForSession];
                
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodHTTPBasic])
        credential=[NSURLCredential credentialWithUser:self.username password:self.password persistence:NSURLCredentialPersistenceForSession];
    
	if (credential!=nil)
		[challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
    
	[challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    
   // if (statusCode == 200) {
        self.expectedSize = [response expectedContentLength];
    //}
	
    self.URLResponse=response;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSLog(@"connectionDidFinishLoading");
    self.connectionFinished=YES;
    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse *)cachedResponse
{
	return(cachedResponse);
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    self.URLError=error;
    self.requestData=nil;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	if (nil==requestData)
        self.requestData=[NSMutableData data];
    [requestData appendData:data];
    float progress = ((float) [self.requestData length] / (float) self.expectedSize);
    NSNumber* n = [NSNumber numberWithFloat:progress];
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:n,@"value", nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reception" object:self userInfo:dict];

    NSLog(@"Téléchargé:%f",progress);

}



-(void)main
{
	NSRunLoop *theRL = [NSRunLoop currentRunLoop];
    NSURLRequest *request;
    NSDictionary *userInfo;
    
    request=[NSURLRequest requestWithURL:self.url];
    connectionFinished=NO;
    self.requestData=nil;
	self.connection=[NSURLConnection connectionWithRequest:request delegate:self];
    [self.connection start];
	while ((NO==connectionFinished) && [theRL runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]])
	{
	}
    if (nil!=self.requestData)
        NSLog(@"Total received %d",[requestData length]);
    

    userInfo=[NSDictionary dictionaryWithObjectsAndKeys:requestData,@"imageData",nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fin" object:self userInfo:userInfo];

    }




@end
