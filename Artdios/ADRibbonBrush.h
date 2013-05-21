//
//  ADRibbonBrush.h
//  SketchStudio
//
//  Created by Sumit Kumar on 5/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ADBrushProtocol.h"

@interface ADRibbonBrush : NSObject<ADBrushProtocol>

+ (ADRibbonBrush*)sharedInstance;
@end
