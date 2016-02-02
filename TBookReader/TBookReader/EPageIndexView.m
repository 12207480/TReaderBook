//
//  EPageIndexView.m
//  Examda
//
//  Created by tanyang on 16/1/27.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "EPageIndexView.h"
#import "UIColor+TReaderTheme.h"

@interface EPageIndexView ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation EPageIndexView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addTitleLabel];
    }
    return self;
}

- (void)addTitleLabel
{
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = [UIColor whiteColor];
    [self addSubview:label];
    _label = label;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = self.bounds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
