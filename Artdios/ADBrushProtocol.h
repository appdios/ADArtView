//
//  ADBrushProtocol.h
//
//  Created by Sumit Kumar on 5/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ADBrushProtocol <NSObject>
@required
-(void) pathStart:(CGPoint)point;
-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed;

@optional
-(void) pathEnd:(CGPoint)point;
//-(void) pathStart:(CGPoint)point layer:(ADLayerView*)currentLayer;
@end
