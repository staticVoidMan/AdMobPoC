//
//  Banner_AdMobVC.h
//  AdMobPoC
//
//  Created by staticVoidMan on 22/01/15.
//  Copyright (c) 2015 staticVoidMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol Banner_AdMobVCDelegate <NSObject>
@required
-(void)requestAdMobBannerCompletedWithSuccess:(BOOL)success;
@end

@interface Banner_AdMobVC : UIViewController

@property (nonatomic, weak) id<Banner_AdMobVCDelegate> delegate;

-(void)startRequest;
-(void)stopRequest;

@end
