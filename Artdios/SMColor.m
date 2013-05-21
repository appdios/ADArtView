//
//  SMColor.m
//
//  Created by Sumit Kumar on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "SMColor.h"

@implementation SMColor

- (id) initWithRed:(double)r green:(double)g blue:(double)b alpha:(double)a{
    self = [super init];
	if (self) {
        self.alpha = a;
        self.red = r;
        self.green = g;
        self.blue = b;
    }
	return self;
}

- (id) init
{
	if ((self = [super init]) == nil) {
        return nil;
    }
	self.alpha = 1.0;
	self.red = 1.0;
	self.green = 1.0;
	self.blue = 1.0;
	return self;
}

- (id)copyWithZone:(NSZone *)zone
{
	SMColor *color = [[[self class] allocWithZone:zone] init];
	color.alpha = self.alpha;
	color.red = self.red;
	color.green = self.green;
	color.blue = self.blue;
	
	return color;
}

@end
