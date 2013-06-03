//
//  ADSketchBrush.m
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADSketchBrush.h"

@interface ADSketchBrush()
{
    CGPoint pts[5];
    uint ctr;
}
@property (nonatomic, strong) NSMutableArray *pointsArray;

@end

@implementation ADSketchBrush

+ (ADSketchBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADSketchBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point{
    self.pointsArray = nil;
    self.pointsArray = [NSMutableArray array];
    
    ctr = 0;
    pts[0] = point;
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed
{
    SMPoint *spoint = [[SMPoint alloc] initWithSnapPoint:end];
    [self.pointsArray addObject:spoint];
    
    CGFloat scale = [[UIScreen mainScreen] scale];

    glLineWidth(3.0 * scale);
    glPointSize(3.0 * scale);
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.4);
    
    ctr++;
    pts[ctr] = end;
    if (ctr == 4)
    {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
        
        drawCubicBezierTexture(pts[0], pts[1], pts[2], pts[3], 8, scale);
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
    
    int pcount = [self.pointsArray count];
    
    double b,a,g;
    glLineWidth(2.0 * scale);
    glPointSize(2.0 * scale);
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.2);
    
    for (int e = 0; e < pcount; e++) {
        SMPoint *point = [self.pointsArray objectAtIndex:e];
        SMPoint *lpoint = [self.pointsArray objectAtIndex:pcount-1];
        
        b =   point.x - lpoint.x;
        a = point.y - lpoint.y;
        g = b * b + a * a;
        if (g < 4000 && kRandom > g / 2000) {
            drawTextureLine(CGPointMake(lpoint.x+(b*0.3), lpoint.y+ (a*0.3)), CGPointMake(point.x-(b*0.3), point.y-(a*0.3)),scale, true);

        }
    }
}

@end
