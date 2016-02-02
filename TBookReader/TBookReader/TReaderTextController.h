//
//  TReaderViewController.h
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TReaderPager;
@class TReaderChapter;

@interface TReaderTextController : UIViewController
@property (nonatomic, strong) TReaderChapter *readerChapter;
@property (nonatomic, strong) TReaderPager *readerPager;
@property (nonatomic, assign) NSUInteger totalPage;

// 获取当前图文label 的大小
+ (CGSize)renderSizeWithFrame:(CGRect)frame;

@end
