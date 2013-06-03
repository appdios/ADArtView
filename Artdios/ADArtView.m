//
//  ADArtView.m
//  Artdios
//
//  Created by Aditi Kamal on 5/19/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//

#import "ADArtView.h"
#import "ADLayerView.h"
#import "ADStrokeHandler.h"
#import "ADPropertyManager.h"
#import "ADUtils.h"
#import "ADProperties.h"
#import "SMColor.h"

static const NSInteger kHistoryThreshold  = 30;
@interface ADArtView ()
{
    CGPoint location;
    NSTimeInterval previousTimestamp, endTimeStamp;
    double oldSpeed;
}
@property (nonatomic, strong) ADLayerView *currentLayer;
@property (nonatomic, strong) ADStrokeHandler *strokeHandler;
@property (nonatomic, strong) ADPropertyManager *propertyManager;
@property (nonatomic, strong) UIImage *snapshotImage;
@property (nonatomic, strong) NSMutableArray *historyArts;
@property (nonatomic) BOOL appVerified;;
@end

@implementation ADArtView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaults];
        [self checkAppInfo];
    }
    return self;
}

- (id)initWithBackroundImage:(UIImage*)image
{
    self = [super init];
    if (self) {
        self.snapshotImage = image;
    }
    return self;
}

- (void)setBrushType:(ADBrushType)brushType
{
    [[ADProperties sharedInstance] setBrushType:brushType];
    [self brushChanged];
}

- (void)setBrushColor:(UIColor*)color
{
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha =0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    SMColor *sColor = [[ADProperties sharedInstance] smStrokeColor];
    sColor.red = red;
    sColor.green = green;
    sColor.blue = blue;
    sColor.alpha = alpha;
}

- (void)setMirrorType:(ADMirrorType)mirrorType
{
    [[ADProperties sharedInstance] setMirrorType:mirrorType];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.currentLayer.backgroundColor = backgroundColor;
}

- (void)undo
{
    if ([self.historyArts count]) {
        [self.historyArts removeObjectAtIndex:0];
        if ([self.historyArts count]) {
            self.snapshotImage  = [self.historyArts objectAtIndex:0];
            [self.strokeHandler drawImage:self.snapshotImage atPoint:self.center];
            [self.delegate artView:self imageDidChange:self.snapshotImage];
        }
    }
}

-(void) addArt:(UIImage*)art
{
    if (self.historyArts==nil) {
        self.historyArts = [NSMutableArray array];
    }
    
    if ([self.historyArts count]>=kHistoryThreshold) {
        [self.historyArts removeLastObject];
    }
    [self.historyArts insertObject:art atIndex:0];
}

- (void)setDefaults
{
    self.appVerified = TRUE;
    self.strokeHandler = [[ADStrokeHandler alloc] init];
    self.propertyManager = [[ADPropertyManager alloc] init];
        
    self.currentLayer = [[ADLayerView alloc] init];
    [self addSubview:self.currentLayer];
    
    [[ADProperties sharedInstance] setBrushType:ADBrushTypeInk];
}

- (void)checkAppInfo
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    if ([appName length]) {
        NSURLRequest *urlRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.appdios.com/artview/verify.html?%@",appName]]];
        [NSURLConnection sendAsynchronousRequest:urlRequest queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
            if (error==nil) {
                NSString *responseString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",[responseString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]]);
                if ([[responseString stringByTrimmingCharactersInSet:[NSCharacterSet newlineCharacterSet]] isEqualToString:@"0"]) {
                    self.appVerified = FALSE;
                }
            }
        }];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    self.currentLayer.frame = self.bounds;
    [self.currentLayer setupContext];
}

- (void)didMoveToSuperview
{
    [super didMoveToWindow];
    [self performSelector:@selector(setLayer:) withObject:self.snapshotImage afterDelay:0.1];
}

