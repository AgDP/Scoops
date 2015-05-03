//
//  ADPNewsViewController.h
//  Scoops
//
//  Created by Agustín on 02/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New;
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface ADPNewsViewController : UIViewController

-(id) initWithNews: (New *) news aClient: (MSClient *) client;

@property (weak, nonatomic) IBOutlet UITextField *titletext;
@property (weak, nonatomic) IBOutlet UITextView *boxNews;
@property (weak, nonatomic) IBOutlet UITextField *valoracionGlobal;
@property (weak, nonatomic) IBOutlet UITextField *miValoracion;
@property (weak, nonatomic) New *news;
@property (weak, nonatomic) MSClient * client;

- (IBAction)hideKeyboard:(id)sender;
- (IBAction)valorarNews:(id)sender;

@end
