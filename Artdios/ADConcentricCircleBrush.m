//
//  ADConcentricCircleBrush.m
//  SketchStudio
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADConcentricCircleBrush.h"

#define kRadius 16

@implementation ADConcentricCircleBrush

+ (ADConcentricCircleBrush*)sharedInstance 
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


-(void) pathStart:(CGPoint)point
{
    [self drawAtPoint:point];
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{
    [self drawAtPoint:end];
}

- (void)drawAtPoint:(CGPoint)point
{
    double radius = kRadius*kRandom;
    CGFloat scale = [[UIScreen mainScreen] scale];
    glPointSize(2*scale);
    
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.1);
    drawCircle(point, radius*scale, 0, 30*scale, FALSE);
    
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.5);
    drawCircleTexture(point, radius*scale, 0, (kRadius*2*scale)*scale, FALSE);
}

@end
