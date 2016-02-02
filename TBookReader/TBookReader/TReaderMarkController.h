//
//  TReaderMarkController.h
//  TBookReader
//
//  Created by tanyang on 16/2/2.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TReaderMark;
@class TReaderMarkController;
@protocol TReaderMarkDelegate <NSObject>

- (void)readerMarkController:(TReaderMarkController *)bookMarkController didSelectedMark:(TReaderMark *)mark;

@end

@interface TReaderMarkController : UIViewController

@property (nonatomic, assign) NSInteger bookId;

@property (nonatomic, weak) id<TReaderMarkDelegate> delegate;

@end
