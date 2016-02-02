//
//  TChapterData.h
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TReaderPager.h"

@interface TReaderChapter : NSObject

@property (nonatomic, strong)  NSString *chapterContent; // 章节内容
@property (nonatomic, strong)  NSString *chapterTitle;   // 章节标题
@property (nonatomic, assign)  NSInteger chapterIndex;   // 章节下标
@property (nonatomic, strong, readonly) NSArray *pageRangeArray; // 每页范围
@property (nonatomic, assign, readonly) NSInteger totalPage;     // 总页数
@property (nonatomic, assign, readonly) CGSize renderSize;       // 图文大小

- (void)parseChapter;

// 解析章节内容
- (void)parseChapterWithRenderSize:(CGSize)renderSize;

// 获取章节页
- (TReaderPager *)chapterPagerWithIndex:(NSInteger)pageIndex;

// 根据offset获取页下标
- (NSInteger)pageIndexWithChapterOffset:(NSInteger)offset;

@end
