//
//  TReaderViewController.m
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import "TReaderTextController.h"
#import "TYAttributedLabel.h"
#import "TReaderManager.h"
#import "TReaderPager.h"
#import "UIColor+TReaderTheme.h"

#define kTextLabelHorEdge 15
#define kTextLabelTopEdge 25
#define kTextLabelBottomEdge 10

@interface TReaderTextController ()
@property (nonatomic, weak) TYAttributedLabel *label;
@end

@implementation TReaderTextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addAttributedLabel];
    
    [self changeReaderThemeNofication];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeReaderThemeNofication) name:TReaderThemeChangeNofication object:nil];
}

- (void)viewWillLayoutSubviews
{
    _label.frame = [[self class]renderFrameWithFrame:self.view.frame];
}

- (void)addAttributedLabel
{
    TYAttributedLabel *label = [[TYAttributedLabel alloc]init];
    label.backgroundColor = [UIColor clearColor];
    label.attributedText = _readerPager.attString;
    [self.view addSubview:label];
    _label = label;
}

#pragma mark - renderSize

+ (CGRect)renderFrameWithFrame:(CGRect)frame
{
    return CGRectMake(kTextLabelHorEdge, kTextLabelTopEdge, CGRectGetWidth(frame)-2*kTextLabelHorEdge, CGRectGetHeight(frame)-kTextLabelTopEdge-kTextLabelBottomEdge);
}

+ (CGSize)renderSizeWithFrame:(CGRect)frame
{
    return [self renderFrameWithFrame:frame].size;
}

#pragma mark - notification

- (void)changeReaderThemeNofication
{
    self.view.backgroundColor = [UIColor whiteBgReaderThemeColor];
    _label.textColor = [UIColor darkTextReaderThemeColor];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
