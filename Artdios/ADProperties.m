//
//  ADProperties.m
//
//  Created by Sumit Kumar on 5/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADProperties.h"
#import "SMColor.h"
#import "Texture2D.h"

@implementation ADProperties

+(id)sharedInstance
{
    static dispatch_once_t pred;
    static ADProperties *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[ADProperties alloc] init];
        sharedInstance.smStrokeColor = [[SMColor alloc] initWithRed:0 green:0 blue:0 alpha:0.5];
        sharedInstance.strokeWidth = 1.0;
        sharedInstance.bgColor = [[SMColor alloc] initWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
        sharedInstance.mirrorType = ADMirrorTypeNone;
        sharedInstance.bubbleColorPosition = CGPointMake(160.0, 50.0);
        sharedInstance.bubbleSliderAngle = DEGREES_TO_RADIANS(180.0);
        sharedInstance.isDefault=TRUE;        
    });
    return sharedInstance;
}


-(void)setBrushStrokeColor:(SMColor *)sColor{
    self.smStrokeColor.red = sColor.red;
    self.smStrokeColor.blue = sColor.blue;
    self.smStrokeColor.green = sColor.green;
    self.smStrokeColor.alpha = sColor.alpha;
}

-(void)setBrushType:(ADBrushType)bType{
    if (bType != _brushType) {
        _brushType=bType;
    }
}

@end


