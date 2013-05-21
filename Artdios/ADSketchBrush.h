//  ADSketchBrush.h
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADSketchBrush : NSObject<ADBrushProtocol>

+ (ADSketchBrush*)sharedInstance;

@end