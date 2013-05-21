//
//  ADBrushProperty.h
//  PhysicsPad
//
//  Created by Aditi Kamal on 7/2/12.
//
//

#import <Foundation/Foundation.h>

@interface ADBrushProperty : NSObject
@property(nonatomic) BOOL isFill;
@property(nonatomic, strong) NSDictionary *stroke;
@property(nonatomic, strong) NSNumber *width;
@property(nonatomic, strong) id root;
+(ADBrushProperty *)currentBrushProperty;
@end
