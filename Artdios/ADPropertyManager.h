//
//  ADPropertyManager.h
//
//  Created by Aditi Kamal on 7/11/12.
//
//

#import <Foundation/Foundation.h>
#import "Texture2D.h"

@interface ADPropertyManager : NSObject{
    GLuint  brushTexture;
}
-(void) addTexture:(UIImage*)textureImage;
-(void) removeTexture;
@end
