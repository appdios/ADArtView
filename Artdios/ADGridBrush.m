//
//  ADGridBrush.m
//  SketchStudio
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADGridBrush.h"

@implementation ADGridBrush

+ (ADGridBrush*)sharedInstance 
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
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.01);
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{
    CGFloat scale = [[UIScreen mainScreen] scale];

    double  a, g, c, b;
    a = round(end.x / 100) * 100;
    g = round(end.y / 100) * 100;
    c = (a - end.x) * 5*scale;
    b = (g - end.y) * 5*scale;
    for (int e = 0; e < 40; e++) {
        drawQuadBezierM(CGPointMake(a, g), CGPointMake(end.x+kRandom*c, end.y+kRandom*b), CGPointMake(a, g), 4);
    }
}

@end
