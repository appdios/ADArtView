//
//  ADDrawHelper.m
//  Brushes
//
//  Created by Aditi Kamal on 5/27/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADDrawHelper.h"
#import "Texture2D.h"
#import <math.h>
#import <stdlib.h>
#import <string.h>

#define kBrushPixelStep 3

@implementation ADDrawHelper

void drawTextureLine(CGPoint begin, CGPoint end, int size, bool mirror){
    GLfloat*		vertexBuffer = NULL;
    NSUInteger	vertexMax = 64;
	NSUInteger			vertexCount = 0,
    count,
    i;
	
	// Allocate vertex array buffer
	if(vertexBuffer == NULL)
		vertexBuffer = malloc(vertexMax * 2 * sizeof(GLfloat));
	
	// Add points to the buffer so there are drawing points every X pixels
	count = MAX(ceilf(sqrtf((end.x - begin.x) * (end.x - begin.x) + (end.y - begin.y) * (end.y - begin.y)) / size), 1);
	for(i = 0; i < count; ++i) {
		if(vertexCount == vertexMax) {
			vertexMax = 2 * vertexMax;
			vertexBuffer = realloc(vertexBuffer, vertexMax * 2 * sizeof(GLfloat));
		}
		
		vertexBuffer[2 * vertexCount + 0] = begin.x + (end.x - begin.x) * ((GLfloat)i / (GLfloat)count);
		vertexBuffer[2 * vertexCount + 1] = begin.y + (end.y - begin.y) * ((GLfloat)i / (GLfloat)count);
		vertexCount += 1;
	}
	if (mirror) {
        drawPointsM(vertexBuffer, vertexCount);
    }
    else{
        drawPoints(vertexBuffer, vertexCount);
    }
    if (vertexBuffer) {
        free(vertexBuffer);
    }
}

void drawBatchTextureLine(CGPoint *begin, CGPoint *end,int countOfPoints, int size, bool mirror){
    GLfloat*		vertexBuffer = NULL;
    NSUInteger	vertexMax = 128;//64;
	NSUInteger			vertexCount = 0,
    count,
    i;
	
	// Allocate vertex array buffer
	if(vertexBuffer == NULL)
		vertexBuffer = malloc(vertexMax * 2 * sizeof(GLfloat));
	
    for (int j=0; j<countOfPoints; j++) {
        // Add points to the buffer so there are drawing points every X pixels
        count = MAX(ceilf(sqrtf((end[j].x - begin[j].x) * (end[j].x - begin[j].x) + (end[j].y - begin[j].y) * (end[j].y - begin[j].y)) / size), 1);
        for(i = 0; i < count; ++i) {
            if(vertexCount == vertexMax) {
                vertexMax = 2 * vertexMax;
                vertexBuffer = realloc(vertexBuffer, vertexMax * 2 * sizeof(GLfloat));
            }
            
            vertexBuffer[2 * vertexCount + 0] = begin[j].x + (end[j].x - begin[j].x) * ((GLfloat)i / (GLfloat)count);
            vertexBuffer[2 * vertexCount + 1] = begin[j].y + (end[j].y - begin[j].y) * ((GLfloat)i / (GLfloat)count);
            vertexCount += 1;
        }
    }
	
	if (mirror) {
        drawPointsM(vertexBuffer, vertexCount);
    }
    else{
        drawPoints(vertexBuffer, vertexCount);
    }
    if (vertexBuffer) {
        free(vertexBuffer);
    }
}

void drawEraserLine(CGPoint begin, CGPoint end, int size){
    GLfloat*		vertexBuffer = NULL;
    NSUInteger	vertexMax = 64;
	NSUInteger			vertexCount = 0,
    count,
    i;
	
	// Allocate vertex array buffer
	if(vertexBuffer == NULL)
		vertexBuffer = malloc(vertexMax * 2 * sizeof(GLfloat));
	
	// Add points to the buffer so there are drawing points every X pixels
	count = MAX(ceilf(sqrtf((end.x - begin.x) * (end.x - begin.x) + (end.y - begin.y) * (end.y - begin.y)) / size), 1);
	for(i = 0; i < count; ++i) {
		if(vertexCount == vertexMax) {
			vertexMax = 2 * vertexMax;
			vertexBuffer = realloc(vertexBuffer, vertexMax * 2 * sizeof(GLfloat));
		}
		
		vertexBuffer[2 * vertexCount + 0] = begin.x + (end.x - begin.x) * ((GLfloat)i / (GLfloat)count);
		vertexBuffer[2 * vertexCount + 1] = begin.y + (end.y - begin.y) * ((GLfloat)i / (GLfloat)count);
        
        drawCircle(CGPointMake(vertexBuffer[2 * vertexCount + 0], vertexBuffer[2 * vertexCount + 1]), 20, 0, 60, FALSE);
        
        vertexCount += 1;
        
	}
    
    if (vertexBuffer) {
        free(vertexBuffer);
    }
}

