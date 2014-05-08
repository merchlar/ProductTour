//
//  CRProductTour.h
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CRBubble.h"

//typedef void(^CRProductTourCallbackCompletionBlock)(BOOL finished);


@interface CRProductTour : UIView

@property (nonatomic, strong)  NSMutableArray *bubblesArray;
@property BOOL activeAnimation;

-(void)setBubbles:(NSMutableArray*)arrayOfBubbles;
//-(void)setVisible:(bool)visible;
-(BOOL)isVisible;

-(void)setVisible:(bool)visible completion:(void(^)(BOOL finished))completion;
@end
