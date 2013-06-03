//
//  ADTextBrush.h
//  Artdios
//
//  Created by Aditi Kamal on 5/24/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//

@interface ADTextBrush : NSObject<ADBrushProtocol, UITextViewDelegate>

+ (ADTextBrush*)sharedInstance;
@end