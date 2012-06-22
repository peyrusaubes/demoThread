//
//  TraitementLong.m
//  TestThreads
//
//  Created by Denis Peyrusaubes on 11/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TraitementLong.h"

@implementation TraitementLong

-(void) main {
    [NSThread sleepForTimeInterval:5];
    NSDictionary* dict = [NSDictionary dictionaryWithObjectsAndKeys:@"valeurFinale",@"resultat", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"fin" object:self userInfo:dict];


}


@end
