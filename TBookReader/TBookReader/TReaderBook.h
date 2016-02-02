//
//  TReaderBook.h
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TReaderChapter.h"

@interface TReaderBook : NSObject
@property (nonatomic, assign) NSInteger bookId;     // 书本id
@property (nonatomic, strong) NSString *bookName;   // 书本名
@property (nonatomic, assign) NSInteger totalChapter; // 书本章节
@property (nonatomic, assign) NSInteger curChpaterIndex; // 当前章节

// 是否有下章节
- (BOOL)haveNextChapter;

// 是否有上章节
- (BOOL)havePreChapter;

// 重置章节
- (void)resetChapter:(TReaderChapter *)chapter;

// 获取书籍的章节
- (TReaderChapter *)openBookWithChapter:(NSInteger)chapter;

- (TReaderChapter *)openBookNextChapter;

- (TReaderChapter *)openBookPreChapter;

@end
