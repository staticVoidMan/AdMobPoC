//
//  Interstitial_AdMobVC.m
//  AdMobPoC
//
//  Created by staticVoidMan on 22/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import "Interstitial_AdMobVC.h"
#import "GADInterstitial.h"

@interface Interstitial_AdMobVC () <GADInterstitialDelegate>
{
    GADInterstitial *interstitialAd;
    GADRequest *request;
    
    BOOL isRequesting;
}
@end

static Interstitial_AdMobVC *sharedInstance = nil;

@implementation Interstitial_AdMobVC
@synthesize delegate;

+(Interstitial_AdMobVC *)sharedInstance {
    if (sharedInstance == nil) {
        sharedInstance = [[super allocWithZone:NULL] init];
    }
    
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)startRequest {
    if (isRequesting) {
        return;
    }
    isRequesting = YES;
    
    interstitialAd = nil;
    
    interstitialAd = [[GADInterstitial alloc] init];
    [interstitialAd setAdUnitID:@"ca-app-pub-3216600718487191/1430732267"];
    [interstitialAd setDelegate:self];
    
    request = [GADRequest request];
    [interstitialAd loadRequest:request];
}

-(void)stopRequest {
    isRequesting = NO;
    
    [interstitialAd loadRequest:nil];
    interstitialAd = nil;
    request = nil;
}

#pragma mark - GADInterstitial Delegates
-(void)interstitial:(GADInterstitial *)ad didFailToReceiveAdWithError:(GADRequestError *)error {
    isRequesting = NO;
    
    if ([delegate respondsToSelector:@selector(requestAdMobInterstitalCompletedWithSuccess:)]) {
        [delegate requestAdMobInterstitalCompletedWithSuccess:NO];
    }
}

-(void)interstitialDidReceiveAd:(GADInterstitial *)ad {
    isRequesting = NO;
    
    if ([delegate respondsToSelector:@selector(requestAdMobInterstitalCompletedWithSuccess:)]) {
        [delegate requestAdMobInterstitalCompletedWithSuccess:YES];
    }
    
    [interstitialAd presentFromRootViewController:[[[[UIApplication sharedApplication] delegate] window] rootViewController]];
}
@end
