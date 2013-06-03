//
//  ADEraserBrush.m
//  PhysicsPad
//
//  Created by Aditi Kamal on 7/3/12.
//
//

#import "ADEraserBrush.h"

@implementation ADEraserBrush

+ (ADEraserBrush*)sharedInstance
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
    CGFloat scale = [[UIScreen mainScreen] scale];
    glPointSize(2.0*scale);
    drawEraserLine(point, point, 10);
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{
    
    CGFloat scale = [[UIScreen mainScreen] scale];
    glPointSize(2.0*scale);
    drawEraserLine(begin, end, 10);
}

@end
