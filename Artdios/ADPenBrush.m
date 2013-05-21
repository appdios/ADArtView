//
//  ADRibbonBrush.m
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADPenBrush.h"
#import "SMPainter.h"
#import "ADUtils.h"
#import "ADProperties.h"
#import "SMColor.h"
#import "ADDrawHelper.h"

#define kPainterLines 20

@interface ADPenBrush()
{
    CGPoint pts[20][5];
    uint ctr[20];
}
@property (nonatomic, strong) NSMutableArray *pointsArray;

@end

@implementation ADPenBrush
@synthesize pointsArray;

+ (ADPenBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADPenBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void)buildRibbon:(CGPoint)currentPoint{
    self.pointsArray  = nil;
    self.pointsArray = [NSMutableArray arrayWithCapacity:kPainterLines];
    for (int a = 0; a < kPainterLines; a++) {
        SMPainter *painter = [[SMPainter alloc] initWithPoints:currentPoint ap:CGPointZero forBrush:ADBrushTypePen];
        [self.pointsArray addObject:painter];
        
        ctr[a] = 0;
        pts[a][0] = currentPoint;
    }
}

-(void) pathStart:(CGPoint)point
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    glPointSize(6*scale);
    drawCircleTexture(point, 1, 1, 6*scale, FALSE);
    [self buildRibbon:point];
}

-(void)pathMoveFromPoint:(CGPoint)beginMain toPoint:(CGPoint)endMain speed:(double)speed
{
    CGFloat scale = [[UIScreen mainScreen] scale];
    
    int pcount = [self.pointsArray count];
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    
    for (int i=0; i<pcount; i++) {
        SMPainter *painter = [self.pointsArray objectAtIndex:i];
        //  CGPoint begin = [painter dp];
        CGPoint temp = [ADUtils sub:CGPointMake([painter dp].x, [painter dp].y) withPoint:endMain];
        temp = [ADUtils mul:temp withPoint:CGPointMake([painter div], [painter div])];
        temp = [ADUtils add:CGPointMake([painter ap].x, [painter ap].y) withPoint:temp];
        
        CGPoint newap = [ADUtils mul:temp withPoint:CGPointMake([painter ease], [painter ease])];
        [painter setAp:newap];
        
        CGPoint newdp = [ADUtils sub:CGPointMake([painter dp].x, [painter dp].y) withPoint:CGPointMake([painter ap].x, [painter ap].y)];
        
        [painter setDp:newdp];
        
        CGPoint end = [painter dp];
        
        glColor4f(smcolor.red-i/24, smcolor.green-i/24, smcolor.blue-i/24, 1);
        
        ctr[i]++;
        pts[i][ctr[i]] = end;
        if (ctr[i] == 4)
        {
            pts[i][3] = CGPointMake((pts[i][2].x + pts[i][4].x)/2.0, (pts[i][2].y + pts[i][4].y)/2.0);
            
            drawCubicBezierTexture(pts[i][0], pts[i][1], pts[i][2], pts[i][3], 8, scale);
            
            pts[i][0] = pts[i][3];
            pts[i][1] = pts[i][4];
            ctr[i] = 1;
        }
        
    }
}

@end
