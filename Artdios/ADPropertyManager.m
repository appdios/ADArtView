//
//  ADPropertyManager.m
//  PhysicsPad
//
//  Created by Aditi Kamal on 7/11/12.
//
//

#import "ADPropertyManager.h"
#import <OpenGLES/ES1/gl.h>

@implementation ADPropertyManager

-(void) addTexture:(UIImage*)textureImage
{
    glEnable(GL_TEXTURE_2D);
    [self setTexture:textureImage];
}


-(void)setTexture:(UIImage*)textureImg{
    if (brushTexture)
	{
		glDeleteTextures(1, &brushTexture);
		brushTexture = 0;
	}
    CGImageRef		brushImage;
    CGContextRef	brushContext;
    GLubyte			*brushData;
    size_t			width, height;
    
    
    brushImage = textureImg.CGImage;
    
    width = CGImageGetWidth(brushImage);
    height = CGImageGetHeight(brushImage);
    
    if(brushImage) {
        brushData = (GLubyte *) calloc(width * height * 4, sizeof(GLubyte));
        brushContext = CGBitmapContextCreate(brushData, width, height, 8, width * 4, CGImageGetColorSpace(brushImage), kCGImageAlphaPremultipliedLast);
        CGContextDrawImage(brushContext, CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height), brushImage);
        CGContextRelease(brushContext);
        glGenTextures(1, &brushTexture);
        glBindTexture(GL_TEXTURE_2D, brushTexture);
        glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
        glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE, brushData);
        
        free(brushData);
    }
    //glPointSize(width);
}

-(void) removeTexture
{
    if (brushTexture)
	{
		glDeleteTextures(1, &brushTexture);
		brushTexture = 0;
    }
}

-(void) dealloc
{
    if (brushTexture)
	{
		glDeleteTextures(1, &brushTexture);
		brushTexture = 0;
    }
}

@end
