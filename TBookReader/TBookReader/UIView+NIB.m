//
//  UIView+NIB.m
//  TBookReader
//
//  Created by tanyang on 16/1/25.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "UIView+NIB.h"

@implementation UIView (NIB)

+ (instancetype)createViewFromNibName:(NSString *)nibName
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:nibName owner:self options:nil];
    return [nib objectAtIndex:0];
}

+ (instancetype)createViewFromNib
{
    return [self createViewFromNibName:NSStringFromClass(self.class)];
}

@end
