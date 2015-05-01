//
//  ADPScoopViewController.h
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

typedef void (^profileCompletion)(NSDictionary* profInfo);
typedef void (^completeBlock)(NSArray* results);
typedef void (^completeOnError)(NSError *error);
typedef void (^completionWithURL)(NSURL *theUrl, NSError *error);

@interface ADPScoopViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *picProfile;
@property (strong, nonatomic) NSURL *profilePicture;

- (IBAction)publicarNew:(id)sender;
- (IBAction)leerNew:(id)sender;

@end
