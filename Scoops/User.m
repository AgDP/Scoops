//
//  User.m
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import "User.h"

@implementation User

#pragma mark - Init
-(id) initWithIdUser: (NSString *) idUser aName: (NSString *) name aGender: (NSString *) gender aPicture: (NSString *) picture{
    
    if (self = [super init]) {
        _idUser = idUser;
        _name = name;
        _gender = gender;
        _picture = picture;
    }
    
    return self;
    
}

@end
