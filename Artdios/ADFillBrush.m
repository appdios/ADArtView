//
//  ADFillBrush.m
//  PhysicsPad
//
//  Created by Aditi Kamal on 12/18/12.
//
//

#import "ADFillBrush.h"

@interface ADFillBrush()
{
    CGPoint previousPoint;
}
@end

@implementation ADFillBrush
+ (ADFillBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADFillBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point
{
    previousPoint = point;
    drawTextureAtPointM(point);
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{
    
    if([ADUtils distance:previousPoint withPoint:end] > 10){
        previousPoint = end;
        drawTextureAtPointM(end);
    }
    //drawTextureAtPointM(end);
}

@end

