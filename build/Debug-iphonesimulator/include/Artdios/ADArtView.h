//
//  ADArtView.h
//  Artdios
//
//  Created by Aditi Kamal on 5/19/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//
#import "ADEnums.h"

@protocol ADArtViewDelegate;

@interface ADArtView : UIView

@property (nonatomic, weak) id<ADArtViewDelegate> delegate;

- (id)initWithBackroundImage:(UIImage*)image;
- (void)setBrushType:(ADBrushType)brushType;
- (void)setBrushColor:(UIColor*)color;
- (void)setMirrorType:(ADMirrorType)mirrorType;
- (void)undo;

@end

@protocol ADArtViewDelegate <NSObject>
@required
- (void)artView:(ADArtView*)view imageDidChange:(UIImage*)image;
@end