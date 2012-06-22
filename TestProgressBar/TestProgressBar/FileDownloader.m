//
//  FileDownloader.m
//  TestProgressBar
//
//  Created by Denis Peyrusaubes on 11/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileDownloader.h"

@implementation FileDownloader

-(void) main {
    
    
    NSString* url = @"http://sites.animaux.free.fr/animaux-domestiques/photos-chiens/img/images/chien%20york.jpg";
    NSURL* toto = [NSURL URLWithString:url];
    NSData *imageData = [NSData dataWithContentsOfURL:toto]; 
    
    
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:@"valeurFinale",imageData, nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fin" object:self userInfo:dict];
    
    
}

@end
