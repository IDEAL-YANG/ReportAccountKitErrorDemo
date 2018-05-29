//
//  MyUIManager.h
//  TestAccountDemo
//
//  Created by IDEAL YANG on 2018/5/28.
//  Copyright © 2018年 IDEAL YANG. All rights reserved.
//

#import <AccountKit/AccountKit.h>

@interface MyUIManager : NSObject<AKFUIManager>

@property (nonatomic, assign, readonly) AKFButtonType confirmButtonType;
@property (nonatomic, assign, readonly) AKFButtonType entryButtonType;
@property (nonatomic, copy) AKFTheme *theme;

@end
