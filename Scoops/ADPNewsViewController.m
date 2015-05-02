//
//  ADPNewsViewController.m
//  Scoops
//
//  Created by Agustín on 02/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import "ADPNewsViewController.h"
#import "New.h"

@interface ADPNewsViewController ()

@end

@implementation ADPNewsViewController

-(id) initWithNews: (New *) news{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _news = news;
    }
    
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titletext.text = self.news.title;
    self.boxNews.text = self.news.text;
    self.valoracionGlobal.text = [NSString stringWithFormat:@"%ld", (long)self.news.valoracion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)hideKeyboard:(id)sender{
    
    [self.view endEditing:YES];
}

@end