void drawTexture(CGPoint begin, CGPoint end){
    NSUInteger count,
    i;
	
	// Add points to the buffer so there are drawing points every X pixels
	count = MAX(ceilf(sqrtf((end.x - begin.x) * (end.x - begin.x) + (end.y - begin.y) * (end.y - begin.y)) / 8), 1);
	for(i = 0; i < count; ++i) {
		double pointX = begin.x + (end.x - begin.x) * ((GLfloat)i / (GLfloat)count);
		double pointY = begin.y + (end.y - begin.y) * ((GLfloat)i / (GLfloat)count);
		drawTextureAtPoint(CGPointMake(pointX, pointY));
	}
}

void drawTextureAtPoint(CGPoint point)
{
    Texture2D *texture = [[ADProperties sharedInstance] stencilImage];
    [texture drawAtPoint:point];
}

void drawTextureAtPointM(CGPoint point)
{
    /* glColor4f(1.0f, 0.0f, 0.0f, 0.25f);   //defines the alpha value = 0.25f
     glBlendFunc(GL_SRC_ALPHA, GL_ZERO);   //takes 1/4 of the src brightness (ignore dest color)
     
     Texture2D *edgeTexture = [[ADProperties properties] waterEdgeImage];
     [edgeTexture drawAtPoint:point];
     
     
     glColor4f(1.0f, 0.0f, 0.0f, 0.75f);   //defines the alpha value = 0.75f
     glBlendFunc(GL_SRC_ALPHA, GL_ONE);
     
     glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_DST_ALPHA);
     
     //glBlendFunc(GL_SRC_ALPHA, GL_ZERO);
     Texture2D *edgeTexture = [[ADProperties properties] waterEdgeImage];
     [edgeTexture drawAtPoint:point];
     glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
     */
    Texture2D *texture = [[ADProperties sharedInstance] stencilImage];
    [texture drawAtPoint:point];
    
    NSInteger mirrorType = [[ADProperties sharedInstance] mirrorType];
    switch (mirrorType) {
        case ADMirrorTypeX:
            [texture drawAtPoint:[ADUtils getMirrorX:point]];
            break;
        case ADMirrorTypeY:
            [texture drawAtPoint:[ADUtils getMirrorY:point]];
            break;
        case ADMirrorTypeDiagonal:
            [texture drawAtPoint:[ADUtils getMirrorXY:point]];
            break;
        case (ADMirrorTypeX|ADMirrorTypeY):
            [texture drawAtPoint:[ADUtils getMirrorX:point]];
            [texture drawAtPoint:[ADUtils getMirrorY:point]];
            break;
        case (ADMirrorTypeX|ADMirrorTypeDiagonal):
            [texture drawAtPoint:[ADUtils getMirrorX:point]];
            [texture drawAtPoint:[ADUtils getMirrorXY:point]];
            break;
        case (ADMirrorTypeY|ADMirrorTypeDiagonal):
            [texture drawAtPoint:[ADUtils getMirrorY:point]];
            [texture drawAtPoint:[ADUtils getMirrorXY:point]];
            break;
        case (ADMirrorTypeX|ADMirrorTypeY|ADMirrorTypeDiagonal):
            [texture drawAtPoint:[ADUtils getMirrorX:point]];
            [texture drawAtPoint:[ADUtils getMirrorY:point]];
            [texture drawAtPoint:[ADUtils getMirrorXY:point]];
            break;
        default:
            break;
    }
}

