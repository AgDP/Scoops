//
//  ADPNewsTableViewController.h
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class User;
@class New;
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface ADPNewsTableViewController : UITableViewController

-(id) initWithUser: (User *) user aMSClient: (MSClient *) client;

@property (weak, nonatomic) MSClient * client;
@property (weak, nonatomic) User *userLog;


@end
