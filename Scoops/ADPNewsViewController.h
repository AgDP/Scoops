//
//  ADPNewsViewController.h
//  Scoops
//
//  Created by Agustín on 02/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New;

@interface ADPNewsViewController : UIViewController

-(id) initWithNews: (New *) news;

@property (weak, nonatomic) IBOutlet UITextField *titletext;
@property (weak, nonatomic) IBOutlet UITextView *boxNews;
@property (weak, nonatomic) New *news;

@end