void drawPointM( CGPoint point )
{
    drawPoint(point);
    NSInteger mirrorType = [[ADProperties sharedInstance] mirrorType];
    switch (mirrorType) {
        case ADMirrorTypeX:
            drawPoint([ADUtils getMirrorX:point]);
            break;
        case ADMirrorTypeY:
            drawPoint([ADUtils getMirrorY:point]);
            break;
        case ADMirrorTypeDiagonal:
            drawPoint([ADUtils getMirrorXY:point]);
            break;
        case (ADMirrorTypeX|ADMirrorTypeY):
            drawPoint([ADUtils getMirrorX:point]);
            drawPoint([ADUtils getMirrorY:point]);
            break;
        case (ADMirrorTypeX|ADMirrorTypeDiagonal):
            drawPoint([ADUtils getMirrorX:point]);
            drawPoint([ADUtils getMirrorXY:point]);
            break;
        case (ADMirrorTypeY|ADMirrorTypeDiagonal):
            drawPoint([ADUtils getMirrorY:point]);
            drawPoint([ADUtils getMirrorXY:point]);
            break;
        case (ADMirrorTypeX|ADMirrorTypeY|ADMirrorTypeDiagonal):
            drawPoint([ADUtils getMirrorX:point]);
            drawPoint([ADUtils getMirrorY:point]);
            drawPoint([ADUtils getMirrorXY:point]);
            break;
        default:
            break;
    }
}

void drawPoint( CGPoint point )
{
	glVertexPointer(2, GL_FLOAT, 0, &point);
	glDrawArrays(GL_POINTS, 0, 1);
}

void drawPointsM(float *points, unsigned int numberOfPoints ){
    drawPoints(points, numberOfPoints);
    float pointsM[numberOfPoints*2];
    CGPoint currentPoint;
    
    NSInteger mirrorType = [[ADProperties sharedInstance] mirrorType];

    switch (mirrorType) {
        case ADMirrorTypeX:
            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorX:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            break;
        case ADMirrorTypeY:
            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            break;
        case ADMirrorTypeDiagonal:
            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorXY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            break;
        case (ADMirrorTypeX|ADMirrorTypeY):
            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorX:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            break;
        case (ADMirrorTypeX|ADMirrorTypeDiagonal):
            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorX:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorXY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            break;
        case (ADMirrorTypeY|ADMirrorTypeDiagonal):
            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorXY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            break;
        case (ADMirrorTypeX|ADMirrorTypeY|ADMirrorTypeDiagonal):
            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorX:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            for(int i=0; i<numberOfPoints*2; i = i+2){
                currentPoint = [ADUtils getMirrorXY:CGPointMake(points[i], points[i+1])];
                pointsM[i] = currentPoint.x;
                pointsM[i+1] = currentPoint.y;
            }
            drawPoints(pointsM, numberOfPoints);

            break;
        default:
            break;
    }
}

void drawPoints(float *points, unsigned int numberOfPoints )
{
    glVertexPointer(2, GL_FLOAT, 0, points);
	glDrawArrays(GL_POINTS, 0, numberOfPoints);
}


void drawLineM(CGPoint origin, CGPoint destination)
{
    drawLine(origin, destination);
//    for(id mirrorType in [[ADProperties properties] mirrorTypes]){
//        int mirror = [mirrorType intValue];
//        if (mirror == ADMirrorTypeX) {
//            drawLine([ADUtils getMirrorX:origin], [ADUtils getMirrorX:destination]);
//        }
//        else if (mirror == ADMirrorTypeY) {
//            drawLine([ADUtils getMirrorY:origin], [ADUtils getMirrorY:destination]);
//        }
//        else if (mirror == ADMirrorTypeXY) {
//            drawLine([ADUtils getMirrorXY:origin], [ADUtils getMirrorXY:destination]);
//        }
//    }
}


void drawLine( CGPoint origin, CGPoint destination )
{
	CGPoint vertices[2];
	
	vertices[0] = origin;
	vertices[1] = destination;
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_LINES, 0, 2);
}

