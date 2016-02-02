//
//  EReaderFontBar.m
//  Examda
//
//  Created by tanyang on 16/1/25.
//  Copyright © 2016年 tanyang. All rights reserved.
//

#import "EReaderFontBar.h"
#import "TReaderManager.h"

@interface EReaderFontBar ()
@property (nonatomic, weak) UIButton *selectedBtn;
@property (weak, nonatomic) IBOutlet UIButton *narmalBtn;
@property (weak, nonatomic) IBOutlet UIButton *eyeBtn;
@property (weak, nonatomic) IBOutlet UIButton *nightBtn;

@property (weak, nonatomic) IBOutlet UIButton *decreseFontBtn;
@property (weak, nonatomic) IBOutlet UIButton *increaseFontBtn;
@end

@implementation EReaderFontBar

- (void)awakeFromNib
{
    [self updateFontSizeBtnState];
    
    [self selectDefaultThemeBtn];
}

- (void)selectDefaultThemeBtn
{
    switch ([TReaderManager readerTheme]) {
        case TReaderThemeNight:
            self.nightBtn.selected = YES;
            self.selectedBtn = self.nightBtn;
            break;
        case TReaderThemeEyeshield:
            self.eyeBtn.selected = YES;
            self.selectedBtn = self.eyeBtn;
            break;
        default:
            self.narmalBtn.selected = YES;
            self.selectedBtn = self.narmalBtn;
            break;
    }
}

- (void)updateFontSizeBtnState
{
    self.decreseFontBtn.enabled = [TReaderManager canDecreaseFontSize];
    self.increaseFontBtn.enabled = [TReaderManager canIncreaseFontSize];
}

#pragma mark - action

- (IBAction)sliderValueChangeAction:(UISlider *)sender{
    [[UIScreen mainScreen] setBrightness:sender.value];
}

- (IBAction)decreaseFontAction:(id)sender{
    if ([_delegate respondsToSelector:@selector(readerFontBar:changeReaderFont:)]) {
        [_delegate readerFontBar:self changeReaderFont:NO];
    }
    [self updateFontSizeBtnState];
}

- (IBAction)increaseFontAction:(id)sender {
    if ([_delegate respondsToSelector:@selector(readerFontBar:changeReaderFont:)]) {
        [_delegate readerFontBar:self changeReaderFont:YES];
    }
    [self updateFontSizeBtnState];
}

- (IBAction)selectedThemeAction:(UIButton *)sender {
    if (_selectedBtn) {
        _selectedBtn.selected = NO;
    }
    sender.selected = YES;
    _selectedBtn = sender;
    
    if ([_delegate respondsToSelector:@selector(readerFontBar:changeReaderTheme:)]) {
        [_delegate readerFontBar:self changeReaderTheme:sender.tag];
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
