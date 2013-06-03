//
//  ADWebBrush.m
//  SketchStudio
//
//  Created by Sumit Kumar on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADWebBrush.h"


#define kHistory 10
#define kFactor 6
#define kAlphaOffset 3.0

@interface ADWebBrush()
{
    double previousX;
    double previousY;
}
@property (nonatomic, strong) NSMutableArray *pointsArray;
@end

@implementation ADWebBrush
@synthesize pointsArray;

+ (ADWebBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADWebBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point
{
    previousX = point.x;
    previousY = point.y;

    self.pointsArray = nil;
    self.pointsArray = [NSMutableArray array];
    
 /*   ADProperties *property = [ADProperties properties];
    SMColor *smcolor = property.strokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.2);*/
}


-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{
    CGFloat scale = [[UIScreen mainScreen] scale];

    double offset = (kRandom - 0.5) * kFactor;
    SMPoint *newPoint = [[SMPoint alloc] initWithSnapPoint:CGPointMake(end.x+offset, end.y+offset)];
    [self.pointsArray addObject:newPoint];
    
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.2);
    glLineWidth(3.0*scale);
    glPointSize(3.0*scale);
    drawTextureLine(CGPointMake(previousX, previousY), CGPointMake(newPoint.x, newPoint.y),1, true);
    int pcount = [self.pointsArray count];
    glLineWidth(2.0*scale);
    glPointSize(2.0*scale);
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.1);
    if(pcount > kHistory){
        NSArray *slicedPointsArray = [NSArray arrayWithArray:[self.pointsArray subarrayWithRange:NSMakeRange(pcount - kHistory, kHistory)]];
        int j = 0;
        for(SMPoint *point in slicedPointsArray){
            j++;
            drawTextureLine(CGPointMake(newPoint.x, newPoint.y), CGPointMake(point.x, point.y),scale, true);
        }
    }
    
    previousX = newPoint.x;
    previousY = newPoint.y;
}

@end
