//
//  ADTextBrush.m
//  Artdios
//
//  Created by Aditi Kamal on 5/24/13.
//  Copyright (c) 2013 Appdios Inc. All rights reserved.
//

#import "ADTextBrush.h"
#import "Texture2D.h"

@interface ADTextBrush()

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic) CGPoint currentPoint;
@property (nonatomic) CGFloat textViewHeight;
@property (nonatomic) BOOL backPressed;
@end

@implementation ADTextBrush

+ (ADTextBrush*)sharedInstance
{
    static dispatch_once_t once;
    static ADTextBrush *sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.textView = [[UITextView alloc] init];
        sharedInstance.textView.font = [UIFont fontWithName:@"Marker Felt" size:28];
        sharedInstance.textView.textAlignment = NSTextAlignmentLeft;
        sharedInstance.textView.backgroundColor = [UIColor clearColor];
        
        ADProperties *property = [ADProperties sharedInstance];
        SMColor *smcolor = property.smStrokeColor;
        sharedInstance.textView.textColor = [UIColor colorWithRed:smcolor.red green:smcolor.green blue:smcolor.blue alpha:1.0];
    });
    return sharedInstance;
}

-(void) pathStart:(CGPoint)point
{
    if (self.textView.superview) {
        [self.textView resignFirstResponder];
        [self.textView removeFromSuperview];
        return;
    }
    self.textView.text = @"";
    self.currentPoint = point;
    
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    CGFloat scale = [[UIScreen mainScreen] scale];
    self.textViewHeight = 48;
    self.textView.frame = CGRectMake(point.x/scale, (screenBounds.size.height*scale - point.y)/scale - self.textViewHeight/2, 20, self.textViewHeight);
    self.textView.delegate = self;
    
    UIView *superView = [[[UIApplication sharedApplication].keyWindow subviews] lastObject];
    [superView addSubview:self.textView];
    [self.textView becomeFirstResponder];
}

-(void)pathMoveFromPoint:(CGPoint)begin toPoint:(CGPoint)end speed:(double)speed{
    
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text length]==0) {
        self.backPressed = TRUE;
    }
    else
    {
        self.backPressed = FALSE;
    }
    if ([[NSCharacterSet newlineCharacterSet] characterIsMember:[text characterAtIndex:text.length-1]])
    {
        self.textViewHeight += [@"K" sizeWithFont:textView.font].height;
        [textView setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textView.frame.size.width, self.textViewHeight)];
    }
    else{
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        CGSize textSize = [[textView.text stringByAppendingString:text] sizeWithFont:textView.font constrainedToSize:CGSizeMake(screenBounds.size.width - textView.frame.origin.x - 20, 500) lineBreakMode:NSLineBreakByWordWrapping];
        [textView setFrame:CGRectMake(textView.frame.origin.x, textView.frame.origin.y, textSize.width + 20, textView.contentSize.height)];
        
    }
    
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.backPressed) {
        CGRect frame = textView.frame;
        frame.size.height = textView.contentSize.height;
        textView.frame = frame;
    }
    
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([textView.text length]) {
        ADProperties *property = [ADProperties sharedInstance];
        SMColor *smcolor = property.smStrokeColor;
        glColor4f(smcolor.red,smcolor.green,smcolor.blue,1.0);
        CGRect screenBounds = [UIScreen mainScreen].bounds;
        CGFloat scale = [[UIScreen mainScreen] scale];

        Texture2D *textTex = [[Texture2D alloc] initWithString:textView.text
                                                    dimensions:CGSizeMake(self.textView.frame.size.width * scale, self.textView.frame.size.height * scale)
                                                     alignment:NSTextAlignmentLeft
                                                      fontName:textView.font.fontName fontSize:textView.font.pointSize * scale];
        
        [textTex drawAtPoint:CGPointMake((self.textView.center.x + 8) * scale, (screenBounds.size.height - self.textView.center.y - 28) * scale)];
    }
    return TRUE;
}

@end