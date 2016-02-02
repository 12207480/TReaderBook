//
//  EReaderFontBar.h
//  Examda
//
//  Created by tanyang on 16/1/25.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EReaderFontBar;

@protocol EReaderFontBarDelegate <NSObject>

- (void)readerFontBar:(EReaderFontBar *)readerFontBar changeReaderFont:(BOOL)increaseSize;

- (void)readerFontBar:(EReaderFontBar *)readerFontBar changeReaderTheme:(NSInteger)readerTheme;

@end

@interface EReaderFontBar : UIView

@property (nonatomic, weak) id<EReaderFontBarDelegate> delegate;

@end
