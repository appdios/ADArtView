//
//  ADEnums.h
//  Artdios
//
//  Created by Aditi Kamal on 5/19/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//

#ifndef Artdios_ADEnums_h
#define Artdios_ADEnums_h

typedef enum{
    ADMirrorTypeNone = 1<<0,
    ADMirrorTypeX = 1<<1,
    ADMirrorTypeY = 1<<2,
    ADMirrorTypeDiagonal = 1<<3
}ADMirrorType;

typedef enum{
    ADBrushTypePattern,
    ADBrushTypeWeb,
    ADBrushTypeCurvy,
    ADBrushTypeRibbon,
    ADBrushTypeSquare,
    ADBrushTypeSketch,
    ADBrushTypeArc,
    ADBrushTypeCycloid,
    ADBrushTypeSpray,
    ADBrushTypeConcentricCircle,
    ADBrushTypeCalligraphy,
    ADBrushTypeFlower,
    ADBrushTypeCircle,
    ADBrushTypeShade,
    ADBrushTypeGrid,
    ADBrushTypeEraser,
    ADBrushTypeStencil,
    ADBrushTypeSCircle,
    ADBrushTypeSRectangle,
    ADBrushTypeFur,
    ADBrushTypeCrayon,
    ADBrushTypeFill,
    ADBrushTypeInk,
    ADBrushTypePen
}ADBrushType;

#endif
