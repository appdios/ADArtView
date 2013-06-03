//
//  ADUtils.m
//  SketchStudio
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADUtils.h"

@implementation ADUtils

+(NSArray *)rgbToHsv:(float)r g:(float)g b:(float)b{
    float max = MAX(r, g);
    max = MAX(max, b);
    
    float min = MIN(r, g);
    min = MIN(min, b);
    
    float h, s, v = max;
    
    float d = max - min;
    s = max == 0 ? 0 : d / max;
    
    if(max == min){
        h = 0; // achromatic
    }else{
        if(max == r){
            h = (g - b) / d + (g < b ? 6 : 0);
        }
        else if(max == g){
            h = (b - r) / d + 2;
        }
        else{
            h = (r - g) / d + 4;
        }
        h /= 6;
    }
    NSArray *hsv = [NSArray arrayWithObjects:[NSNumber numberWithFloat:h],
                    [NSNumber numberWithFloat:s],
                    [NSNumber numberWithFloat:v],nil];
    return hsv;
}

+(NSArray *)hsvToRgb:(float)h s:(float)s v:(float)v{
    float r, g, b;
    
    float i = floorf(h * 6);
    float f = h * 6 - i;
    float p = v * (1 - s);
    float q = v * (1 - f * s);
    float t = v * (1 - (1 - f) * s);
    
    int val = abs(i);
    
    switch(val % 6){
        case 0: r = v, g = t, b = p; break;
        case 1: r = q, g = v, b = p; break;
        case 2: r = p, g = v, b = t; break;
        case 3: r = p, g = q, b = v; break;
        case 4: r = t, g = p, b = v; break;
        case 5: r = v, g = p, b = q; break;
        default: r = v, g = p, b = q; break;
    }
    
    NSArray *rgb = [NSArray arrayWithObjects:[NSNumber numberWithFloat:r],
                    [NSNumber numberWithFloat:g],
                    [NSNumber numberWithFloat:b],nil];
    return rgb;
}

+(BOOL)ellipseContainsPoint:(CGPoint)point inRect:(CGRect)rect
{
    double radius = rect.size.width/2;
    CGPoint snapPoint = CGPointMake(rect.origin.x + radius, rect.origin.y+ radius);
    double Xvar = ( ( point.x - snapPoint.x ) * ( point.x - snapPoint.x ) ) / ( radius * radius );
    double Yvar = ( ( point.y - snapPoint.y ) * ( point.y - snapPoint.y ) ) / ( radius * radius);
    if ( Xvar + Yvar < 1 )
        return YES;
    
    return NO;
}

+(CGPoint)add:(CGPoint)point1 withPoint:(CGPoint)point2{
    return CGPointMake(point1.x + point2.x, point1.y + point2.y);
}

+(CGPoint)sub:(CGPoint)point1 withPoint:(CGPoint)point2{
    return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}

+(CGPoint)mul:(CGPoint)point1 withPoint:(CGPoint)point2{
    return CGPointMake(point1.x * point2.x, point1.y * point2.y);
}

+(CGPoint)mul:(CGPoint)point1 withValue:(double)value{
    return CGPointMake(point1.x * value, point1.y * value);
}

+(CGPoint)div:(CGPoint)point1 withPoint:(CGPoint)point2{
    return CGPointMake(point1.x/point2.x, point1.y/point2.y);
}

+(double)distance:(CGPoint)point1 withPoint:(CGPoint)point2{
    double dx = point1.x - point2.x;
    double dy = point1.y - point2.y;
    return sqrtf(powf(dx, 2) + powf(dy, 2));
}

+(double) angleBetween:(CGPoint) point1 andPoint:(CGPoint) point2{
    double dx = point2.x - point1.x;
    double dy = point2.y - point1.y;
    return atan2f(dx, dy);
}

+(CGPoint) getMirrorX:(CGPoint)point
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(currentOrientation)) {
        return CGPointMake((screenRect.size.height*scale - point.x), point.y);
    }
    
    return CGPointMake((screenRect.size.width*scale - point.x), point.y);
}

+(CGPoint) getMirrorY:(CGPoint)point
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(currentOrientation)) {
        return CGPointMake(point.x, screenRect.size.width*scale - point.y);
    }
    return CGPointMake(point.x, screenRect.size.height*scale - point.y);
}

