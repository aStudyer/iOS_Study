//
//  UIView+Extension.m
//  iOS
//
//  Created by aStudyer on 2019/10/26.
//  Copyright © 2019 com.aStudyer. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)
- (UIImage *)snapImage{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(CGRectGetWidth(self.frame), CGRectGetHeight(self.frame)), YES, [UIScreen mainScreen].scale);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
