//
//  TReaderMark.m
//  TBookReader
//
//  Created by tanyang on 16/1/22.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import "TReaderMark.h"

@implementation TReaderMark

+ (NSMutableArray *)dbObjectsWithBookId:(NSInteger)bookId
{
    NSString *contion = [NSString stringWithFormat:@"bookId = '%ld'",bookId];
    return [self dbObjectsWhere:contion orderby:nil];
}

+ (NSArray *)dbObjectsWithBookId:(NSInteger)bookId chapterName:(NSString *)chapterName
{
    NSString *contion = [NSString stringWithFormat:@"bookId = '%ld' and chapterIndex = '%@'",bookId,chapterName];
    return [self dbObjectsWhere:contion orderby:nil];
}

- (BOOL)existDbObjectsWhereRange:(NSRange)range
{
    NSArray *array = [[self class] dbObjectsWithBookId:_bookId chapterName:_chapterIndex];
    for (TReaderMark *mark in array) {
        if (NSLocationInRange(mark.offset, range)) {
            return YES;
        }
    }
    return NO;
}

- (BOOL)removeDbObjectsWhereRange:(NSRange)range
{
    BOOL isRemove = NO;
    NSArray *array = [[self class] dbObjectsWithBookId:_bookId chapterName:_chapterIndex];
    for (TReaderMark *mark in array) {
        if (NSLocationInRange(mark.offset, range)) {
            NSString *contion = [NSString stringWithFormat:@"bookId = '%ld' and chapterIndex = '%@' and offset = '%ld'",_bookId,_chapterIndex,mark.offset];
            isRemove = [TReaderMark removeDbObjectsWhere:contion];
            NSLog(@"删除书签 %d",isRemove);
        }
    }
    return isRemove;
}

- (BOOL)removeDbObjects
{
    BOOL isRemove = NO;
    NSArray *array = [[self class] dbObjectsWithBookId:_bookId chapterName:_chapterIndex];
    
    for (TReaderMark *mark in array) {
        if (mark.offset == _offset) {
            NSString *contion = [NSString stringWithFormat:@"bookId = '%ld' and chapterIndex = '%@' and offset = '%ld'",_bookId,_chapterIndex,mark.offset];
            isRemove = [TReaderMark removeDbObjectsWhere:contion];
            NSLog(@"删除书签 %d",isRemove);
            break;
        }
    }
    return isRemove;
}


@end
