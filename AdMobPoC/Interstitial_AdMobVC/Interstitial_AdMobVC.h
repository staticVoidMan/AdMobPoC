//
//  Interstitial_AdMobVC.h
//  AdMobPoC
//
//  Created by staticVoidMan on 22/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol Interstitial_AdMobVCDelegate <NSObject>
@required
-(void)requestAdMobInterstitalCompletedWithSuccess:(BOOL)success;
@end

@interface Interstitial_AdMobVC : UIViewController

@property (nonatomic, weak) id<Interstitial_AdMobVCDelegate> delegate;

+(Interstitial_AdMobVC *)sharedInstance;

-(void)startRequest;
-(void)stopRequest;

@end
