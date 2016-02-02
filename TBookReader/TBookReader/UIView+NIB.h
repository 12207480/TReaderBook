//
//  UIView+NIB.h
//  TBookReader
//
//  Created by tanyang on 16/1/25.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (NIB)

+ (instancetype)createViewFromNib;

+ (instancetype)createViewFromNibName:(NSString *)nibName;

@end
