//
//  EDbObject.m
//  Examda
//
//  Created by luoluo on 15/1/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import "EDbObject.h"
#import "EDbHandle.h"

@implementation EDbObject

- (id)init
{
    self = [super init];
    if (self) {
        self.expireDate = [NSDate distantFuture];
    }
    return self;
}

/**
 *	@brief	插入到数据库中
 */
- (BOOL)insertToDb
{
    return [EDbHandle insertDbObject:self];
}


/**
 *	@brief	更新某些数据
 *
 *	@param 	where 	条件
 *          例：name='xue zhang' and sex='男'
 *
 */
- (BOOL)updateToDbsWhere:(NSString *)where
{
    return [EDbHandle updateDbObject:self condition:where];
}

/**
 *	@brief	查看是否包含对象
 *
 *	@param 	where 	条件
 *          例：name='xue zhang' and sex='男'
 *
 *	@return	包含YES,否则NO
 */
+ (BOOL)existDbObjectsWhere:(NSString *)where
{
    NSArray *objs = [EDbHandle selectDbObjects:[self class] condition:where orderby:nil];
    if ([objs count] > 0) {
        return YES;
    }
    return NO;
}

/**
 *	@brief	删除某些数据
 *
 *	@param 	where 	条件
 *          例：name='xue zhang' and sex='男'
 *          填入 all 为全部删除
 *
 *	@return 成功YES,否则NO
 */
+ (BOOL)removeDbObjectsWhere:(NSString *)where
{
    return [EDbHandle removeDbObjects:[self class] condition:where];
}

/**
 *	@brief	根据条件取出某些数据
 *
 *	@param 	where 	条件
 *          例：name='xue zhang' and sex='男'
 *          填入 all 为全部
 *
 *	@param 	orderby 	排序
 *          例：name and age
 *
 *	@return	数据
 */
+ (NSArray *)dbObjectsWhere:(NSString *)where orderby:(NSString *)orderby
{
    return [EDbHandle selectDbObjects:[self class] condition:where orderby:orderby];
}

/**
 *	@brief	取出所有数据
 *
 *	@return	数据
 */
+ (NSMutableArray *)allDbObjects
{
    return [EDbHandle selectDbObjects:[self class] condition:@"all" orderby:nil];
}


@end
