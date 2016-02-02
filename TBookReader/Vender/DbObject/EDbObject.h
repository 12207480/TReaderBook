//
//  EDbObject.h
//  Examda
//
//  Created by luoluo on 15/1/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#define kDbId @"id__" 
#define kDbAUTOId @"idAuto__"
#define KArrData @"arrData" // 数组
#define KDbOrderId @"orderId" //排序
@protocol EDbObject

@required


/**
 *	@brief	失效日期
 */
@property (assign, nonatomic) NSDate *expireDate;

/**
 *	@brief	插入到数据库中
 */
- (BOOL)insertToDb;

/**
 *	@brief	更新某些数据
 *
 *	@param 	where 	条件
 *          例：name='xue zhang' and sex='男'
 *
 */
- (BOOL)updateToDbsWhere:(NSString *)where; //NS_DEPRECATED(10_0, 10_4, 2_0, 2_0);

/**
 *	@brief	查看是否包含对象
 *
 *	@param 	where 	条件
 *          例：name='xue zhang' and sex='男'
 *
 *	@return	包含YES,否则NO
 */
+ (BOOL)existDbObjectsWhere:(NSString *)where;

/**
 *	@brief	删除某些数据
 *
 *	@param 	where 	条件
 *          例：name='xue zhang' and sex='男'
 *          填入 all 为全部删除
 *
 *	@return 成功YES,否则NO
 */
+ (BOOL)removeDbObjectsWhere:(NSString *)where;

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
+ (NSMutableArray *)dbObjectsWhere:(NSString *)where orderby:(NSString *)orderby;

/**
 *	@brief	取出所有数据
 *
 *	@return	数据
 */
+ (NSMutableArray *)allDbObjects;

@end

@interface EDbObject : NSObject<EDbObject>


/**
 *	@brief	失效日期
 */
@property (assign, nonatomic) NSDate *expireDate;


@end
