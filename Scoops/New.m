//
//  New.m
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import "New.h"
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@implementation New

#pragma mark - Init
- (id)initWithTitle:(NSString*)title andPhoto:(NSData *)img aText:(NSString*)text anAuthor:(NSString *)author anIdUser: (NSString *) idUser aValoracion: (NSInteger) valoracion aState: (BOOL) estado aClient: (MSClient *) client{
    
    if (self = [super init]) {
        _title = title;
        _text = text;
        _author = author;
        //_coors = coors;
        _image = img;
        _dateCreated = [NSDate date];
        _idUser = idUser;
        _valoracion = valoracion;
        _estado = estado;
        _client = client;
    }
    
    return self;
    
}

- (void)addNewToAzure{
    MSTable *news = [self.client tableWithName:@"news"];
    
    NSDictionary * scoop= @{@"titulo" : self.title, @"noticia" : self.text, @"userId" : self.idUser, @"autor" : self.author, @"valoracion" : [NSNumber numberWithInteger:self.valoracion], @"estado" : [NSNumber numberWithBool:self.estado]};
    [news insert:scoop
      completion:^(NSDictionary *item, NSError *error) {
          
          if (error) {
              NSLog(@"Error %@", error);
          } else {
              NSLog(@"OK");
          }
          
      }];
}





@end
