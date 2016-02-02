//
//  TReaderPageViewController.m
//  TBookReader
//
//  Created by tanyang on 16/1/21.
//  Copyright © 2016年 Tany. All rights reserved.
//

#import "TReaderViewController.h"
#import "TReaderTextController.h"
#import "TReaderMarkController.h"
#import "TReaderBook.h"
#import "TReaderManager.h"
#import "TReaderMark.h"
#import "EReaderTopBar.h"
#import "EReaderToolBar.h"
#import "EReaderFontBar.h"
#import "EPageIndexView.h"
#import "UIView+NIB.h"
//#import "EBookCatalogController.h"

@interface TReaderViewController ()<UIPageViewControllerDataSource,UIPageViewControllerDelegate, EReaderToolBarDelegate,EReaderTopBarDelegate,EReaderFontBarDelegate,TReaderMarkDelegate>

@property (nonatomic, weak) UIPageViewController * pageViewController;
@property (nonatomic, weak) EReaderToolBar *toolBar;
@property (nonatomic, weak) EReaderTopBar *topBar;
@property (nonatomic, weak) EReaderFontBar *fontBar;
@property (nonatomic, weak) EPageIndexView *pageIndexView;

@property (nonatomic, strong) TReaderBook *readerBook;
@property (nonatomic, strong) TReaderChapter *chapter;
@property (nonatomic, assign) CGSize renderSize;    // 渲染大小
@property (nonatomic, assign) NSInteger curPage;    // 当前页数
@property (nonatomic, assign) NSInteger readOffset; // 当前页在本章节位移
@end

@implementation TReaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addPageViewController];
    
    [self addSingleTapGesture];

    [self openBookWithChapterIndex:1];
    
    [self showReaderPage:0];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

#pragma mark - add view

- (void)addSingleTapGesture
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapAction:)];
    //增加事件者响应者，
    [self.view addGestureRecognizer:singleTap];
}

- (void)addPageViewController
{
    UIPageViewController *pageViewController = _style == TReaderTransitionStylePageCur ? [[UIPageViewController alloc]init] : [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageViewController.delegate = self;
    pageViewController.dataSource = self;
    pageViewController.view.frame = self.view.bounds;
    
    [self addChildViewController:pageViewController];
    [self.view addSubview:pageViewController.view];
    _pageViewController = pageViewController;
    
    _renderSize = [TReaderTextController renderSizeWithFrame:pageViewController.view.frame];
}

//显示第几页数据
- (void)showReaderPage:(NSUInteger)page
{
    _curPage = page;
    TReaderTextController *readerController = [self readerControllerWithPage:page chapter:_chapter];
    [_pageViewController setViewControllers:@[readerController]
                                  direction:UIPageViewControllerNavigationDirectionForward
                                   animated:NO
                                 completion:nil];
}

- (TReaderTextController *)readerControllerWithPage:(NSUInteger)page chapter:(TReaderChapter *)chapter
{
    TReaderTextController *readerViewController = [[TReaderTextController alloc]init];
    [self confogureReaderController:readerViewController page:page chapter:chapter];
    return readerViewController;
}

- (void)confogureReaderController:(TReaderTextController *)readerViewController page:(NSUInteger)page chapter:(TReaderChapter *)chapter
{
    if (_style == TReaderTransitionStylePageCur) {
        _curPage = page;
    }
    readerViewController.readerChapter = chapter;
    readerViewController.readerPager = [chapter chapterPagerWithIndex:page];
    if (readerViewController.readerPager) {
        NSRange range = readerViewController.readerPager.pageRange;
        _readOffset = range.location+range.length/3;
    }
}

#pragma mark - Reader Setting
// 读取书籍数据
- (void)openBookWithChapterIndex:(NSInteger)chapterIndex
{
    if (!_readerBook) {
        _readerBook = [[TReaderBook alloc]init];
        // test data
        _readerBook.bookId = 123456;
        _readerBook.bookName = @"Chapter";
        _readerBook.totalChapter = 7;
    }
    
    _chapter = [self getBookChapter:chapterIndex];
}

// 跳转到章节
- (void)turnToBookChapter:(NSInteger)chapterIndex
{
    [self openBookWithChapterIndex:chapterIndex];
    [self showReaderPage:0];
}

- (void)turnToBookChapter:(NSInteger)chapterIndex chapterOffset:(NSInteger)chapterOffset
{
    _chapter = [self getBookChapter:chapterIndex];
    NSInteger pageIndex = [_chapter pageIndexWithChapterOffset:chapterOffset];
    [self showReaderPage:pageIndex];
}

// 获取章节
- (TReaderChapter *)getBookChapter:(NSInteger)chapterIndex
{
    TReaderChapter *chapter = [_readerBook openBookWithChapter:chapterIndex];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}

- (TReaderChapter *)getBookPreChapter
{
    TReaderChapter *chapter = [_readerBook openBookPreChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}

- (TReaderChapter *)getBookNextChapter
{
    TReaderChapter *chapter = [_readerBook openBookNextChapter];
    [chapter parseChapterWithRenderSize:_renderSize];
    return chapter;
}

// 字体
- (void)increaseChangeSizeAction
{
    [TReaderManager saveFontSize:[TReaderManager fontSize]+1];
    
    [_chapter parseChapter];
    
    NSInteger page = [_chapter pageIndexWithChapterOffset:_readOffset];
    
    if (page != NSNotFound) {
        [self showReaderPage:page];
    }else {
        NSLog(@"未找到page");
        [self showReaderPage:0];
    }
}

- (void)decreaseChangeSizeAction
{
    [TReaderManager saveFontSize:[TReaderManager fontSize]-1];
    
    [_chapter parseChapter];
    
    NSInteger page = [_chapter pageIndexWithChapterOffset:_readOffset];
    
    if (page != NSNotFound) {
        [self showReaderPage:page];
    }else {
        NSLog(@"未找到page");
        [self showReaderPage:0];
    }
    
}

// 书签
- (void)saveCurrentChapterPagerMark
{
    [TReaderManager saveBookMarkWithBookId:_readerBook.bookId Chapter:_chapter curPage:_curPage];
}

- (void)removeCurrentChapterPagerMark
{
    [TReaderManager removeBookMarkWithBookId:_readerBook.bookId Chapter:_chapter curPage:_curPage];
}

#pragma mark - ToolBar Animation

// 显示设置
- (void)showReaderSettingBar
{
    EReaderTopBar *topBar = [EReaderTopBar createViewFromNib];
    topBar.delegate = self;
    BOOL haveMarkInCurPage = [TReaderManager existMarkWithBookId:_readerBook.bookId Chapter:_chapter curPage:_curPage];
    topBar.markBtn.selected = haveMarkInCurPage;
    topBar.frame = CGRectMake(0, -CGRectGetHeight(topBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(topBar.frame));
    [self.view addSubview:topBar];
    _topBar = topBar;
    
    EReaderToolBar *toolBar = [EReaderToolBar createViewFromNib];
    toolBar.curPage =  _curPage;
    toolBar.totalPage = _chapter.totalPage;
    toolBar.delegate = self;
    [toolBar showSliderPogress];
    toolBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(toolBar.frame));
    [self.view addSubview:toolBar];
    _toolBar = toolBar;
    
    [UIView animateWithDuration:0.2 animations:^{
        _topBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(_topBar.frame));
        _toolBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(_toolBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(_toolBar.frame));
    }];
}

- (void)hideReaderSettingBar
{
    [UIView animateWithDuration:0.2 animations:^{
        _topBar.frame = CGRectMake(0, -CGRectGetHeight(_topBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(_topBar.frame));
        _toolBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(_toolBar.frame));
        
    } completion:^(BOOL finished) {
        [_toolBar removeFromSuperview];
        [_topBar removeFromSuperview];
    }];
}

- (void)showFontToolBar
{
    _fontBar = [EReaderFontBar createViewFromNib];
    _fontBar.delegate = self;
    [self.view addSubview:_fontBar];
    
    _fontBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(_fontBar.frame));
    
    [UIView animateWithDuration:0.2 animations:^{
        _fontBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame) - CGRectGetHeight(_fontBar.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(_toolBar.frame));
    }];
}

