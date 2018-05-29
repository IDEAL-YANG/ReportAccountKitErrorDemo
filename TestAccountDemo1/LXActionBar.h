//
//  LXActionBar.h
//  TestAccountDemo1
//
//  Created by IDEAL YANG on 2018/5/28.
//  Copyright © 2018年 IDEAL YANG. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBackBtn)(void);

@interface LXActionBar : UIView

@property (nonatomic, assign) UIEdgeInsets contentInset;
@property (nonatomic, assign) CGFloat intrinsicHeight;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) clickBackBtn backBlock;

@end
