//
//  SMPainter.m
//
//  Created by Aditi Kamal on 5/6/12.
//  Copyright (c) 2012 InnoPath Software Inc. All rights reserved.
//

#import "SMPainter.h"
#define kRandomPainter (arc4random() % 11) * 0.07//0.1

@interface SMPainter()


@end

@implementation SMPainter
@synthesize dp,ap,div,ease,currentPoint;

-(id)initWithPoints:(CGPoint)dpPoint ap:(CGPoint)apPoint forBrush:(ADBrushType)brushType{
    self = [super init];
    if (self){
        self.currentPoint = dpPoint;
        self.ap = apPoint;
        self.dp = dpPoint;
        if (brushType==ADBrushTypeRibbon) {
            div = 0.15;
            ease = kRandomPainter * 0.16 + 0.6;
        }
        else
        {
            self.div = 0.25;
            self.ease = kRandomPainter * 0.04 + 0.6;
        }
        
    }
    return self;
} 

@end
