//
//  TReaderManager.m
//  TBookReader
//
//  Created by tanyang on 16/1/22.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#define READER_THEME_KEY @"READERTHEME"
#define FONT_SIZE_KEY @"FONT_SIZE"
#define FONT_SIZE 16

#define MAX_FONT_SIZE 20
#define MIN_FONT_SIZE 15

#define MARK_TEXT_LENGTH 120

#import "TReaderManager.h"
#import "TReaderMark.h"
#import "TReaderChapter.h"

@implementation TReaderManager

#pragma mark - theme

+ (TReaderTheme)readerTheme
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:READER_THEME_KEY];
    
}

+ (void)saveReaderTheme:(TReaderTheme)readerTheme
{
    [[NSUserDefaults standardUserDefaults] setValue:@(readerTheme) forKey:READER_THEME_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSNotificationCenter defaultCenter] postNotificationName:TReaderThemeChangeNofication object:nil];
}

#pragma mark - font

+ (NSUInteger)fontSize
{
    NSUInteger fontSize = [[NSUserDefaults standardUserDefaults] integerForKey:FONT_SIZE_KEY];
    if (fontSize == 0) {
        fontSize = FONT_SIZE;
    }
    return fontSize;
}

+ (void)saveFontSize:(NSUInteger)fontSize
{
    [[NSUserDefaults standardUserDefaults] setValue:@(fontSize) forKey:FONT_SIZE_KEY];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)canIncreaseFontSize
{
    if ([self fontSize] >= MAX_FONT_SIZE) {
        return NO;
    }
    return YES;
}

+ (BOOL)canDecreaseFontSize
{
    if ([self fontSize] <= MIN_FONT_SIZE) {
        return NO;
    }
    return YES;
}

#pragma mark - mark

+ (BOOL)removeBookMarkWithBookId:(NSInteger)bookId Chapter:(TReaderChapter *)chapter curPage:(NSInteger)curPage
{
    TReaderMark *mark = [[TReaderMark alloc]init];
    mark.bookId = bookId;
    mark.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    TReaderPager *pager = [chapter chapterPagerWithIndex:curPage];
    
    return [mark removeDbObjectsWhereRange:pager.pageRange];
}

+ (BOOL)existMarkWithBookId:(NSInteger)bookId Chapter:(TReaderChapter *)chapter curPage:(NSInteger)curPage
{
    TReaderMark *mark = [[TReaderMark alloc]init];
    mark.bookId = bookId;
    mark.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    TReaderPager *pager = [chapter chapterPagerWithIndex:curPage];
    
    return [mark existDbObjectsWhereRange:pager.pageRange];
}

+ (void)saveBookMarkWithBookId:(NSInteger)bookId Chapter:(TReaderChapter *)chapter curPage:(NSInteger)curPage
{
    TReaderMark *mark = [[TReaderMark alloc]init];
    mark.bookId = bookId;
    mark.chapterIndex = [NSString stringWithFormat:@"%ld",chapter.chapterIndex];
    TReaderPager *pager = [chapter chapterPagerWithIndex:curPage];
    mark.offset = pager.pageRange.location;
    
    if ([mark existDbObjectsWhereRange:pager.pageRange]) {
        NSLog(@"书签已经存在！");
        return;
    }
    
    mark.content = [pager.attString attributedSubstringFromRange:NSMakeRange(0, MIN(MARK_TEXT_LENGTH,  pager.pageRange.length))].string;
    mark.content = [mark.content stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    [self saveBookMark:mark];
}

+ (void)saveBookMark:(TReaderMark *)readerMark
{
    // TODO
    if ([readerMark insertToDb]) {
        NSLog(@"加入书签成功！");
    }
}

@end
