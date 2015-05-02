//
//  ADPPhotoViewController.m
//  Scoops
//
//  Created by Agustín on 02/05/2015.
//  Copyright (c) 2015 Agustin. All rights reserved.
//

#import "ADPPhotoViewController.h"
#import "New.h"

@interface ADPPhotoViewController ()

@end

@implementation ADPPhotoViewController

#pragma mark - Init

-(id) initWithNews: (New *) news{
    
    if (self = [super initWithNibName:nil bundle:nil]) {
        _news = news;
    }
    
    return self;
}



#pragma mark - View Life cycle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    //Me aseguro que la vista no ocupa toda la pantalla, sino lo que queda disponible dentro del navigation
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // sincronizo modelo -> vista
    self.photoView.image = [UIImage imageWithData:self.news.image];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    // Sincronizo vista -> modelo
    self.news.image = UIImageJPEGRepresentation(self.photoView.image, 0.9);
}


#pragma mark - Actions
- (IBAction)takePicture:(id)sender {
    
    //Creamos un UIImagePickerController
    UIImagePickerController *picker = [UIImagePickerController new];
    
    //Lo configuro
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        //Uso la camara
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }else{
        
        //Tiro del carrete
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    picker.delegate = self;
    
    //Esto es como muestra la nueva vista. La animacion
    picker.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
    //Lo muestro de forma modal
    [self presentViewController:picker animated:YES completion:^{
        
        //Esto se va a ejecutar cuadno termine la animación que muestra al picker.
        
    }];
    
}

- (IBAction)deletePhoto:(id)sender {
    
    
    
    
    
    // La eliminamos del modelo
    self.news.image = nil;
    
    //Actualizamos la vista
    CGRect oldRect = self.photoView.bounds;
    
    [UIView animateWithDuration:0.7 animations:^{
        
        self.photoView.alpha = 0;
        self.photoView.bounds = CGRectZero;
        self.photoView.transform = CGAffineTransformMakeRotation(M_PI_2);
        
    } completion:^(BOOL finished) {
        // sincronizo modelo -> vista
        
        self.photoView.transform = CGAffineTransformIdentity;
        self.photoView.alpha = 1;
        self.photoView.bounds = oldRect;
        self.photoView.image = nil;
        
    }];
    

}

#pragma mark - UIImagePickerControllerDelegate
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    //OJO! pico de memoria asegurado, especialmente en dispositivos antiguos
    //sacamos la UIImage del diccionario
    UIImage *img = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //La guardo en el modelo
    self.news.image = UIImageJPEGRepresentation(img, 0.9);
    self.photoView.image = img;
    
    //Quito de encima el controlador que estamos presentando
    [self dismissViewControllerAnimated:YES completion:^{
        //Se ejecutará cuando se haya ocultado del todo
        
    }];
}

@end
