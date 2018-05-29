//
//  LXActionBar.m
//  TestAccountDemo1
//
//  Created by IDEAL YANG on 2018/5/28.
//  Copyright © 2018年 IDEAL YANG. All rights reserved.
//

#import "LXActionBar.h"

@implementation LXActionBar
{
    UIButton *_backBtn;
    UILabel *_titleLabel;
}

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(20, 20, 44, 44)];
        [backBtn setTitle:NSLocalizedStringFromTable(@"Back", @"Demo" ,@"Back") forState:UIControlStateNormal];
        [backBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(clickBackBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backBtn];
        _backBtn = backBtn;

        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(64, 20, CGRectGetWidth(self.bounds) - 2*CGRectGetMaxX(backBtn.frame), 44)];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [self addSubview:label];
        _titleLabel = label;
        
        self.backgroundColor = [UIColor colorWithRed:224.0/255.0 green:39.0/255.0 blue:39.0/255.0 alpha:1.0];
        _intrinsicHeight = 100.0;
    }
    return self;
}

#pragma mark - Properties

- (void)setContentInset:(UIEdgeInsets)contentInset
{
    if (!UIEdgeInsetsEqualToEdgeInsets(_contentInset, contentInset)) {
        _contentInset = contentInset;
        [self setNeedsLayout];
    }
}

- (void)setIntrinsicHeight:(CGFloat)intrinsicHeight
{
    if (_intrinsicHeight != intrinsicHeight) {
        _intrinsicHeight = intrinsicHeight;
        [self invalidateIntrinsicContentSize];
    }
}

- (NSString *)text
{
    return _titleLabel.text;
}

- (void)setText:(NSString *)text
{
    NSString *currentText = self.text;
    if ((currentText != text) && ![currentText isEqualToString:text]) {
        _titleLabel.text = text;
        [self invalidateIntrinsicContentSize];
    }
}

- (CGSize)intrinsicContentSize
{
    return CGSizeMake(_titleLabel.intrinsicContentSize.width, self.intrinsicHeight);
}

#pragma mark - Layout

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect bounds = UIEdgeInsetsInsetRect(self.bounds, self.contentInset);
    
    CGRect btnFrame = _backBtn.frame;
    [_backBtn setFrame:CGRectMake(CGRectGetMinX(bounds) + CGRectGetMinX(btnFrame), CGRectGetMinY(btnFrame), CGRectGetWidth(btnFrame), CGRectGetHeight(btnFrame))];
    
    CGRect titleFrame = _titleLabel.frame;
    _titleLabel.frame = CGRectMake(CGRectGetMaxX(btnFrame),CGRectGetMinY(titleFrame), CGRectGetWidth(bounds) - 2*CGRectGetMaxX(btnFrame), CGRectGetHeight(titleFrame));
}

#pragma mark - Actions

- (void)clickBackBtnAction:(id)sender{
    if (self.backBlock) {
        self.backBlock();
    }
}

@end
