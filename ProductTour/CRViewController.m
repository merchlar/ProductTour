//
//  CRViewController.m
//  ProductTour
//
//  Created by Clément Raussin on 12/02/2014.
//  Copyright (c) 2014 Clément Raussin. All rights reserved.
//

#import "CRViewController.h"

@interface CRViewController ()

@end

@implementation CRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self.appTitle setFont:[UIFont fontWithName:@"BebasNeue" size:40]];
    
    productTourView = [[CRProductTour alloc] initWithFrame:self.view.frame] ;
    
    //SET BUBBLES TOUR VIEWS
    
//    CRBubble *bubbleNavBarButton = [[CRBubble alloc] initWithBar:self.navigationController.navigationBar buttonPosition:1 title:@"" description:@"TEST TEST TEST" arrowPosition:CRArrowPositionTop andColor:nil andGlow:YES];
//    
//    CRBubble *bubbleTabBarButton = [[CRBubble alloc] initWithBar:self.tabBarController.tabBar buttonPosition:0 title:@"" description:@"TEST TEST TEST" arrowPosition:CRArrowPositionBottom andColor:nil andGlow:YES];
//    
//    CRBubble *bubbleTabBarButton2 = [[CRBubble alloc] initWithBar:self.tabBarController.tabBar buttonPosition:1 title:@"" description:@"TEST TEST TEST" arrowPosition:CRArrowPositionBottom andColor:nil andGlow:NO];
//
//    CRBubble *bubbleButton1 = [[CRBubble alloc] initWithAttachedView:_button1 title:@"1. The First Button" description:@"Setup your bubbles and \ndraw whatever you want \nwith multiline text" arrowPosition:CRArrowPositionTop andColor:nil];
    //You can set the bubble title font.
    //[bubbleButton1 setFontName:@"Baskerville"];
    //You can set the bubble glow color.
    //[bubbleButton1 setGlowColor:[UIColor greenColor]];
    
    CRBubble *bubbleButton2 = [[CRBubble alloc] initWithAttachedView:_button2 title:@"2. The Second Button" description:@"Just click, nothing append" arrowPosition:CRArrowPositionTop andColor:nil  andGlow:NO];
    
//    CRBubble *bubbleButtonHelp = [[CRBubble alloc] initWithAttachedView:_buttonHelp title:@"Help toogle" description:@"You don't need help anymore ? \nDisable it." arrowPosition:CRArrowPositionRight andColor:nil];

//    CRBubble *bubbleButtonHelp = [[CRBubble alloc] initWithAttachedView:_buttonHelp title:@"" description:@"TEST TEST TEST TEST TEST\nTEST TEST TEST" arrowPosition:CRArrowPositionTop andColor:nil];
    
//    NSMutableArray *bubbleArray = [[NSMutableArray alloc] initWithObjects:bubbleNavBarButton, bubbleButton2, bubbleButtonHelp, bubbleTabBarButton, bubbleTabBarButton2,nil];
    NSMutableArray *bubbleArray = [[NSMutableArray alloc] initWithObjects:bubbleButton2,nil];

    [productTourView setBubbles:bubbleArray];
    
    [self.view addSubview:productTourView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)toogleHelpAction:(id)sender {
    [productTourView setVisible:![productTourView isVisible]];
}
@end