void drawPolyM( CGPoint *poli, int points, BOOL closePolygon ){
    drawPoly(poli, points, closePolygon);
//    CGPoint poliM[points];
//    for(id mirrorType in [[ADProperties properties] mirrorTypes]){
//        int mirror = [mirrorType intValue];
//        if (mirror == ADMirrorTypeX) {
//            for(int i=0; i<points; i++){
//                poliM[i] =  [ADUtils getMirrorX:poli[i]];
//            }
//        }
//        else if (mirror == ADMirrorTypeY) {
//            for(int i=0; i<points; i++){
//                poliM[i] =  [ADUtils getMirrorY:poli[i]];
//            }
//        }
//        else if (mirror == ADMirrorTypeXY) {
//            for(int i=0; i<points; i++){
//                poliM[i] =  [ADUtils getMirrorXY:poli[i]];
//            }
//        }
//        drawPoly(poliM, points, closePolygon);
//    }
}

void drawPoly( CGPoint *poli, int points, BOOL closePolygon )
{
	glVertexPointer(2, GL_FLOAT, 0, poli);
	
    if( closePolygon )
		glDrawArrays(GL_LINE_LOOP, 0, points);
	else
		glDrawArrays(GL_LINE_STRIP, 0, points);
	
    BOOL isFill = TRUE;//[[ADBrushProperty currentBrushProperty] isFill];
    if(isFill){
        glDrawArrays(GL_TRIANGLE_FAN, 0, points); //fill color
    }
}

void drawQuadPolyTexture(CGPoint *poli, CGPoint controlPoint1, CGPoint controlPoint2)
{
    int segments = 16;
    {
        CGPoint vertices[segments+1];
        float t = 0.0f;
        for(int i = 0; i < segments; i++)
        {
            float x = powf(1 - t, 2) * poli[0].x + 2.0f * (1 - t) * t * controlPoint1.x + t * t * poli[1].x;
            float y = powf(1 - t, 2) * poli[0].y + 2.0f * (1 - t) * t * controlPoint1.y + t * t * poli[1].y;
            vertices[i] = CGPointMake(x, y);
            
            t += 1.0f / segments;
        }
        vertices[segments] = poli[1];
        
        for (int i=0; i<segments; i=i+1) {
            drawTextureLine(vertices[i], vertices[i+1], 1, FALSE);
        }
    }
    {
        CGPoint vertices[segments+1];
        float t = 0.0f;
        for(int i = 0; i < segments; i++)
        {
            float x = powf(1 - t, 2) * poli[2].x + 2.0f * (1 - t) * t * controlPoint2.x + t * t * poli[3].x;
            float y = powf(1 - t, 2) * poli[2].y + 2.0f * (1 - t) * t * controlPoint2.y + t * t * poli[3].y;
            vertices[i] = CGPointMake(x, y);
            
            t += 1.0f / segments;
        }
        vertices[segments] = poli[3];
        for (int i=0; i<segments; i=i+1) {
            drawTextureLine(vertices[i], vertices[i+1], 1, FALSE);
        }
    }
}

void drawQuadPoly( CGPoint *poli, CGPoint controlPoint1, CGPoint controlPoint2)
{
    int segments=16;
    CGPoint vertices[segments*2+2];
    
    float t = 0.0f;
    for(int i = 0; i < segments; i++)
    {
        float x = powf(1 - t, 2) * poli[0].x + 2.0f * (1 - t) * t * controlPoint1.x + t * t * poli[1].x;
        float y = powf(1 - t, 2) * poli[0].y + 2.0f * (1 - t) * t * controlPoint1.y + t * t * poli[1].y;
        vertices[i] = CGPointMake(x, y);
        
        t += 1.0f / segments;
    }
    vertices[segments] = poli[1];
    vertices[segments+1] = poli[2];
    
    t = 0.0f;
    for(int i = segments+1; i < segments+1+segments; i++)
    {
        float x = powf(1 - t, 2) * poli[2].x + 2.0f * (1 - t) * t * controlPoint2.x + t * t * poli[3].x;
        float y = powf(1 - t, 2) * poli[2].y + 2.0f * (1 - t) * t * controlPoint2.y + t * t * poli[3].y;
        vertices[i] = CGPointMake(x, y);
        
        t += 1.0f / segments;
    }
    vertices[segments*2+1] = poli[3];
    
    glVertexPointer(2, GL_FLOAT, 0, vertices);
    //  glDrawArrays(GL_LINE_STRIP, 0, segments*2+2);
    
    glDrawArrays(GL_TRIANGLE_FAN, 0, segments*2+2);
}

