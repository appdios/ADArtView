//
//  ADPenBrush.h
//  Artdios
//
//  Created by Aditi Kamal on 5/20/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//

#import "ADBrushProtocol.h"

@interface ADPenBrush : NSObject<ADBrushProtocol>

+ (ADPenBrush*)sharedInstance;
@end
