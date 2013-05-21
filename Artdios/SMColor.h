//
//  SMColor.h
//
//  Created by Sumit Kumar on 12/29/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SMColor : NSObject  <NSCopying> 
	
@property  (nonatomic) double alpha;
@property  (nonatomic) double red;
@property  (nonatomic) double green;
@property  (nonatomic) double blue;

- (id) initWithRed:(double)r green:(double)g blue:(double)b alpha:(double)a;

@end