void drawCircleM( CGPoint center, float r, float a, int segs, BOOL drawLineToCenter){
    drawCircle(center, r, a, segs, drawLineToCenter);
//    for(id mirrorType in [[ADProperties properties] mirrorTypes]){
//        int mirror = [mirrorType intValue];
//        if (mirror == ADMirrorTypeX) {
//            drawCircle([ADUtils getMirrorX:center], r, a, segs, drawLineToCenter);
//        }
//        else if (mirror == ADMirrorTypeY) {
//            drawCircle([ADUtils getMirrorY:center], r, a, segs, drawLineToCenter);
//        }
//        else if (mirror == ADMirrorTypeXY) {
//            drawCircle([ADUtils getMirrorXY:center], r, a, segs, drawLineToCenter);
//        }
//    }
}


unsigned int randnogen(unsigned int min, unsigned int max)
{
    double scaled = (double)rand()/RAND_MAX;
    
    return (max - min +1)*scaled + min;
}

void drawCircle( CGPoint center, float r, float a, int segs, BOOL drawLineToCenter)
{
    int additionalSegment = 1;
	if (drawLineToCenter)
		additionalSegment++;
    
	const float coef = 2.0f * (float)M_PI/segs;
	
	float *vertices = malloc( sizeof(float)*2*(segs+2));
	if( ! vertices )
		return;
	
	memset( vertices,0, sizeof(float)*2*(segs+2));
	
	for(int i=0;i<=segs;i++)
	{
		float rads = i*coef;
		float j = r * cosf(rads + a) + center.x;
		float k = r * sinf(rads + a) + center.y;
		
		vertices[i*2] = j;
		vertices[i*2+1] =k;
	}
	vertices[(segs+1)*2] = center.x;
	vertices[(segs+1)*2+1] = center.y;
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
    //glDrawArrays(GL_LINE_STRIP, 0, segs+additionalSegment);
    
    BOOL isFill = TRUE;
    if(isFill){
        glDrawArrays(GL_TRIANGLE_FAN, 0, segs+additionalSegment); //fill color
    }
	free( vertices );
}

void drawCircleTexture( CGPoint center, float r, float a, int segs, BOOL drawLineToCenter)
{
    int additionalSegment = 1;
	if (drawLineToCenter)
		additionalSegment++;
    
	const float coef = 2.0f * (float)M_PI/segs;
	
	float *vertices = malloc( sizeof(float)*2*(segs+2));
	if( ! vertices )
		return;
	
	memset( vertices,0, sizeof(float)*2*(segs+2));
	
	for(int i=0;i<=segs;i++)
	{
		float rads = i*coef;
		float j = r * cosf(rads + a) + center.x;
		float k = r * sinf(rads + a) + center.y;
		
		vertices[i*2] = j;
		vertices[i*2+1] =k;
	}
	//vertices[(segs+1)*2] = center.x;
	//vertices[(segs+1)*2+1] = center.y;
	
	drawPointsM(vertices, segs);
    
	free( vertices );
}

void drawQuadBezierM(CGPoint origin, CGPoint control, CGPoint destination, int segments){
    drawQuadBezier(origin, control, destination, segments);
//    for(id mirrorType in [[ADProperties properties] mirrorTypes]){
//        int mirror = [mirrorType intValue];
//        if (mirror == ADMirrorTypeX) {
//            drawQuadBezier([ADUtils getMirrorX:origin], [ADUtils getMirrorX:control], [ADUtils getMirrorX:destination], segments);
//        }
//        else if (mirror == ADMirrorTypeY) {
//            drawQuadBezier([ADUtils getMirrorY:origin], [ADUtils getMirrorY:control], [ADUtils getMirrorY:destination], segments);
//        }
//        else if (mirror == ADMirrorTypeXY) {
//            drawQuadBezier([ADUtils getMirrorXY:origin], [ADUtils getMirrorXY:control], [ADUtils getMirrorXY:destination], segments);
//        }
//    }
}

