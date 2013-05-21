//
//  ADDrawHelper.h
//  Brushes
//
//  Created by Aditi Kamal on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADDrawHelper : NSObject

/** draws a point given x and y coordinate */
void drawPointM( CGPoint point );
void drawPoint( CGPoint point );

/** draws an array of points.
 @since v0.7.2
 */
void drawTextureLine(CGPoint begin, CGPoint end, int size, bool mirror);
void drawPointsM(float *points, unsigned int numberOfPoints );
void drawPoints(float *points, unsigned int numberOfPoints );
void drawBatchTextureLine(CGPoint *begin, CGPoint *end,int countOfPoints, int size, bool mirror);
/** draws a line given the origin and destination point */
void drawLineM( CGPoint origin, CGPoint destination );
void drawLine( CGPoint origin, CGPoint destination );

/** draws a poligon given a pointer to CGPoint coordiantes and the number of vertices. The polygon can be closed or open
 */
void drawPolyM( CGPoint *vertices, int numOfVertices, BOOL closePolygon );
void drawPoly( CGPoint *vertices, int numOfVertices, BOOL closePolygon );

/** draws a circle given the center, radius and number of segments. */
void drawCircleM( CGPoint center, float radius, float angle, int segments, BOOL drawLineToCenter);
void drawCircle( CGPoint center, float radius, float angle, int segments, BOOL drawLineToCenter);
void drawCircleTexture( CGPoint center, float r, float a, int segs, BOOL drawLineToCenter);

/** draws a quad bezier path
 @since v0.8
 */
void drawQuadBezierM(CGPoint origin, CGPoint control, CGPoint destination, int segments);
void drawQuadBezier(CGPoint origin, CGPoint control, CGPoint destination, int segments);
void drawQuadPoly( CGPoint *poli, CGPoint controlPoint1, CGPoint controlPoint2);
void drawQuadPolyTexture(CGPoint *poli, CGPoint controlPoint1, CGPoint controlPoint2);
void drawQuadBezierTexture(CGPoint origin, CGPoint control, CGPoint destination, int segments, int distance);
void drawCubicBezierTexture(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, int segments, int size);
/** draws a cubic bezier path
 @since v0.8
 */
void drawCubicBezierM(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, int segments);
void drawCubicBezier(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, int segments);

void drawTexture(CGPoint begin, CGPoint end);
void drawTextureAtPoint(CGPoint point);
void drawTextureAtPointM(CGPoint point);
void drawEraserLine(CGPoint begin, CGPoint end, int size);
@end
