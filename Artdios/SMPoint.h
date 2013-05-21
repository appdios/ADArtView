//
//  SMPoint.h
//  Artdios
//
//  Created by Aditi Kamal on 5/8/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMPoint : NSObject 
@property (nonatomic)double x;
@property (nonatomic)double y;
- (id) initWithSnapPoint:(CGPoint)sPoint;

@end