void drawQuadBezierTexture(CGPoint origin, CGPoint control, CGPoint destination, int segments, int distance)
{
    CGPoint vertices[segments+1];
    float t = 0.0f;
    for(int i = 0; i < segments; i++)
    {
        float x = powf(1 - t, 2) * origin.x + 2.0f * (1 - t) * t * control.x + t * t * destination.x;
        float y = powf(1 - t, 2) * origin.y + 2.0f * (1 - t) * t * control.y + t * t * destination.y;
        vertices[i] = CGPointMake(x, y);
        
        t += 1.0f / segments;
    }
    vertices[segments] = destination;
    
    for (int i=0; i<segments; i++) {
        drawTextureLine(vertices[i], vertices[i+1], distance, TRUE);
    }
}

void drawQuadBezier(CGPoint origin, CGPoint control, CGPoint destination, int segments)
{
	CGPoint vertices[segments + 1];
	
	float t = 0.0f;
	for(int i = 0; i < segments; i++)
	{
		float x = powf(1 - t, 2) * origin.x + 2.0f * (1 - t) * t * control.x + t * t * destination.x;
		float y = powf(1 - t, 2) * origin.y + 2.0f * (1 - t) * t * control.y + t * t * destination.y;
		vertices[i] = CGPointMake(x, y);
		t += 1.0f / segments;
	}
	vertices[segments] = destination;
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_LINE_STRIP, 0, segments + 1);
}

void drawCubicBezierM(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, int segments){
    drawCubicBezier(origin, control1,control2, destination, segments);
//    for(id mirrorType in [[ADProperties properties] mirrorTypes]){
//        int mirror = [mirrorType intValue];
//        if (mirror == ADMirrorTypeX) {
//            drawCubicBezier([ADUtils getMirrorX:origin], [ADUtils getMirrorX:control1], [ADUtils getMirrorX:control2],[ADUtils getMirrorX:destination], segments);
//        }
//        else if (mirror == ADMirrorTypeY) {
//            drawCubicBezier([ADUtils getMirrorY:origin], [ADUtils getMirrorY:control1],[ADUtils getMirrorY:control2], [ADUtils getMirrorY:destination], segments);
//        }
//        else if (mirror == ADMirrorTypeXY) {
//            drawCubicBezier([ADUtils getMirrorXY:origin], [ADUtils getMirrorXY:control1],[ADUtils getMirrorXY:control2], [ADUtils getMirrorXY:destination], segments);
//        }
//    }
}

void drawCubicBezier(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, int segments)
{
	CGPoint vertices[segments + 1];
	
	float t = 0;
	for(int i = 0; i < segments; i++)
	{
		float x = powf(1 - t, 3) * origin.x + 3.0f * powf(1 - t, 2) * t * control1.x + 3.0f * (1 - t) * t * t * control2.x + t * t * t * destination.x;
		float y = powf(1 - t, 3) * origin.y + 3.0f * powf(1 - t, 2) * t * control1.y + 3.0f * (1 - t) * t * t * control2.y + t * t * t * destination.y;
		vertices[i] = CGPointMake(x, y);
		t += 1.0f / segments;
	}
	vertices[segments] = destination;
	
	glVertexPointer(2, GL_FLOAT, 0, vertices);
	glDrawArrays(GL_LINE_STRIP, 0, segments + 1);
}

void drawCubicBezierTexture(CGPoint origin, CGPoint control1, CGPoint control2, CGPoint destination, int segments, int size)
{
	CGPoint vertices[segments + 1];
	
	float t = 0;
	for(int i = 0; i < segments; i++)
	{
		float x = powf(1 - t, 3) * origin.x + 3.0f * powf(1 - t, 2) * t * control1.x + 3.0f * (1 - t) * t * t * control2.x + t * t * t * destination.x;
		float y = powf(1 - t, 3) * origin.y + 3.0f * powf(1 - t, 2) * t * control1.y + 3.0f * (1 - t) * t * t * control2.y + t * t * t * destination.y;
		vertices[i] = CGPointMake(x, y);
		t += 1.0f / segments;
	}
	vertices[segments] = destination;
	
    for (int i=0; i<segments; i++) {
        drawTextureLine(vertices[i], vertices[i+1], size, TRUE);
    }
    
}

@end

