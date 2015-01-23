//
//  HomeVC.m
//  AdMobPoC
//
//  Created by staticVoidMan on 22/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import "HomeVC.h"
#import "Banner_AdMobVC.h"
#import "Interstitial_AdMobVC.h"

@interface HomeVC () <Banner_AdMobVCDelegate, Interstitial_AdMobVCDelegate>
{
    IBOutlet UIActivityIndicatorView *activityAdMobBanner;
    IBOutlet UIActivityIndicatorView *activityAdMobInterstitial;
    
    IBOutlet UIButton *btnToggleBanner;
    IBOutlet UIButton *btnRequestInterstitial;
    
    IBOutlet UIView *vwContainerBanner;
    IBOutlet NSLayoutConstraint *constraintBanner;
    
    Banner_AdMobVC *bannerAdMob;
}
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //initial conditions
    [btnToggleBanner setSelected:YES];
    [self btnToggleBanner_Act:btnToggleBanner];
    
    [activityAdMobInterstitial stopAnimating];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"embedBanner_AdMobVC"]) {
        bannerAdMob = segue.destinationViewController;
        [bannerAdMob setDelegate:self];
    }
}

#pragma mark - Button Methods
-(IBAction)btnToggleBanner_Act:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    
    if (sender.selected) {
        constraintBanner.constant = 0;
        [activityAdMobBanner stopAnimating];
    }
    else {
        constraintBanner.constant = -vwContainerBanner.bounds.size.height;
        [activityAdMobBanner startAnimating];
    }
    
    [UIView animateWithDuration:0.27f
                     animations:^{
                         [self.view layoutIfNeeded];
                     }];
}

-(IBAction)btnRequestInterstitial_Act:(UIButton *)sender {
    if (sender.selected) {
        //already requesting
        return;
    }
    
    [sender setSelected:YES];
    
    [[Interstitial_AdMobVC sharedInstance] startRequest];
    [[Interstitial_AdMobVC sharedInstance] setDelegate:self];
    
    [activityAdMobInterstitial startAnimating];
}

#pragma mark - Banner_AdMobVC Delegates
-(void)requestAdMobBannerCompletedWithSuccess:(BOOL)success {
    if (success && !btnToggleBanner.selected) {
        [self btnToggleBanner_Act:btnToggleBanner];
    }
}

#pragma mark - Interstitial_AdMobVC
-(void)requestAdMobInterstitalCompletedWithSuccess:(BOOL)success {
    [activityAdMobInterstitial stopAnimating];
    [btnRequestInterstitial setSelected:NO];
}

@end
