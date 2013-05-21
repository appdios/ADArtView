//
//  ADBrushProperty.m
//  PhysicsPad
//
//  Created by Aditi Kamal on 7/2/12.
//
//

#import "ADBrushProperty.h"
#import "ADUtils.h"
#import "SMColor.h"

@implementation ADBrushProperty

+(id)sharedInstance
{
    static dispatch_once_t pred;
    static ADBrushProperty *sharedInstance = nil;
    dispatch_once(&pred, ^{
        sharedInstance = [[ADBrushProperty alloc] init];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"BrushDefaults" ofType:@"plist"];
        sharedInstance.root = [NSDictionary dictionaryWithContentsOfFile:path];
    });
    return sharedInstance;
}

+(ADBrushProperty *)currentBrushProperty{
    ADBrushProperty *brushProperty = [ADBrushProperty sharedInstance];
    ADProperties *properties = [ADProperties sharedInstance];
    BOOL isDefault = [properties isDefault];
    
    NSString *brushType = [ADUtils stringForBrushType:[[ADProperties sharedInstance] brushType]];
    NSDictionary *defaultObj = [brushProperty.root objectForKey:brushType];
    
    if(isDefault){
        brushProperty.isFill = [[defaultObj valueForKey:@"isfill"] boolValue];
        brushProperty.stroke = [defaultObj valueForKey:@"stroke"];
        brushProperty.width = [defaultObj valueForKey:@"width"];
    }
    else{
        SMColor *strokeColor = [properties smStrokeColor];
        UIColor *dStrokeColor = [defaultObj valueForKey:@"stroke"];
        
        NSDictionary *customObj = [NSDictionary dictionaryWithObjectsAndKeys:[defaultObj valueForKey:@"width"],@"width",
                                   [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithDouble:strokeColor.red],@"r",[NSNumber numberWithDouble:strokeColor.green],@"g",[NSNumber numberWithDouble:strokeColor.blue],@"b",[dStrokeColor valueForKey:@"a"],@"a", nil],@"stroke",[defaultObj valueForKey:@"isfill"],@"isfill", nil];
        
        brushProperty.isFill = [[customObj valueForKey:@"isfill"] boolValue];
        brushProperty.stroke = [customObj valueForKey:@"stroke"];
        brushProperty.width = [customObj valueForKey:@"width"];
    }
    return brushProperty;
}

@end
