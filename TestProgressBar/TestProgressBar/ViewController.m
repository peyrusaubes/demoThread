//
//  ViewController.m
//  TestThreads
//
//  Created by Denis Peyrusaubes on 11/01/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController
@synthesize progress,imageView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fin:) name:@"fin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(donnneesRecues:) name:@"reception" object:nil];
    
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




-(void) donnneesRecues:(NSNotification*) notif {
    NSLog(@"Notification reçue depuis le thread %@", [NSThread currentThread] );
    NSDictionary* dict = [notif userInfo];
    [self performSelectorOnMainThread:@selector(avance:) withObject:dict waitUntilDone:NO];  
    
}

-(void) avance :(NSDictionary*) dict {
    NSLog(@"Mise à jour de l'interface graphique depuis le thread %@", [NSThread currentThread] );
    NSNumber* value = [dict objectForKey:@"value"];
    NSLog(@"Téléchargé:%f",[value floatValue ]);

    [self.progress setProgress:[value floatValue ] animated:YES];
    
}





-(void) fin:(NSNotification*) notif {
    NSLog(@"Notification reçue depuis le thread %@", [NSThread currentThread] );
    NSDictionary* dict = [notif userInfo];
    [self performSelectorOnMainThread:@selector(finChargementImage:) withObject:dict waitUntilDone:NO];  
    
}


-(void) finChargementImage:(NSDictionary*) dict {
    NSLog(@"Affichage de la photo %@", [NSThread currentThread] );
    NSData* data = [dict objectForKey:@"imageData"];
    UIImage *image=[UIImage imageWithData:data];

    imageView.image = image;
}

-(IBAction)run:(id)sender {
    NSLog(@"Je démarre un traitement long dans le thread %@", [NSThread currentThread] );
    
    
    
    NSURL* url = [NSURL URLWithString: @"http://ChamorroBible.org/images/photos/gpw-20040823-UnitedStates-DefenseVisualInformationCenter-DF-ST-99-05287-farmers-caribou-apartment-houses-Great-Pyramids-Egypt-original.jpg"];

    
    NSOperation* download = [[DownloadOperation alloc] initWithUrl:url];
    
    NSOperationQueue* queue = [[NSOperationQueue alloc]init];
    [queue addOperation:download];
    
    
}


@end
