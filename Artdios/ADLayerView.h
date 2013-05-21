//
//  ADLayerView.h
//
//  Created by Sumit Kumar on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGLDrawable.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES1/gl.h>
#import <OpenGLES/ES1/glext.h>

@interface ADLayerView : UIView{
    GLint backingWidth, backingHeight;
}

@property(nonatomic, strong) EAGLContext *context;
@property(nonatomic, assign) GLuint viewRenderbuffer, viewFramebuffer, depthRenderbuffer;

- (void)setupContext;
- (void) erase;
- (UIImage *) snapshot;
- (UIImage*) regionInRect:(CGRect)rectClip alpha:(double)alpha;
@end
