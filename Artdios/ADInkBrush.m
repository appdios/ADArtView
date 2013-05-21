//
//  ADInkBrush.m
//  PhysicsPad
//
//  Created by Aditi Kamal on 12/29/12.
//
//

#import "ADInkBrush.h"
#import "ADDrawHelper.h"
#import "ADUtils.h"
#import "SMColor.h"

@interface ADInkBrush()
{
    CGPoint pts[5];
    uint ctr;
    double lastSize;
    double lastSpeed;
}
@end
@implementation ADInkBrush



+ (ADInkBrush*)sharedInstance
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point{
    ctr = 0;
    pts[0] = point;
    CGFloat scale = [[UIScreen mainScreen] scale];
    lastSize = 8;
    glPointSize(6*scale);
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 1.0);
    drawCircleTexture(point, 1, 1, 6*scale, FALSE);
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed
{
    lastSpeed = speed;
    [self drawInkPen:end speed:lastSpeed];
}

-(void) pathEnd:(CGPoint)point
{
    [self drawInkPen:point speed:lastSpeed];
}

-(void) drawInkPen:(CGPoint)point speed:(double)speed
{
    double lineThicknessLocal = speed/200 +10;
    lineThicknessLocal = clampf(lineThicknessLocal, 8, 14);
    lineThicknessLocal = lineThicknessLocal - 6;
    lineThicknessLocal = 12 - lineThicknessLocal;
    
    if (lineThicknessLocal < lastSize) {
        if ((lastSize - lineThicknessLocal)>0.2) {
            lineThicknessLocal = lastSize - 0.2;
        }
    }
    else if (lineThicknessLocal > lastSize) {
        if ((lineThicknessLocal - lastSize)>0.2) {
            lineThicknessLocal = lastSize + 0.2;
        }
    }
    
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    glColor4f(smcolor.red, smcolor.green, smcolor.blue, 1.0);

    CGFloat scale = [[UIScreen mainScreen] scale];

    glPointSize(lineThicknessLocal*scale);
    lastSize = lineThicknessLocal;
    
    ctr++;
    pts[ctr] = point;
    if (ctr == 4)
    {
        pts[3] = CGPointMake((pts[2].x + pts[4].x)/2.0, (pts[2].y + pts[4].y)/2.0);
        
        drawCubicBezierTexture(pts[0], pts[1], pts[2], pts[3], 8, scale);
        
        pts[0] = pts[3];
        pts[1] = pts[4];
        ctr = 1;
    }
}
@end


