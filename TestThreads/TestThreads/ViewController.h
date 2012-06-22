//
//  ViewController.h
//  TestThreads
//
//  Created by Denis Peyrusaubes on 11/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TraitementLong.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) IBOutlet UILabel* resultat;
@property (nonatomic,strong) IBOutlet UIActivityIndicatorView* activityView;

-(IBAction)run:(id)sender;

@end
