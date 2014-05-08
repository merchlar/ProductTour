//
//  CRProductTour.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRProductTour.h"
#import "UIView+Glow.h"

#define ANIMATION_TRANSLATION 30
#define ANIMATION_DURATION 0.25

@interface CRProductTour ()

//@property (copy) void (^completionBlock)(BOOL finished);

@end

@implementation CRProductTour
static BOOL tourVisible=YES;
//static BOOL activeAnimation=YES; //Active bubbles translations and animatins for dismiss/appear
static NSMutableArray *arrayOfAllocatedTours;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.bubblesArray = [[NSMutableArray alloc] init];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setUserInteractionEnabled:NO];
        self.activeAnimation = YES;
    }
    if(arrayOfAllocatedTours==nil)
        arrayOfAllocatedTours = [[NSMutableArray alloc]init];
    [arrayOfAllocatedTours addObject:self];
    return self;
}

-(void)setBubbles:(NSMutableArray*)arrayOfBubbles
{
    self.bubblesArray=arrayOfBubbles;
    
    
    for (CRBubble *bubble in self.bubblesArray)
    {
        if(bubble.attachedView!=nil)
        {
            [self addSubview:bubble];
            if(!tourVisible)
                [bubble setAlpha:0.0];
            else if (bubble.glowEnable)
                [bubble.attachedView startGlowingWithColor:bubble.glowColor intensity:1.0 duration:1.0 repeat:30];

        }
    }
}

//-(void)setVisible:(bool)visible
//{
//    [self setVisible:visible completion:^(BOOL finished) {
//        
//    }];
//}

-(void)setVisible:(bool)visible completion:(void(^)(BOOL finished))completion {
    
    tourVisible=visible;
    
//    self.completionBlock = completion;
    
    [self refreshBubblesVisibilityWithCompletion:completion];

}

-(BOOL)isVisible
{
    return tourVisible;
}

-(void)makeDismissAnimation:(CRBubble*)bubble completion:(void(^)(BOOL finished))completion
{
    
    __typeof(self) __weak weakSelf = self;

    
    if(_activeAnimation)
    {
        CGAffineTransform moveTransform;
        if(bubble.arrowPosition == CRArrowPositionRight)
            moveTransform = CGAffineTransformMakeTranslation(+bubble.frame.size.width/2.0+CR_ARROW_SPACE+CR_ARROW_SIZE, -CR_ARROW_SIZE/2);
        else if(bubble.arrowPosition == CRArrowPositionLeft)
            moveTransform = CGAffineTransformMakeTranslation(-bubble.frame.size.width/2.0-(CR_ARROW_SPACE+CR_ARROW_SIZE), -CR_ARROW_SIZE/2);
        else if(bubble.arrowPosition == CRArrowPositionBottom)
            moveTransform = CGAffineTransformMakeTranslation(-CR_ARROW_SIZE/2, +bubble.frame.size.height/2.0+CR_ARROW_SPACE+CR_ARROW_SIZE);
        else
            moveTransform = CGAffineTransformMakeTranslation(-CR_ARROW_SIZE/2, -bubble.frame.size.height/2.0-(CR_ARROW_SPACE+CR_ARROW_SIZE));
        
        CGAffineTransform scaleTransform = CGAffineTransformScale(moveTransform, 0.1, 0.1);
        
        
        
        
        [UIView animateWithDuration:ANIMATION_DURATION
                              delay:0.0
                            options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                         animations:^{
                             bubble.transform = scaleTransform;
                             [bubble setAlpha:0.0];
                         }
                         completion:^(BOOL finished){
                             
                             [CATransaction begin];
                             
                             [CATransaction setCompletionBlock:^{
                                 completion(YES);
//                                 completion = nil;
                             }];
                             
                             CABasicAnimation* scaleDown2 = [CABasicAnimation animationWithKeyPath:@"transform"];
                             scaleDown2.duration = 0.2;
                             scaleDown2.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.15, 1.15, 1.15)];
                             scaleDown2.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1, 1, 1)];
                             [bubble.attachedView.layer addAnimation:scaleDown2 forKey:nil];
                             [bubble.attachedView stopGlowing];

                             
                             [CATransaction commit];
                         }];
    }
    else
    {
        
        [UIView animateWithDuration:ANIMATION_DURATION
                         animations:^{
                             [bubble setAlpha:0.0];
                         } completion:^(BOOL finished) {
                             completion(YES);
//                             completion = nil;
                         }];
    }
    
    
    
}

-(void)makeAppearAnimation:(CRBubble*)bubble completion:(void(^)(BOOL finished))completion;
{
    
    __typeof(self) __weak weakSelf = self;

    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
        bubble.transform=CGAffineTransformIdentity;
        [bubble setAlpha:1.0];
    } completion:^(BOOL finished) {
        if (bubble.glowEnable)
            [bubble.attachedView startGlowingWithColor:bubble.glowColor intensity:1.0 duration:1.0 repeat:30];
        completion(YES);
//        completion = nil;
    }];
}

-(void) refreshBubblesVisibilityWithCompletion:(void(^)(BOOL finished))completion
{
    for(CRProductTour *tour in arrayOfAllocatedTours)
    {
        for (CRBubble *bubble in tour.bubblesArray)
        {
            if(tourVisible)
            {
                
                [self makeAppearAnimation:bubble completion:completion];
                
            }
            else
            {
                
                [self makeDismissAnimation:bubble completion:completion];
                
            }
        }
        if ([tour.bubblesArray count] == 0) {
            completion(YES);
//            completion = nil;
        }
    }
}

-(void)dealloc
{
    [arrayOfAllocatedTours removeObject:self];
}


@end