+(CGPoint) getMirrorXY:(CGPoint)point
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat scale = [[UIScreen mainScreen] scale];
    UIInterfaceOrientation currentOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if (UIInterfaceOrientationIsLandscape(currentOrientation)) {
        return CGPointMake((screenRect.size.height*scale - point.x), (screenRect.size.width*scale - point.y));
    }
    return CGPointMake((screenRect.size.width*scale - point.x), (screenRect.size.height*scale - point.y));
}

+ (NSArray *)mirrorTypes
{
    static NSMutableArray * _names = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _names = [[NSMutableArray alloc] initWithCapacity:4];
        [_names insertObject:NSLocalizedString(@"None", nil) atIndex:ADMirrorTypeNone];
        [_names insertObject:NSLocalizedString(@"X-Mirror", nil) atIndex:ADMirrorTypeX];
        [_names insertObject:NSLocalizedString(@"Y-Mirror",nil) atIndex:ADMirrorTypeY];
        [_names insertObject:NSLocalizedString(@"Radial",nil) atIndex:ADMirrorTypeDiagonal];
    });
    
    return _names;
}

+(NSString *)stringForMirrorType:(ADMirrorType)type
{
    return [[self mirrorTypes] objectAtIndex:type];
}

+ (NSArray *)brushTypes
{
    static NSMutableArray * _names = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _names = [[NSMutableArray alloc] init];
//        [_names insertObject:@"ADBrushTypePattern" atIndex:ADBrushTypePattern];
        [_names insertObject:@"ADBrushTypeWeb" atIndex:ADBrushTypeWeb];
//        [_names insertObject:@"ADBrushTypeCurvy" atIndex:ADBrushTypeCurvy];
        [_names insertObject:@"ADBrushTypeRibbon" atIndex:ADBrushTypeRibbon];
//        [_names insertObject:@"ADBrushTypeSquare" atIndex:ADBrushTypeSquare];
        [_names insertObject:@"ADBrushTypeSketch" atIndex:ADBrushTypeSketch];
        [_names insertObject:@"ADBrushTypeArc" atIndex:ADBrushTypeArc];
        
//        [_names insertObject:@"ADBrushTypeCycloid" atIndex:ADBrushTypeCycloid];
//        [_names insertObject:@"ADBrushTypeSpray" atIndex:ADBrushTypeSpray];
        [_names insertObject:@"ADBrushTypeConcentricCircle" atIndex:ADBrushTypeConcentricCircle];
//        [_names insertObject:@"ADBrushTypeCalligraphy" atIndex:ADBrushTypeCalligraphy];
        
//        [_names insertObject:@"ADBrushTypeFlower" atIndex:ADBrushTypeFlower];
//        [_names insertObject:@"ADBrushTypeCircle" atIndex:ADBrushTypeCircle];
        [_names insertObject:@"ADBrushTypeShade" atIndex:ADBrushTypeShade];
        [_names insertObject:@"ADBrushTypeGrid" atIndex:ADBrushTypeGrid];
        [_names insertObject:@"ADBrushTypeEraser" atIndex:ADBrushTypeEraser];
//        [_names insertObject:@"ADBrushTypeStencil" atIndex:ADBrushTypeStencil];
//        [_names insertObject:@"ADBrushTypeSCircle" atIndex:ADBrushTypeSCircle];
//        [_names insertObject:@"ADBrushTypeSRectangle" atIndex:ADBrushTypeSRectangle];
        [_names insertObject:@"ADBrushTypeFur" atIndex:ADBrushTypeFur];
        [_names insertObject:@"ADBrushTypeCrayon" atIndex:ADBrushTypeCrayon];
        [_names insertObject:@"ADBrushTypeFill" atIndex:ADBrushTypeFill];
        [_names insertObject:@"ADBrushTypeInk" atIndex:ADBrushTypeInk];
        [_names insertObject:@"ADBrushTypePen" atIndex:ADBrushTypePen];
        [_names insertObject:@"ADBrushTypeText" atIndex:ADBrushTypeText];

    });
    
    return _names;
}

+(NSString *)stringForBrushType:(ADBrushType)type
{
    return [[self brushTypes] objectAtIndex:type];
}


CGPoint midPoint(CGPoint p1, CGPoint p2) {
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}
float clampf(float value, float min_inclusive, float max_inclusive)
{
	if (min_inclusive > max_inclusive) {
		CC_SWAP(min_inclusive,max_inclusive);
	}
	return value < min_inclusive ? min_inclusive : value < max_inclusive? value : max_inclusive;
}

@end
