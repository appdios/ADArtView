//
//  SMPoint.m
//  Artdios
//
//  Created by Aditi Kamal on 5/8/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//

#import "SMPoint.h"

@implementation SMPoint

- (id)initWithSnapPoint:(CGPoint)sPoint
{
    self = [super init];
    if (self) {
        self.x = sPoint.x;
        self.y = sPoint.y;
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	SMPoint *copy = [[[self class] allocWithZone:zone] init];
	copy.x=self.x;
    copy.y=self.y;
	return copy;
}

@end

