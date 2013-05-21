//
//  ADUtils.h
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADEnums.h"

#define kRandom (arc4random() % 11) * 0.1
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)
#define RADIANS_TO_DEGREES(angle) ((angle) / M_PI * 180.0)

#define ANGLE_TO_PERCENT(angle) ((angle)/360)
#define kPointMinDistance 5

#define kPointMinDistanceSquared  kPointMinDistance * kPointMinDistance
#define CC_SWAP( x, y )			\
({ __typeof__(x) temp  = (x);		\
x = y; y = temp;		\
})

@interface ADUtils : NSObject

+(NSArray *)rgbToHsv:(float)r g:(float)g b:(float)b;
+(NSArray *)hsvToRgb:(float)h s:(float)s v:(float)v;

+(BOOL)ellipseContainsPoint:(CGPoint)point inRect:(CGRect)rect;
+(CGPoint)add:(CGPoint)point1 withPoint:(CGPoint)point2;
+(CGPoint)sub:(CGPoint)point1 withPoint:(CGPoint)point2;
+(CGPoint)mul:(CGPoint)point1 withPoint:(CGPoint)point2;
+(CGPoint)mul:(CGPoint)point1 withValue:(double)value;
+(CGPoint)div:(CGPoint)point1 withPoint:(CGPoint)point2;
+(double)distance:(CGPoint)point1 withPoint:(CGPoint)point2;
+(double) angleBetween:(CGPoint) point1 andPoint:(CGPoint) point2;
+(CGPoint) getMirrorX:(CGPoint)point;
+(CGPoint) getMirrorY:(CGPoint)point;
+(CGPoint) getMirrorXY:(CGPoint)point;

+(NSString *)stringForMirrorType:(ADMirrorType)type;
+(NSString *)stringForBrushType:(ADBrushType)type;
CGPoint midPoint(CGPoint p1, CGPoint p2);
float clampf(float value, float min_inclusive, float max_inclusive);
@end
