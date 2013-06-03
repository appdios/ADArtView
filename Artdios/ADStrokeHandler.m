//
//  ADStrokeHandler.m
//  SketchStudio
//
//  Created by Sumit Kumar on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADStrokeHandler.h"
#import "ADBrushFactory.h"
#import "Texture2D.h"
#import "ADBrushProperty.h"
#import "SMColor.h"

@interface ADStrokeHandler()
@end

@implementation ADStrokeHandler

- (id)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)drawImage:(UIImage*)image atPoint:(CGPoint)point
{
    glColor4f(1, 1, 1, 1);
    glEnable(GL_BLEND);
    glEnable(GL_TEXTURE_2D);
    glEnableClientState(GL_TEXTURE_COORD_ARRAY);
    glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
    
    Texture2D *backImage = [[Texture2D alloc] initWithImage:image];
    [backImage drawAtPoint:point];
    [self display];
}

- (void)display
{
	glBindRenderbufferOES(GL_RENDERBUFFER_OES, self.viewRenderbuffer);
	[self.context presentRenderbuffer:GL_RENDERBUFFER_OES];
}


- (void)setBrushProperty
{
    int brushType = [[ADProperties sharedInstance] brushType];
    
    glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    glEnable(GL_BLEND);
    glEnable(GL_TEXTURE_2D);
    if(brushType == ADBrushTypeEraser){
        //glDisable(GL_TEXTURE_2D);
        //   glBlendFunc(GL_ONE, GL_ZERO);
        //   glBlendFunc(GL_ZERO, GL_ZERO);
        // glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_DST_ALPHA);
        glBlendFunc(GL_ZERO, GL_ZERO);
         //glBlendFunc(GL_ONE, GL_ONE_MINUS_DST_ALPHA);
    }
    else if(brushType == ADBrushTypeFill)
    {
        ADProperties *properties = [ADProperties sharedInstance];
        if (properties.stencilImage==nil) {
            UIImage *stencilImg = [UIImage imageNamed:@"Watercolor-fill"];
            
            properties.stencilImage=nil;
            properties.stencilImage = [[Texture2D alloc] initWithTextureImage:stencilImg];
        }
        
        
        //glDisable(GL_BLEND);
        glEnable(GL_TEXTURE_2D);
        glBlendFunc(GL_SRC_ALPHA_SATURATE, GL_ONE_MINUS_SRC_ALPHA);
        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        // glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
        //  glBlendFunc(GL_SRC_ALPHA, GL_ONE);
        
    }
//    else if(brushType == ADBrushTypeStencil)
//    {
//        NSLog(@"todo");
////        ADProperties *properties = [ADProperties sharedInstance];
////        if (properties.stencilImage==nil) {
////            ADBrushMenuViewController *brushMenu  = [ADBrushMenuViewController sharedInstance];
////            [brushMenu setTextureImage];
////        }
////        
////        
////        glEnable(GL_BLEND);
////        glEnable(GL_TEXTURE_2D);
////        glBlendFunc(GL_SRC_ALPHA_SATURATE, GL_ONE_MINUS_SRC_ALPHA);
////        
////        glEnableClientState(GL_TEXTURE_COORD_ARRAY);
//    }
    else
    {
        if (brushType == ADBrushTypeGrid)
        {
            glDisable(GL_TEXTURE_2D);
            glBlendFunc(GL_SRC_ALPHA_SATURATE, GL_ONE_MINUS_SRC_ALPHA);
        }
//        else  if (brushType == ADBrushTypeCalligraphy)
//        {
//            glBlendFunc(GL_ONE,GL_ONE_MINUS_SRC_ALPHA);
//        }
        /* else  if (brushType == ADBrushTypeWeb)
         {
         glBlendFunc(GL_SRC_ALPHA_SATURATE, GL_ONE_MINUS_SRC_ALPHA);
         }*/
        else  if (brushType == ADBrushTypeText)
        {
            glEnable(GL_TEXTURE_2D);
            glEnable(GL_BLEND);
            glBlendFunc (GL_ONE, GL_ONE);
            glEnableClientState(GL_TEXTURE_COORD_ARRAY);
        }
        else  if (
                  (
                  brushType == ADBrushTypeInk)
        ||
         (brushType == ADBrushTypeSketch)||
         (brushType == ADBrushTypeFur)||
                  (brushType == ADBrushTypeRibbon)||
                  (brushType == ADBrushTypePen)
                  ||(brushType == ADBrushTypeArc)
                  ||(brushType == ADBrushTypeWeb)
                  ||(brushType == ADBrushTypeConcentricCircle)
                  ||(brushType == ADBrushTypeShade)
                  ||(brushType == ADBrushTypeCrayon)
                  )
        {
            glBlendFunc(GL_ONE, GL_ONE_MINUS_SRC_ALPHA);
            
        }
        else
        {
            glBlendFunc(GL_SRC_ALPHA_SATURATE, GL_ONE_MINUS_SRC_ALPHA);
        }
    }
    
    [self setColor];
}

- (void)setColor
{
    ADProperties *property = [ADProperties sharedInstance];
    SMColor *smcolor = property.smStrokeColor;
    CGFloat scale = [[UIScreen mainScreen] scale];

    ADBrushProperty *currentBrushProperty = [ADBrushProperty currentBrushProperty];
    glLineWidth([[currentBrushProperty width] floatValue] * scale);
    glPointSize([[currentBrushProperty width] floatValue] * scale);
    
    glColor4f(smcolor.red,smcolor.green,smcolor.blue,0.5);
}

- (void)pathStart:(CGPoint)point
{
    [self setBrushProperty];
    id currentBrushInstance = [ADBrushFactory currentBrushInstance];
    [currentBrushInstance pathStart:point];
    
    [self display];
}

- (void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed
{
    if (begin.x == end.x && begin.y == end.y) {
        return;
    }
    
    id currentBrushInstance = [ADBrushFactory currentBrushInstance];
    [currentBrushInstance pathMoveFromPoint:begin toPoint:end speed:speed];
    
    // Display the buffer
	[self display];
}

- (void) pathEnd:(CGPoint)point
{
}

//-(void) drawStencil:(CGPoint)point
//{
//    id stencil = [ADStencilBrush sharedInstance];
//    [stencil pathStart:point];
//    
//    // Display the buffer
//	[self display];
//}

@end
