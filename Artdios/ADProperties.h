//
//  ADProperties.h
//
//  Created by Sumit Kumar on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADUtils.h"

@class SMColor;
@class Texture2D;

@interface ADProperties : NSObject

@property(nonatomic) ADMirrorType mirrorType;
@property(nonatomic) ADBrushType brushType;
@property(nonatomic, strong) SMColor *bgColor;
@property(nonatomic, strong) SMColor *smStrokeColor;
@property(nonatomic) CGPoint bubbleColorPosition;
@property(nonatomic) double bubbleSliderAngle;

@property(nonatomic) double strokeWidth;
@property(nonatomic) BOOL isDefault;
@property(nonatomic,strong)Texture2D *stencilImage;
@property(nonatomic,strong)Texture2D *waterEdgeImage;

+(id)sharedInstance;
@end