- (void) setLayer:(UIImage*)image
{
    [self updateStrokeHandler];
    if (image) {
        [self.strokeHandler drawImage:image atPoint:CGPointMake(self.center.x * self.currentLayer.contentScaleFactor, self.center.y * self.currentLayer.contentScaleFactor)];
    }
    [self brushChanged];
}

- (void)updateStrokeHandler
{
    self.strokeHandler.context = self.currentLayer.context;
    self.strokeHandler.viewFramebuffer = self.currentLayer.viewFramebuffer;
    self.strokeHandler.viewRenderbuffer = self.currentLayer.viewRenderbuffer;
    glClearColor(0,0,0,0);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
}

- (void) brushChanged
{
    [self.propertyManager addTexture:[UIImage imageNamed:@"artview.bundle/particle"]];
}

#pragma mark -
#pragma mark touch events

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count]>1) {
        return;
    }
    if (!self.appVerified) {
        return;
    }
    
    CGRect	bounds = [self.currentLayer bounds];
    UITouch*	touch = [[event touchesForView:self.currentLayer] anyObject];
	location = [touch locationInView:self.currentLayer];
	location.y = bounds.size.height - location.y;
    
    if (location.x == 0) {
        return;
    }
    
    [self.strokeHandler pathStart:CGPointMake(location.x * self.currentLayer.contentScaleFactor, location.y * self.currentLayer.contentScaleFactor)];
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count]>1) {
        return;
    }
    if (!self.appVerified) {
        return;
    }
    
    CGRect bounds = [self.currentLayer bounds];
	UITouch *touch = [[event touchesForView:self.currentLayer] anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self.currentLayer];
    previousLocation.y = bounds.size.height - previousLocation.y;
    
    location = [touch locationInView:self.currentLayer];
    location.y = bounds.size.height - location.y;
    
    [self drawFrom:CGPointMake(previousLocation.x * self.currentLayer.contentScaleFactor, previousLocation.y * self.currentLayer.contentScaleFactor) toPoint:CGPointMake(location.x * self.currentLayer.contentScaleFactor, location.y * self.currentLayer.contentScaleFactor) withEvent:event];
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([touches count]>1) {
        return;
    }
    if (!self.appVerified) {
        return;
    }
    CGRect bounds = [self.currentLayer bounds];
	UITouch *touch = [[event touchesForView:self.currentLayer] anyObject];
    CGPoint previousLocation = [touch previousLocationInView:self.currentLayer];
    previousLocation.y = bounds.size.height - previousLocation.y;
    
    location = [touch locationInView:self.currentLayer];
    location.y = bounds.size.height - location.y;
    
    [self drawFrom:CGPointMake(previousLocation.x * self.currentLayer.contentScaleFactor, previousLocation.y * self.currentLayer.contentScaleFactor) toPoint:CGPointMake(location.x * self.currentLayer.contentScaleFactor, location.y * self.currentLayer.contentScaleFactor) withEvent:event];
    self.snapshotImage = [self.currentLayer snapshot];
    
    endTimeStamp = event.timestamp;
    
    [self.delegate artView:self imageDidChange:self.snapshotImage];
    [self addArt:self.snapshotImage];
}

- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self touchesEnded:touches withEvent:event];
}

- (void) drawFrom:(CGPoint)startPoint toPoint:(CGPoint)endPoint withEvent:(UIEvent *)event
{
    CGFloat distanceFromPrevious = [ADUtils distance:endPoint withPoint:startPoint];
    NSTimeInterval timeSincePrevious = event.timestamp - previousTimestamp;
    
    const float lambda = 0.99f; // the closer to 1 the higher weight to the next touch
    
    double newSpeed = (1.0 - lambda) * oldSpeed + lambda * (distanceFromPrevious/timeSincePrevious);
    oldSpeed = newSpeed;
    [self.strokeHandler pathMoveFromPoint:startPoint toPoint:endPoint speed:newSpeed];
    previousTimestamp = event.timestamp;
}

@end
