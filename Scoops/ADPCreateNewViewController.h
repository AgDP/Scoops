//
//  ADPCreateNewViewController.h
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface ADPCreateNewViewController : UIViewController

-(id) initWithUser: (User *) user aMSClient: (MSClient *) client;

@property (weak, nonatomic) IBOutlet UITextField *titletext;
@property (weak, nonatomic) IBOutlet UITextView *boxNews;
@property (weak, nonatomic) MSClient * client;
@property (weak, nonatomic) User *userLog;

@property (nonatomic) CGRect oldRect;
@property (weak, nonatomic) IBOutlet UIToolbar *toolBarView;

- (IBAction)displayPublicar:(id)sender;
- (IBAction)dysplayCamera:(id)sender;
- (IBAction)hideKeyboard:(id)sender;

@end