- (void)hideFontToolBar
{
    [UIView animateWithDuration:0.2 animations:^{
        _fontBar.frame = CGRectMake(0, CGRectGetHeight(self.view.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(_fontBar.frame));
        
    } completion:^(BOOL finished) {
        [_fontBar removeFromSuperview];
    }];
}

- (void)showPageIndexViewWithPage:(NSInteger)page totalPage:(NSInteger)totalPage
{
    if (_pageIndexView == nil) {
        EPageIndexView *pageIndexView = [[EPageIndexView alloc]init];
        pageIndexView.image = [UIImage imageNamed:@"ico_schedule"];
        CGSize imageSize = pageIndexView.image.size;
        pageIndexView.frame = CGRectMake((CGRectGetWidth(self.view.frame)-imageSize.width)/2,CGRectGetMinY(_toolBar.frame)-imageSize.height-8, imageSize.width, imageSize.height);
        [self.view addSubview:pageIndexView];
        _pageIndexView = pageIndexView;
    }
    
    _pageIndexView.label.text = [NSString stringWithFormat:@"%ld/%ld",page,totalPage];
}

- (void)hidePageIndexView
{
    if (_pageIndexView == nil) {
        return;
    }
    
    [UIView animateWithDuration:0.1 animations:^{
        _pageIndexView.alpha = 0;
    } completion:^(BOOL finished) {
        [_pageIndexView removeFromSuperview];
    }];
}


#pragma mark - Action

- (void)singleTapAction:(UIGestureRecognizer *)gesture
{
    if (_fontBar) {
        [self hideFontToolBar];
        return;
    }
    
    if (_topBar && _toolBar) {
        [self hideReaderSettingBar];
        [self hidePageIndexView];
    }else {
        [self showReaderSettingBar];
    }
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
      viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSLog(@"go pre");
    
    TReaderTextController *curReaderVC = (TReaderTextController *)viewController;
    NSInteger currentPage = curReaderVC.readerPager.pageIndex;
    _curPage = currentPage;
    
    TReaderChapter *chapter = curReaderVC.readerChapter;
    
    if (_chapter != chapter) {
        _chapter = chapter;
        [_readerBook resetChapter:chapter];
    }
    
    TReaderTextController *readerVC = [[TReaderTextController alloc]init];
    if (currentPage > 0) {
        [self confogureReaderController:readerVC page:currentPage-1 chapter:chapter];
        NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
        return readerVC;
    }else {
        if ([_readerBook havePreChapter]) {
            NSLog(@"--获取上一章");
            TReaderChapter *preChapter = [self getBookPreChapter];
            [self confogureReaderController:readerVC page:preChapter.totalPage-1 chapter:preChapter];
            NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
            return readerVC;
        }else {
            NSLog(@"已经是第一页了");
            return nil;
        }
    }
    return readerVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController
       viewControllerAfterViewController:(UIViewController *)viewController
{
    NSLog(@"go after");
    
    TReaderTextController *curReaderVC = (TReaderTextController *)viewController;
    NSInteger currentPage = curReaderVC.readerPager.pageIndex;
    _curPage = currentPage;
    
    TReaderChapter *chapter = curReaderVC.readerChapter;
    
    if (_chapter != chapter) {
        _chapter = chapter;
        [_readerBook resetChapter:chapter];
    }
    
    TReaderTextController *readerVC = [[TReaderTextController alloc]init];
    if (currentPage < chapter.totalPage - 1) {
        [self confogureReaderController:readerVC page:currentPage+1 chapter:chapter];
         NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
        return readerVC;
    }else {
        if ([_readerBook haveNextChapter]) {
            NSLog(@"--获取下一章");
            TReaderChapter *nextChapter = [self getBookNextChapter];
            [self confogureReaderController:readerVC page:0 chapter:nextChapter];
             NSLog(@"总页码%ld 当前页码%ld",chapter.totalPage,_curPage+1);
            return  readerVC;
        }else {
            NSLog(@"已经是最后一页了");
            return nil;
        }
    }
    return readerVC;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        if (_fontBar) {
            [self hideFontToolBar];
        }
        
        if (_toolBar && _topBar) {
            [self hideReaderSettingBar];
        }
        
        if (_pageIndexView) {
            [self hidePageIndexView];
        }
    }
}

#pragma mark - EReaderToolBarDelegate

- (void)readerToolBar:(EReaderToolBar *)readerToolBar didClickedAction:(EReaderToolBarAction)action
{
    if (action == EReaderToolBarActionMenu) {
        NSLog(@"点击目录");
//        EBookCatalogController *VC = [[EBookCatalogController alloc]init];
//        [self.navigationController pushViewController:VC animated:YES];
    }else if (action == EReaderToolBarActionMark) {
        TReaderMarkController *markVC = [[TReaderMarkController alloc]init];
        markVC.bookId = _readerBook.bookId;
        markVC.delegate = self;
        [self.navigationController pushViewController:markVC animated:YES];
    }else if (action == EReaderToolBarActionFont) {
        [self hideReaderSettingBar];
        [self hidePageIndexView];
        [self showFontToolBar];
    }
}

- (void)readerToolBar:(EReaderToolBar *)readerToolBar didSliderToPage:(NSInteger)page
{
    [self showReaderPage:page];
}

- (void)readerToolBar:(EReaderToolBar *)readerToolBar didSliderToProgress:(CGFloat)progress
{
    NSInteger page = progress*_chapter.totalPage;
    [self showPageIndexViewWithPage:MIN(page+1, _chapter.totalPage) totalPage:_chapter.totalPage];
}

#pragma mark - EReaderTopBarDelegate

- (void)readerTopBar:(EReaderTopBar *)readerTopBar didClickedAction:(EReaderTopBarAction)action
{
    if (action == EReaderTopBarActionBack) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (action == EReaderTopBarActionMark) { // 书签
        if (readerTopBar.markBtn.isSelected) {
            [self removeCurrentChapterPagerMark];
        }else {
            [self saveCurrentChapterPagerMark];
        }
    }
}

#pragma mark - EReaderFontBarDelegate

- (void)readerFontBar:(EReaderFontBar *)readerFontBar changeReaderTheme:(NSInteger)readerTheme
{
    [TReaderManager saveReaderTheme:readerTheme];
}

- (void)readerFontBar:(EReaderFontBar *)readerFontBar changeReaderFont:(BOOL)increaseSize
{
    if (increaseSize) {
        [self increaseChangeSizeAction];
    }else {
        [self decreaseChangeSizeAction];
    }
}

#pragma mrk - TReaderMarkDelegate

- (void)readerMarkController:(TReaderMarkController *)bookMarkController didSelectedMark:(TReaderMark *)mark
{
    [self turnToBookChapter:[mark.chapterIndex integerValue] chapterOffset:mark.offset];
    
    if (_toolBar && _topBar) {
        [self hideReaderSettingBar];
    }
    if (_pageIndexView) {
        [self hidePageIndexView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
