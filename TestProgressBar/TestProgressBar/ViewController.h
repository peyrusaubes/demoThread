//
//  ViewController.h
//  TestThreads
//
//  Created by Denis Peyrusaubes on 11/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DownloadOperation.h"

@interface ViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIProgressView* progress;
@property (nonatomic,strong) IBOutlet UIImageView* imageView;

-(IBAction)run:(id)sender;

@end
