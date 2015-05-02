//
//  ADPCreateNewViewController.m
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import "ADPCreateNewViewController.h"
#import "ADPPhotoViewController.h"
#import "New.h"
#import "User.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface ADPCreateNewViewController ()

@end

@implementation ADPCreateNewViewController

#pragma mark - Init

-(id) initWithUser: (User *) user aMSClient: (MSClient *) client{

    
    if (self = [super init]) {
        _userLog = user;
        _client = client;
        _news = [New new];
    }
    
    return self;
}


-(void) viewWillAppear:(BOOL)animated{
    [super viewDidLoad];
    
    
    self.photoView.image = [UIImage imageWithData:self.news.image];
    
    [self setupKeyboardNotifications];
}



- (IBAction)displayPublicar:(id)sender {
    
    self.news.title = self.titletext.text;
    self.news.image = self.news.image,
    self.news.text = self.boxNews.text;
    self.news.author = self.userLog.name;
    self.news.idUser = self.userLog.idUser;
    self.news.valoracion = 0;
    self.news.estado = false;
    self.news.client = self.client;
    
    [self.news addNewToAzure];
    
    
}

- (IBAction)dysplayCamera:(id)sender {
    
    self.news.title = self.titletext.text;
    self.news.image = self.news.image,
    self.news.text = self.boxNews.text;
    self.news.author = self.userLog.name;
    self.news.idUser = self.userLog.idUser;
    self.news.valoracion = 0;
    self.news.estado = false;
    self.news.client = self.client;
    
    //Creamos un book
    ADPPhotoViewController *nVC = [[ADPPhotoViewController alloc] initWithNews:self.news];
    
    //Hago un push
    [self.navigationController pushViewController:nVC animated:YES];
    
    self.photoView.image = [UIImage imageWithData:self.news.image];
}



#pragma mark - keyboard

- (void)setupKeyboardNotifications{
    
    // Alta en notificaciones
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyKeyboardWillAppear:)
               name:UIKeyboardWillShowNotification
             object:nil];
    
    [nc addObserver:self
           selector:@selector(notifyKeyboardWillDisappear:)
               name:UIKeyboardWillHideNotification
             object:nil];
    
}

//UIKeyboardWillShowNotification
-(void)notifyKeyboardWillAppear: (NSNotification *) notification{
    
    // Obtener el frame del teclado
    NSDictionary *info = notification.userInfo;
    NSValue *keyFrameValue = [info objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyFrame = [keyFrameValue CGRectValue];
    
    
    // La duración de la animación del teclado
    double duration = [[info objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // Nuevo CGRect
    self.oldRect = self.boxNews.frame;
    CGRect newRect = CGRectMake(self.oldRect.origin.x,
                                self.oldRect.origin.y,
                                self.oldRect.size.width,
                                self.oldRect.size.height - keyFrame.size.height + self.toolBarView.frame.size.height - 10);
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         self.boxNews.frame = newRect;
                     } completion:^(BOOL finished) {
                         //
                     }];
    
}

// UIKeyboardWillHideNotification
-(void)notifyKeyboardWillDisappear: (NSNotification *) notification{
    
    double duration = [[notification.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    [UIView animateWithDuration:duration
                          delay:0
                        options:0
                     animations:^{
                         self.boxNews.frame = self.oldRect;
                     } completion:^(BOOL finished) {
                         //
                     }];
}


- (IBAction)hideKeyboard:(id)sender{
    
    [self.view endEditing:YES];
}
@end
