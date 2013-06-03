//
//  ADArcBrush.m
//  SketchStudio
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADArcBrush.h"

#define kLineDistance 30.0

@interface ADArcBrush()
@property (nonatomic, strong) NSMutableArray *pointsArray;
@end

@implementation ADArcBrush
@synthesize pointsArray;

+ (ADArcBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADArcBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point
{
    self.pointsArray = nil;
    self.pointsArray = [NSMutableArray array];
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    glLineWidth(2.0 * scale);
    glPointSize(2.0 * scale);
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.2);
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{    
    CGFloat scale = [[UIScreen mainScreen] scale];

    SMPoint *spoint = [[SMPoint alloc] initWithSnapPoint:end];
    [self.pointsArray addObject:spoint];
    
  //  drawTextureLine(begin, end, 1.0,TRUE);
    int pcount = [self.pointsArray count];
    
    for (int i = pcount-1; i > 0; i--){
        SMPoint *p = [self.pointsArray objectAtIndex:i];
        double d = [ADUtils distance:end withPoint:CGPointMake(p.x, p.y)]; 
        if (d < kLineDistance*scale) {
            drawTextureLine(end, CGPointMake(p.x, p.y),scale, true);
        }
    }
    
}

@end
