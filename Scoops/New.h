//
//  New.h
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>
@import CoreLocation;

@interface New : NSObject

- (id)initWithTitle:(NSString*)title andPhoto:(NSData *)img aText:(NSString*)text anAuthor:(NSString *)author anIdUser: (NSString *) idUser aValoracion: (NSInteger) valoracion aState: (BOOL) estado aClient: (MSClient *) client;
- (void)addNewToAzure;


@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *author;
@property (nonatomic) CLLocationCoordinate2D coors;
@property (nonatomic, strong) NSData *image;
@property (nonatomic, strong) NSDate *dateCreated;
@property (nonatomic, strong) NSString *idUser;
@property (nonatomic, strong) MSClient *client;
@property (nonatomic) NSInteger valoracion;
@property (nonatomic) BOOL estado;
@property (nonatomic, weak) NSArray *news;

@end
