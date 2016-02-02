//
//  NSAttributedString+TReaderPage.h
//  Examda
//
//  Created by tanyang on 16/1/26.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSAttributedString (TReaderPage)

// 根据渲染图文大小分页，返回range数组
- (NSArray *)pageRangeArrayWithConstrainedToSize:(CGSize)size;

@end
