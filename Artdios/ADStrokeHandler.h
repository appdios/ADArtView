//
//  ADStrokeHandler.h
//
//  Created by Sumit Kumar on 5/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ADStrokeHandler : NSObject

@property (nonatomic, weak) EAGLContext *context;
@property (nonatomic, assign) GLuint viewFramebuffer, viewRenderbuffer;

- (void)pathStart:(CGPoint)point;
- (void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed;
- (void)drawImage:(UIImage*)image atPoint:(CGPoint)point;

@end
