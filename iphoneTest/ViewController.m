//
//  ViewController.m
//  iphoneTest
//
//  Created by MANSHENG XU on 1/16/17.
//  Copyright © 2017 MANSHENG XU. All rights reserved.
//

#import "ViewController.h"
#import "WebServiceHandler.h"
#import "C_User.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textUserID;
@property (weak, nonatomic) IBOutlet UITextField *textUserPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *btnQRCode;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onBtnLoginClicked:(id)sender {
    NSString* userId;
    NSString* userPassword;
    NSString* applicationSerial = @"111";
   
    userId = _textUserID.text;
    userPassword = _textUserPassword.text;
    
    if(userId.length < 1 || userPassword.length < 1)
    {
        NSLog(@"error!");
        return;
    }
    
    //Login URL
    NSString *url = [NSString stringWithFormat:@"https://voteserver.azurewebsites.net/api/auth/login?userId=%@&userPwd=%@&applicationSerial=%@", userId, userPassword, applicationSerial];
    
    WebServiceHandler *handler = [[WebServiceHandler alloc] init];
    
    [handler WebServiceGet:url success:^(NSDictionary *responseDict) {
        
        if (responseDict) {
            C_User *user = [[C_User alloc] initWithDictionary:responseDict];
            NSLog(@"%@", user.UserName);
        }
        
    } failure:^(NSError *error) {
        NSLog(@"failure");
    }];
}

- (IBAction)onBtnQRCode:(id)sender{
    NSString* userId;
    userId = _textUserID.text;
    
    if(userId.length < 1)
    {
        NSLog(@"error!");
        return;
    }
    
    _imageView.image = [self createNonInterpolatedUIImageFromCIImage:[self createQRForString:userId] withScale:100];
    //_imageView.image = [self createQRForStringUIImage:userId];
}

- (CIImage *)createQRForString:(NSString *)qrString {
    NSData *stringData = [qrString dataUsingEncoding: NSUTF8StringEncoding];
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    return qrFilter.outputImage;
}


- (UIImage *)createQRForStringUIImage:(NSString *)qrString {
    
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    [qrFilter setDefaults];
    
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    
    CIImage *outputImage = [qrFilter outputImage];
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef cgImage = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *barcode = [UIImage imageWithCGImage:cgImage scale:0 orientation:UIImageOrientationUp];
    
    
    return barcode;
}

- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withScale:(CGFloat)scale
{
    // Render the CIImage into a CGImage
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:image fromRect:image.extent];
    
    // Now we'll rescale using CoreGraphics
    UIGraphicsBeginImageContext(CGSizeMake(image.extent.size.width * scale, image.extent.size.width * scale));
    CGContextRef context = UIGraphicsGetCurrentContext();
    // We don't want to interpolate (since we've got a pixel-correct image)
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    // Get the image out
    
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    scaledImage = [UIImage imageWithCGImage:[scaledImage CGImage] scale:1.0 orientation:UIImageOrientationDownMirrored];
    
    // Tidy up
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    return scaledImage;
}
@end
