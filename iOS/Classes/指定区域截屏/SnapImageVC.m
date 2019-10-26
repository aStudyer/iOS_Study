//
//  SnapImageVC.m
//  iOS
//
//  Created by aStudyer on 2019/10/26.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "SnapImageVC.h"
#import "UIView+Extension.h"

@interface SnapImageVC ()
@property (nonatomic, strong) IBOutlet UIView *snapView;
@end

@implementation SnapImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)snap:(UIButton *)sender{
    UIImage *snap = self.snapView.snapImage;
    if (snap){
        UIImageWriteToSavedPhotosAlbum(snap, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }else {
        [self alertWithTitle:@"截屏失败"];
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (error) {
        [self alertWithTitle:@"截屏失败"];
    }else{
        [self alertWithTitle:@"截屏成功"];
    }
}

- (void)alertWithTitle:(NSString *)title{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:nil];
    [alert addAction:confirmAction];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
