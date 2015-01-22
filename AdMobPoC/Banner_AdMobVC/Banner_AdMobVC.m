//
//  Banner_AdMobVC.m
//  AdMobPoC
//
//  Created by staticVoidMan on 22/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import "Banner_AdMobVC.h"
#import "GADBannerView.h"

@interface Banner_AdMobVC () <GADBannerViewDelegate>
{
    IBOutlet GADBannerView *adMob;
    GADRequest *request;
}
@end

@implementation Banner_AdMobVC
@synthesize delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [adMob setDelegate:self];
    [adMob setAdUnitID:@"ca-app-pub-3216600718487191/7477265866"];
    [adMob setRootViewController:self];
    
    [self startRequest];
}

#pragma mark - Helper Methods
-(void)startRequest {
    if (request == nil) {
        request = [GADRequest request];
        [adMob loadRequest:request];
    }
}

-(void)stopRequest {
    [adMob loadRequest:nil];
    request = nil;
}

#pragma mark - GADBannerView Delegates
-(void)adView:(GADBannerView *)view didFailToReceiveAdWithError:(GADRequestError *)error {
    if ([delegate respondsToSelector:@selector(requestAdMobBannerCompletedWithSuccess:)]) {
        [delegate requestAdMobBannerCompletedWithSuccess:NO];
    }
}

-(void)adViewDidReceiveAd:(GADBannerView *)view {
    if ([delegate respondsToSelector:@selector(requestAdMobBannerCompletedWithSuccess:)]) {
        [delegate requestAdMobBannerCompletedWithSuccess:YES];
    }
}

@end
