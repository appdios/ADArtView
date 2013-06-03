//
//  ADFurBrush.m
//  PhysicsPad
//
//  Created by Aditi Kamal on 7/17/12.
//
//

#import "ADFurBrush.h"

@interface ADFurBrush()
{
    CGPoint pts[5];
    uint ctr;
}
@property (nonatomic, strong) NSMutableArray *pointsArray;

@end

@implementation ADFurBrush
@synthesize pointsArray;

+ (ADFurBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADFurBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point
{
    self.pointsArray = nil;
    self.pointsArray = [NSMutableArray array];
    
    ctr = 0;
    pts[0] = point;
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{
    CGFloat scale = [[UIScreen mainScreen] scale];

    double b, a, g;
    SMPoint *point = [[SMPoint alloc] initWithSnapPoint:end];
    [self.pointsArray addObject:point];
    
    glLineWidth(2.0*scale);
    glPointSize(2.0*scale);
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
    
    glLineWidth(1.0*scale);
    glPointSize(1.0*scale);
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 0.2);

    unsigned int count = [self.pointsArray count];
    for (int e = 0; e < count; e++) {
        SMPoint *point = [self.pointsArray objectAtIndex:e];
        SMPoint *epoint = [self.pointsArray objectAtIndex:count-1];
        b = point.x - epoint.x;
        a = point.y - epoint.y;
        g = b * b + a * a;
        if (g < (2000*scale) && kRandom > g / (2000*scale)) {
            drawTextureLine(CGPointMake(end.x + (b * scale/2.0), end.y + (a * scale/2.0)), CGPointMake(end.x - (b * scale/2.0), end.y - (a * scale/2.0)),scale, true);
        }
    }
}

@end
