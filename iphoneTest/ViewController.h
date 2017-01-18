//
//  ViewController.h
//  iphoneTest
//
//  Created by MANSHENG XU on 1/16/17.
//  Copyright © 2017 MANSHENG XU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

- (IBAction)onBtnLoginClicked:(id)sender;
- (IBAction)onBtnQRCode:(id)sender;
- (CIImage *)createQRForString:(NSString *)qrString;
- (UIImage *)createQRForStringUIImage:(NSString *)qrString;
- (UIImage *)createNonInterpolatedUIImageFromCIImage:(CIImage *)image withScale:(CGFloat)scale;
@end

