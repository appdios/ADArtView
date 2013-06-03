//
//  ADCurvyBrush.m
//  SketchStudio
//
//  Created by Sumit Kumar on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADCurvyBrush.h"

#define kStart 30
#define kControlPointDistance1 10
#define kControlPointDistance2 20

#define kAlphaOffset 3.0

@interface ADCurvyBrush()
@property(nonatomic,strong) NSDictionary *currentStroke;
@property (nonatomic, strong) NSMutableArray *pointsArray;
@end

@implementation ADCurvyBrush

+ (ADCurvyBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADCurvyBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}


-(SMPoint *)getPoint:(int)searchIndex{
    int pcount = [self.pointsArray count];
    int index = abs(pcount - searchIndex);
    if(index < pcount)
        return [self.pointsArray objectAtIndex:index];
    return nil;
}

-(void) pathStart:(CGPoint)point
{
    self.pointsArray = nil;
    self.pointsArray = [NSMutableArray array];
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed
{
    SMPoint *newPoint = [[SMPoint alloc] initWithSnapPoint:end];
    [self.pointsArray addObject:newPoint];
    
    drawLineM(begin, end);
   
    SMPoint *start = [self getPoint:kStart];
    SMPoint *cOne = [self getPoint:kControlPointDistance1];
    SMPoint *cTwo = [self getPoint:kControlPointDistance2];
    
    if(start) 
    {
        drawCubicBezierM(CGPointMake(start.x, start.y), CGPointMake(cOne.x, cOne.y), CGPointMake(cTwo.x, cTwo.y),end, 4);
    }
}

@end
