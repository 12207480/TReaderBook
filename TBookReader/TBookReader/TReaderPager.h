//
//  TReaderPager.h
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TReaderPager : NSObject

@property (nonatomic, strong) NSAttributedString *attString; // 本页属性文本
@property (nonatomic, assign) NSRange pageRange;   // 本页范围
@property (nonatomic, assign) NSInteger pageIndex; // 本页下标
@end
