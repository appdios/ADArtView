//
//  ADStencilBrush.m
//  PhysicsPad
//
//  Created by Aditi Kamal on 7/5/12.
//
//

#import "ADStencilBrush.h"
#define kThreshold 60.0

@interface ADStencilBrush(){
    CGPoint previousPoint;
}
@end

@implementation ADStencilBrush
+ (ADStencilBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADStencilBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point
{
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{

    if([ADUtils distance:previousPoint withPoint:end] > kThreshold){
        previousPoint = end;
       drawTextureAtPointM(end);
    }
}

-(void) pathEnd:(CGPoint)point
{
    drawTextureAtPointM(point);
}
@end
