//
//  EDbHandle.h
//  Examda
//
//  Created by luoluo on 15/1/26.
//  Copyright (c) 2015年 mark. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "EDbObject.h"

@interface EDbHandle : NSObject

/**
 *	@brief	单例数据库
 *
 *	@return	单例
 */
+ (instancetype)shareDb;

/**
 *	@brief	打开数据库
 *
 *	@return	成功标志
 */
+ (BOOL)openDb;

/*
 * 关闭数据库
 */
+ (BOOL)closeDb;

/**
 *	@brief	数据库路径
 *
 *	@return	数据库路径
 */
+ (NSString *)dbPath;

/**
 *	@brief	根据aClass表 添加一列
 *
 *	@param 	aClass 	表相关类
 *	@param 	columnName 	列名
 */
+ (void)dbTable:(Class)aClass addColumn:(NSString *)columnName;

/**
 *	@brief	从外部导入数据库
 *
 *	@param 	dbName 	数据库名称（dbName.db）
 */
+ (void)importDb:(NSString *)dbName;

/**
 *	@brief	根据aClass创建表
 *
 *	@param 	aClass 	表相关类
 */
+ (void)createDbTable:(Class)aClass;

/**
 *	@brief	插入一条数据
 *
 *	@param 	obj 	数据对象
 */
+ (BOOL)insertDbObject:(EDbObject *)obj;

/**
 *	@brief	根据条件查询数据
 *
 *	@param 	aClass 	表相关类
 *	@param 	condition 	条件（nil或空为无条件），例 id=5 and name='yls'
 *                      带条数限制条件:id=5 and name='yls' limit 5
 *	@param 	orderby 	排序（nil或空为不排序）, 例 id,name
 *
 *	@return	数据对象数组
 */
+ (NSMutableArray *)selectDbObjects:(Class)aClass condition:(NSString *)condition orderby:(NSString *)orderby;

/**
 *	@brief	根据条件删除类
 *
 *	@param 	aClass      表相关类
 *	@param 	condition   条件（nil或空为无条件），例 id=5 and name='yls'
 *                      无条件时删除所有.
 *
 *	@return	删除是否成功
 */
+ (BOOL)removeDbObjects:(Class)aClass condition:(NSString *)condition;

/**
 *	@brief	根据条件修改一条数据
 *
 *	@param 	obj 	修改的数据对象（属性中有值的修改，为nil的不处理）;
 *	@param 	condition 	条件（nil或空为无条件），例 id=5 and name='yls'
 *
 *	@return	修改是否成功
 */
+ (BOOL)updateDbObject:(EDbObject *)obj condition:(NSString *)condition;

/**
 *	@brief	根据aClass删除表
 *
 *	@param 	aClass 	表相关类
 *
 *	@return	删除表是否成功
 */
+ (BOOL)removeDbTable:(Class)aClass;

/*
 * 查看所有表名
 */
+ (NSArray *)sqlite_tablename;


@end
