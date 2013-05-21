//
//  UIImage+Alpha.h
//  PhysicsPad
//
//  Created by Aditi Kamal on 11/16/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Alpha)
- (BOOL)hasAlpha;
- (UIImage *)imageWithAlpha;
- (UIImage *)transparentBorderImage:(NSUInteger)borderSize;
@end