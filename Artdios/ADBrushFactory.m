//
//  ADBrushFactory.m
//
//  Created by Sumit Kumar on 5/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADBrushFactory.h"
#import "ADWebBrush.h"
#import "ADCurvyBrush.h"
#import "ADRibbonBrush.h"
#import "ADSketchBrush.h"
#import "ADArcBrush.h"
#import "ADShadeBrush.h"
#import "ADGridBrush.h"
#import "ADEraserBrush.h"
#import "ADStencilBrush.h"
#import "ADFurBrush.h"
#import "ADFillBrush.h"
#import "ADUtils.h"
#import "ADProperties.h"
#import "ADPenBrush.h"
#import "ADInkBrush.h"
#import "ADTextBrush.h"
#import "ADConcentricCircleBrush.h"

@implementation ADBrushFactory

+(id)currentBrushInstance{
    switch ([[ADProperties sharedInstance] brushType]) {
        case ADBrushTypeWeb:
            return [ADWebBrush sharedInstance];
            break;
        case ADBrushTypeConcentricCircle:
            return [ADConcentricCircleBrush sharedInstance];
            break;
//        case ADBrushTypeCurvy:
//            return [ADCurvyBrush sharedInstance];
//            break;
        case ADBrushTypeRibbon:
            return [ADRibbonBrush sharedInstance];
            break;
        case ADBrushTypePen:
            return [ADPenBrush sharedInstance];
            break;
        case ADBrushTypeSketch:
            return [ADSketchBrush sharedInstance];
            break;
        case ADBrushTypeArc:
            return [ADArcBrush sharedInstance];
            break;
        case ADBrushTypeShade:
            return [ADShadeBrush sharedInstance];
            break;
        case ADBrushTypeGrid:
            return [ADGridBrush sharedInstance];
            break;
        case ADBrushTypeEraser:
            return [ADEraserBrush sharedInstance];
            break;
        case ADBrushTypeFur:
            return [ADFurBrush sharedInstance];
            break;
//        case ADBrushTypeStencil:
//            return [ADStencilBrush sharedInstance];
//            break;
        case ADBrushTypeFill:
            return [ADFillBrush sharedInstance];
            break;
        case ADBrushTypeInk:
            return [ADInkBrush sharedInstance];
            break;
        case ADBrushTypeText:
            return [ADTextBrush sharedInstance];
            break;
        default:
            break;
    }
    return nil;
}

@end

























