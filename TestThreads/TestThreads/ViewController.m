//
//  ViewController.m
//  TestThreads
//
//  Created by Denis Peyrusaubes on 11/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize resultat,activityView;


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    activityView.hidden = YES;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fin:) name:@"fin" object:nil];

	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}



-(void) fin:(NSNotification*) notif {
    NSLog(@"Notification reçue depuis le thread %@", [NSThread currentThread] );
    NSDictionary* dict = [notif userInfo];
    [self performSelectorOnMainThread:@selector(finTraitementLong:) withObject:dict waitUntilDone:NO];  
    
}



-(void) finTraitementLong:(NSDictionary*) dict {
    NSLog(@"Mise à jour de l'interface graphique depuis le thread %@", [NSThread currentThread] );
    activityView.hidden = YES;
    NSString* result = [dict objectForKey:@"resultat"];
    resultat.text = result;
    
    
}

-(IBAction)run:(id)sender {
    NSLog(@"Je démarre un traitement long dans le thread %@", [NSThread currentThread] );

    
    [activityView startAnimating];
    activityView.hidden = NO;
    
    NSOperation* traitementLong = [[TraitementLong alloc] init];
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    [queue addOperation:traitementLong];
    
    
}


@end
