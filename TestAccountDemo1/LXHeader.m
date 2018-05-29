//
//  LXHeader.m
//  TestAccountDemo1
//
//  Created by IDEAL YANG on 2018/5/29.
//  Copyright © 2018年 IDEAL YANG. All rights reserved.
//

#import "LXHeader.h"

@implementation LXHeader
{
    UILabel *_titleLabel;
}

#pragma mark - Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor blackColor];
        [self addSubview:label];
        _titleLabel = label;
        
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
    _titleLabel.frame = bounds;
}

@end
