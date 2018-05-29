//
//  MyUIManager.m
//  TestAccountDemo
//
//  Created by IDEAL YANG on 2018/5/28.
//  Copyright © 2018年 IDEAL YANG. All rights reserved.
//

#import "MyUIManager.h"
#import "LXActionBar.h"
#import "LXHeader.h"

@interface MyUIManager ()

@end

@implementation MyUIManager
{
    id<AKFActionController> _actionController;
}

- (void)clickBackPreview:(id)sender
{
    [_actionController back];
}

#pragma mark -

- (nullable UIView *)actionBarViewForState:(AKFLoginFlowState)state{
    LXActionBar *actionBar = [[LXActionBar alloc] initWithFrame:CGRectZero];
    NSString *detailTitle = nil;
    switch (state) {
        case AKFLoginFlowStatePhoneNumberInput:{
            detailTitle = @"手机号验证";
            break;
        }
        case AKFLoginFlowStateSendingCode:{
            detailTitle = @"发送验证码";
            break;
        }
        case AKFLoginFlowStateEmailInput:{
            detailTitle = @"邮箱验证";
            break;
        }
        default:
            break;
    }
    actionBar.intrinsicHeight = 64;
    actionBar.text = detailTitle;
    __weak typeof(self) weakSelf = self;
    actionBar.backBlock = ^{
        [weakSelf clickBackPreview:nil];
    };
    return actionBar;
}
- (nullable UIView *)bodyViewForState:(AKFLoginFlowState)state{
    UIView *view = nil;
    switch (state) {
        case AKFLoginFlowStatePhoneNumberInput:{
//            view = [[UIView alloc] init];
//
//            UIView *tipsBg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 100)];
//            tipsBg.backgroundColor = [UIColor redColor];
//            [view addSubview:tipsBg];
//
//            UILabel *tipsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
//            tipsLabel.text = @"我是提示文字";
//            tipsLabel.textColor = [UIColor greenColor];
//            [tipsBg addSubview:tipsLabel];
            break;
        }
        default:
            break;
    }
    return view;
}
- (nullable UIView *)footerViewForState:(AKFLoginFlowState)state{
    UIView *view = nil;
    
    return view;
}
- (nullable UIView *)headerViewForState:(AKFLoginFlowState)state{
    LXHeader *headerView = nil;
    switch (state) {
        case AKFLoginFlowStatePhoneNumberInput:{
            headerView = [[LXHeader alloc] initWithFrame:CGRectZero];
            headerView.text = @"你的手机号是？";
            headerView.intrinsicHeight = 70;
            break;
        }
        case AKFLoginFlowStateEmailInput:{
            headerView = [[LXHeader alloc] initWithFrame:CGRectZero];
            headerView.text = @"你的邮箱是？";
            headerView.intrinsicHeight = 70;
            break;
        }
        default:
            break;
    }
    return headerView;
}
- (void)setActionController:(nonnull id<AKFActionController>)actionController{
    _actionController = actionController;
}
- (void)setError:(nonnull NSError *)error{
    
}
- (AKFButtonType)buttonTypeForState:(AKFLoginFlowState)state
{
    switch (state) {
        case AKFLoginFlowStateCodeInput:
            return self.confirmButtonType;
        case AKFLoginFlowStateEmailInput:
        case AKFLoginFlowStatePhoneNumberInput:
            return self.entryButtonType;
        default:
            return AKFButtonTypeDefault;
    }
}
//- (AKFTextPosition)textPositionForState:(AKFLoginFlowState)state{
//    
//}
- (nullable AKFTheme *)theme{
    
//    AKFTheme *cusTheme = [AKFTheme outlineThemeWithPrimaryColor:[UIColor redColor] primaryTextColor:[UIColor greenColor] secondaryTextColor:[UIColor blueColor] statusBarStyle:UIStatusBarStyleDefault];
//    AKFTheme *cusTheme = [AKFTheme themeWithPrimaryColor:[UIColor yellowColor] primaryTextColor:[UIColor redColor] secondaryColor:[UIColor greenColor] secondaryTextColor:[UIColor blueColor] statusBarStyle:UIStatusBarStyleDefault];
    
    AKFTheme *cusTheme = [AKFTheme outlineTheme];
    
    cusTheme.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.6];
    cusTheme.backgroundImage = [UIImage imageNamed:@"profile-dream.jpg"];
    
//    cusTheme.headerTextType = AKFHeaderTextTypeAppName;
    cusTheme.inputStyle = AKFInputStyleUnderline;
    cusTheme.buttonBackgroundColor = [UIColor redColor];
    
    
    return cusTheme;
}

@end
