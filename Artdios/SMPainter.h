//
//  SMPainter.h
//  DrawLines
//
//  Created by Aditi Kamal on 5/6/12.
//  Copyright (c) 2012 InnoPath Software Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMPainter : NSObject

@property(nonatomic)CGPoint ap;
@property(nonatomic)CGPoint dp;
@property(nonatomic)CGPoint currentPoint;
@property(nonatomic)double div;
@property(nonatomic)double ease;

-(id)initWithPoints:(CGPoint)point ap:(CGPoint)apPoint forBrush:(ADBrushType)brushType;

@end
