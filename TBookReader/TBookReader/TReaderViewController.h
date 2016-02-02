//
//  TReaderPageViewController.h
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, TReaderTransitionStyle) {
    TReaderTransitionStylePageCur,
    TReaderTransitionStyleScroll,
};

@interface TReaderViewController : UIViewController

@property (nonatomic, assign) TReaderTransitionStyle style;// 翻页样式

@end
