//
//  EReaderToolBar.m
//  Examda
//
//  Created by tanyang on 16/1/25.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "EReaderToolBar.h"

@interface EReaderToolBar ()
@property (weak, nonatomic) IBOutlet UISlider *readerSlider;
@end

@implementation EReaderToolBar

- (void)showSliderPogress
{
    self.readerSlider.value = 1.0*(MIN(_totalPage-1, _curPage))/(_totalPage-1);
}

- (IBAction)menuAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(readerToolBar:didClickedAction:)]) {
        [_delegate readerToolBar:self didClickedAction:EReaderToolBarActionMenu];
    }
}

- (IBAction)markAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(readerToolBar:didClickedAction:)]) {
        [_delegate readerToolBar:self didClickedAction:EReaderToolBarActionMark];
    }
}

- (IBAction)fontAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(readerToolBar:didClickedAction:)]) {
        [_delegate readerToolBar:self didClickedAction:EReaderToolBarActionFont];
    }
}
- (IBAction)pogressValueChangeAction:(UISlider *)sender {
    
    if ([_delegate respondsToSelector:@selector(readerToolBar:didSliderToProgress:)]) {
        [_delegate readerToolBar:self didSliderToProgress:sender.value];
    }
}
- (IBAction)sliderEndAction:(UISlider *)sender {
    NSInteger page = sender.value*_totalPage;
    
    if ([_delegate respondsToSelector:@selector(readerToolBar:didSliderToPage:)]) {
        [_delegate readerToolBar:self didSliderToPage:MIN(page, _totalPage-1)];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
