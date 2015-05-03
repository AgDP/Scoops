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

-(id) initWithNews: (New *) news aClient: (MSClient *) client{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _news = news;
        _client = client;
    }
    
    return self;
    
}


-(void) viewWillAppear:(BOOL)animated{
    
    [self getValoracionWithUser:self.client];
    
    self.titletext.text = self.news.title;
    self.boxNews.text = self.news.text;
    self.valoracionGlobal.text = [NSString stringWithFormat:@"%ld", (long)self.news.valoracion];
}


-(void) getValoracionWithUser: (MSClient *) client{
    
    NSDictionary *scoop= @{ @"newsid" : self.news.idNews};
    
    [client invokeAPI:@"getvaloracionnews" body:nil HTTPMethod:@"GET" parameters:scoop headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
        
        //tenemos info extra del usuario
        NSLog(@"%@", result);
        
        NSArray *valorGlobal = [result valueForKey:@"valor"];
        
        if (![[NSString stringWithFormat:@"%@", [valorGlobal lastObject]] isEqualToString:@"<null>"]) {
            
            self.valoracionGlobal.text =[NSString stringWithFormat:@"%@", [valorGlobal lastObject]];
            
        }else{
            self.valoracionGlobal.text = @"";
        }
        
        
    }];
    
}

#pragma mark - Actions
- (IBAction)hideKeyboard:(id)sender{
    
    [self.view endEditing:YES];
}

- (IBAction)valorarNews:(id)sender{
    
    MSTable *valoracion = [self.client tableWithName:@"valoracion"];
    
    NSDictionary * scoopVal= @{@"valor" : [NSNumber numberWithInteger:[self.miValoracion.text integerValue]], @"idnews" : self.news.idNews};
    [valoracion insert:scoopVal
            completion:^(NSDictionary *item, NSError *error) {
                
                if (error) {
                    NSLog(@"Error %@", error);
                    NSLog(@"OK --- %@", item);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valoración"
                                                                    message:@"Error al valorar"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                } else {
                    NSLog(@"OK --- %@", item);
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valoración"
                                                                    message:@"Se ha valorado correctamente"
                                                                   delegate:nil
                                                          cancelButtonTitle:@"OK"
                                                          otherButtonTitles:nil];
                    [alert show];
                }
                
            }];
    
}

@end
