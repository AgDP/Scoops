//
//  ADPPhotoViewController.h
//  Scoops
//
//  Created by Agustín on 02/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class New;

@interface ADPPhotoViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

-(id) initWithNews: (New *) news;

@property (weak, nonatomic) IBOutlet UIImageView *photoView;
@property (strong, nonatomic) New *news;

- (IBAction)takePicture:(id)sender;
- (IBAction)deletePhoto:(id)sender;

@end
