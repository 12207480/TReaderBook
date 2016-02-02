//
//  TReaderManager.h
//  TBookReader
//
//  Created by tanyang on 16/1/22.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TReaderTheme) {
    TReaderThemeNormal,
    TReaderThemeEyeshield,
    TReaderThemeNight,
};

static NSString *const TReaderThemeChangeNofication = @"TReaderThemeChangeNofication";

@class TReaderChapter;
@class TReaderMark;
@interface TReaderManager : NSObject

// theme

+ (TReaderTheme)readerTheme;

+ (void)saveReaderTheme:(TReaderTheme)readerTheme;

// font

+ (NSUInteger)fontSize;

+ (void)saveFontSize:(NSUInteger)fontSize;

+ (BOOL)canIncreaseFontSize;

+ (BOOL)canDecreaseFontSize;

// mark

+ (BOOL)existMarkWithBookId:(NSInteger)bookId Chapter:(TReaderChapter *)chapter curPage:(NSInteger)curPage;

+ (BOOL)removeBookMarkWithBookId:(NSInteger)bookId Chapter:(TReaderChapter *)chapter curPage:(NSInteger)curPage;

+ (void)saveBookMarkWithBookId:(NSInteger)bookId Chapter:(TReaderChapter *)chapter curPage:(NSInteger)curPage;

+ (void)saveBookMark:(TReaderMark *)readerMark;

@end
