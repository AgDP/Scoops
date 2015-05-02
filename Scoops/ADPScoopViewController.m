//
//  ADPScoopViewController.m
//  Scoops
//
//  Created by Agustín on 01/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import "ADPScoopViewController.h"
#import "ADPCreateNewViewController.h"
#import "ADPNewsTableViewController.h"
#import "constantes.h"

#import <WindowsAzureMobileServices/WindowsAzureMobileServices.h>

@interface ADPScoopViewController (){
    
    MSClient * client;
    User *userLog;
    
    NSString *userFBId;
    NSString *tokenFB;
}

@end

@implementation ADPScoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // llamamos a los metodos de Azure para crear y configurar la conexion
    [self warmupMSClient];
    
    [self loginFB];
    
    self.picProfile.image = [UIImage imageNamed:@"profile.jpg"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Azure connect, setup, login etc...

-(void)warmupMSClient{
    client = [MSClient clientWithApplicationURL:[NSURL URLWithString:AZUREMOBILESERVICE_ENDPOINT]
                                 applicationKey:AZUREMOBILESERVICE_APPKEY];
    
    NSLog(@"%@", client.debugDescription);
}

#pragma mark - Facebook
- (void)loginFB {
    //login
    
    
    [self loginAppInViewController:self withCompletion:^(NSArray *results) {
        
        NSLog(@"Resultados ---> %@", results);
        
    }];
}

#pragma mark - Login

- (void)loginAppInViewController:(UIViewController *)controller withCompletion:(completeBlock)bloque{
    
    [self loadUserAuthInfo];
    
    if (client.currentUser){
        [client invokeAPI:@"getuserinfofromauthprovider" body:nil HTTPMethod:@"GET" parameters:nil headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
            
            //tenemos info extra del usuario
            NSLog(@"%@", result);
            self.profilePicture = [NSURL URLWithString:result[@"picture"][@"data"][@"url"]];
            
            NSString *picture = result[@"picture"][@"data"][@"url"];
            
            userLog = [[User alloc] initWithIdUser:result[@"id"] aName:result[@"name"] aGender:result[@"gender"] aPicture:picture];
            
        }];
        
        return;
    }
    
    [client loginWithProvider:@"facebook"
                   controller:controller
                     animated:YES
                   completion:^(MSUser *user, NSError *error) {
                       
                       if (error) {
                           NSLog(@"Error en el login : %@", error);
                           bloque(nil);
                       } else {
                           NSLog(@"user -> %@", user);
                           
                           [self saveAuthInfo];
                           [client invokeAPI:@"getuserinfofromauthprovider" body:nil HTTPMethod:@"GET" parameters:nil headers:nil completion:^(id result, NSHTTPURLResponse *response, NSError *error) {
                               
                               //tenemos info extra del usuario
                               NSLog(@"%@", result);
                               self.profilePicture = [NSURL URLWithString:result[@"picture"][@"data"][@"url"]];
                               
                               NSString *picture = result[@"picture"][@"data"][@"url"];
                               
                               userLog = [[User alloc] initWithIdUser:result[@"id"] aName:result[@"name"] aGender:result[@"gender"] aPicture:picture];
                           }];
                           
                           bloque(@[user]);
                       }
                   }];
    
}


- (BOOL)loadUserAuthInfo{
    
    
    
    userFBId = [[NSUserDefaults standardUserDefaults]objectForKey:@"userID"];
    tokenFB = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
    
    if (userFBId) {
        client.currentUser = [[MSUser alloc]initWithUserId:userFBId];
        client.currentUser.mobileServiceAuthenticationToken = [[NSUserDefaults standardUserDefaults]objectForKey:@"tokenFB"];
        
        
        
        return TRUE;
    }
    
    return FALSE;
}


- (void) saveAuthInfo{
    [[NSUserDefaults standardUserDefaults]setObject:client.currentUser.userId forKey:@"userID"];
    [[NSUserDefaults standardUserDefaults]setObject:client.currentUser.mobileServiceAuthenticationToken
                                             forKey:@"tokenFB"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
}


#pragma mark - Actions

- (IBAction)publicarNew:(id)sender {
    
    // Crear el controlador
    ADPCreateNewViewController *nVC = [[ADPCreateNewViewController alloc] initWithUser:userLog aMSClient:client];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
    
}

- (IBAction)leerNew:(id)sender {
    
    // Crear el controlador
    ADPNewsTableViewController *nVC = [[ADPNewsTableViewController alloc] initWithUser:userLog aMSClient:client];
    
    // Hacer el push
    [self.navigationController pushViewController:nVC
                                         animated:YES];
}

#pragma mark - setter

-(void)setProfilePicture:(NSURL *)profilePicture{
    
    _profilePicture = profilePicture;
    
    dispatch_queue_t queue = dispatch_queue_create("com.byjuanamn.serial", DISPATCH_QUEUE_SERIAL);
    
    dispatch_async(queue, ^{
        
        NSData *buff = [NSData dataWithContentsOfURL:profilePicture];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.picProfile.image = [UIImage imageWithData:buff];
            self.picProfile.layer.cornerRadius = self.picProfile.frame.size.width / 2;
            self.picProfile.clipsToBounds = YES;
        });
        
    });
    
}
@end
