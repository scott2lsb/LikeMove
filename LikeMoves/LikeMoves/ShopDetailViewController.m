//
//  ShopDetailViewController.m
//  LikeMoves
//
//  Created by 粒橙Leo on 14-10-27.
//  Copyright (c) 2014年 Licheng Yang. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ProductCommentTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ShopDetailViewController ()
@property(strong,nonatomic)HMSegmentedControl* segmentedControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic,weak)NSDictionary* selectProduct;
@end

@implementation ShopDetailViewController
NSArray *pics;
NSArray *rollPics;

NSArray *books;
NSArray *prices;
- (void)viewDidLoad
{
    [super viewDidLoad];
    //轮播图和详情图
    // 创建、并初始化NSArray对象。
	books = [NSArray arrayWithObjects:@"疯狂Android讲义",
             @"疯狂iOS讲义", @"疯狂Ajax讲义" , @"疯狂XML讲义", nil];
	// 创建、并初始化NSArray对象。
	prices = [NSArray arrayWithObjects:
              @"99", @"79" , @"79" , @"69" , nil];

    /**
     *  界面元素
     */
//    _titleLabel
//    _priceLabel
//    _soldLabel
    pics=(NSArray*)[_selectProduct objectForKey:@"pics"];
    rollPics=(NSArray*)[_selectProduct objectForKey:@"roll_pics"];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat yDelta;
    if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending) {
        yDelta = 20.0f;
    } else {
        yDelta = 0.0f;
    }
    
    // Minimum code required to use the segmented control with the default styling.
    _segmentedControl = [[HMSegmentedControl alloc] initWithSectionTitles:@[@"宝贝详情", @"图文详情", @"评论"]];
    _segmentedControl.frame = CGRectMake(0, 0 +44+ yDelta, 320, 44);
    _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    _segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
    [_segmentedControl addTarget:self action:@selector(segmentedControlChangedValue:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segmentedControl];
    
    
    __weak typeof(self) weakSelf = self;
    [self.segmentedControl setIndexChangeBlock:^(NSInteger index) {
        [weakSelf.scrollView scrollRectToVisible:CGRectMake(320 * index, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49) animated:YES];
    }];
    
    [self.view addSubview:self.segmentedControl];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,108, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49)];
    self.scrollView.backgroundColor = [UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.contentSize = CGSizeMake(960, [[UIScreen mainScreen]bounds].size.height-20-44-44-49);
    self.scrollView.delegate = self;
    [self.scrollView scrollRectToVisible:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49) animated:NO];
    [self.view addSubview:self.scrollView];
    
    /**
     *  自定义scrollview三个内容页
     */
    
    //    _productDetail=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49)];
    //    _productDetail.backgroundColor=[UIColor whiteColor];
    
    _imgDetail=[[UIScrollView alloc] initWithFrame:CGRectMake(320, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49)];
    _imgDetail.backgroundColor=[UIColor whiteColor];
    _imgDetail.showsVerticalScrollIndicator=YES;
    _imgDetail.contentSize=CGSizeMake(320, 1150);
    UITextView* desc=[[UITextView alloc] initWithFrame:CGRectMake(0, 210, 320, 100)];
    desc.editable=NO;
    desc.text=(NSString*)[_selectProduct objectForKey:@"desc"];
    desc.textAlignment=NSTextAlignmentCenter;
    UIImageView* img1=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 200)];
    UIImageView* img2=[[UIImageView alloc] initWithFrame:CGRectMake(10, 320, 300, 200)];
    UIImageView* img3=[[UIImageView alloc] initWithFrame:CGRectMake(10, 530, 300, 200)];
    UIImageView* img4=[[UIImageView alloc] initWithFrame:CGRectMake(10, 740, 300, 200)];
    UIImageView* img5=[[UIImageView alloc] initWithFrame:CGRectMake(10, 950, 300, 200)];

    NSString* url;
    if ([pics isKindOfClass:[NSNull class]]) {
        url=@"";
    }else if(pics.count>0){
        NSDictionary*dict=(NSDictionary*)[pics objectAtIndex:0];
        url=[NSString stringWithFormat:@"http://www.haoapp123.com/app/localuser/aidongdong/%@",[dict objectForKey:@"pic"]];
    }
    [img1 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"testuser3"]];
    
    if ([pics isKindOfClass:[NSNull class]]) {
        url=@"";
    }else if(pics.count>1){
        NSDictionary*dict=(NSDictionary*)[pics objectAtIndex:1];
        url=[NSString stringWithFormat:@"http://www.haoapp123.com/app/localuser/aidongdong/%@",[dict objectForKey:@"pic"]];
    }
    [img2 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"testuser3"]];
    
    if ([pics isKindOfClass:[NSNull class]]) {
        url=@"";
    }else if(pics.count>2){
        NSDictionary*dict=(NSDictionary*)[pics objectAtIndex:2];
        url=[NSString stringWithFormat:@"http://www.haoapp123.com/app/localuser/aidongdong/%@",[dict objectForKey:@"pic"]];
    }
    [img3 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"testuser3"]];
    
    
    if ([pics isKindOfClass:[NSNull class]]) {
        url=@"";
    }else if(pics.count>3){
        NSDictionary*dict=(NSDictionary*)[pics objectAtIndex:3];
        url=[NSString stringWithFormat:@"http://www.haoapp123.com/app/localuser/aidongdong/%@",[dict objectForKey:@"pic"]];
    }
    [img4 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"testuser3"]];
    
    
    if ([pics isKindOfClass:[NSNull class]]) {
        url=@"";
    }else if(pics.count>4){
        NSDictionary*dict=(NSDictionary*)[pics objectAtIndex:4];
        url=[NSString stringWithFormat:@"http://www.haoapp123.com/app/localuser/aidongdong/%@",[dict objectForKey:@"pic"]];
    }
    [img5 sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"testuser3"]];
    
    
    [img1 setContentMode:UIViewContentModeScaleToFill];
    [img2 setContentMode:UIViewContentModeScaleToFill];
    [img3 setContentMode:UIViewContentModeScaleToFill];
    [img4 setContentMode:UIViewContentModeScaleToFill];
    [img5 setContentMode:UIViewContentModeScaleToFill];
    
    [_imgDetail addSubview:img1];
    [_imgDetail addSubview:img2];
    [_imgDetail addSubview:img3];
    [_imgDetail addSubview:img4];
    [_imgDetail addSubview:img5];
    [_imgDetail addSubview:desc];
    
    
    /**
     评论页面
     */
    _comment=[[UITableView alloc] initWithFrame:CGRectMake(640, 0, 320, [[UIScreen mainScreen]bounds].size.height-20-44-44-49)];
    _comment.backgroundColor=[UIColor whiteColor];
    _comment.delegate=self;
    _comment.dataSource=self;
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [_comment setTableFooterView:view];
    
    [self.scrollView addSubview:_productDetail];
    [self.scrollView addSubview:_imgDetail];
    [self.scrollView addSubview:_comment];
    
    
    
    /**
     *  商品轮播图
     *
     */
    //    图片的宽
    CGFloat imageW = self.imgScroll.frame.size.width;
    //    CGFloat imageW = 300;
    //    图片高
    CGFloat imageH = self.imgScroll.frame.size.height;
    //    图片的Y
    CGFloat imageY = 0;
    
    
    //   1.添加轮播图片
    for (int i = 0; i < rollPics.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        //        图片X
        CGFloat imageX = i * imageW;
        //        设置frame
        imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
        //        设置图片
        if ([pics isKindOfClass:[NSNull class]]) {
            url=@"";
        }else{
            NSDictionary*dict=(NSDictionary*)[rollPics objectAtIndex:i];
            url=[NSString stringWithFormat:@"http://www.haoapp123.com/app/localuser/aidongdong/%@",[dict objectForKey:@"pic"]];
        }
        
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"testuser3"]];
        //        隐藏指示条
        self.imgScroll.showsHorizontalScrollIndicator = NO;
        
        [self.imgScroll addSubview:imageView];
    }
    
    //    2.设置scrollview的滚动范围
    CGFloat contentW = pics.count *imageW;
    //不允许在垂直方向上进行滚动
    self.imgScroll.contentSize = CGSizeMake(contentW, 0);
    
    //    3.设置分页
    self.imgScroll.pagingEnabled = YES;
    
    //    4.监听scrollview的滚动
    self.imgScroll.delegate = self;
    
    [self addTimer];
    
    
    self.pageControl.tintColor=[UIColor grayColor];
    self.pageControl.currentPageIndicatorTintColor=[UIColor orangeColor];
    self.pageControl.pageIndicatorTintColor=[UIColor grayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (void)segmentedControlChangedValue:(HMSegmentedControl *)segmentedControl {
	NSLog(@"Selected index %ld (via UIControlEventValueChanged)", (long)segmentedControl.selectedSegmentIndex);
}
#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat pageWidth = scrollView.frame.size.width;
    NSInteger page = scrollView.contentOffset.x / pageWidth;
    
    [self.segmentedControl setSelectedSegmentIndex:page animated:YES];
}
#pragma mark - TableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}
#pragma mark - TableViewDataSource
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 为表格行定义一个静态字符串作为标识符
	static NSString* cellId = @"cellId";
	// 从可重用表格行的队列中取出一个表格行
	ProductCommentTableViewCell* cell = [tableView
                                         dequeueReusableCellWithIdentifier:cellId];
	// 如果取出的表格行为nil
	if(cell == nil)
	{
		// 创建自定义的FKBookTableCell对象
		cell = [[ProductCommentTableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
	}
	// 从IndexPath参数中获取当前行的行号
	NSUInteger rowNo = indexPath.row;
	//将单元格的边框设置为圆角
	cell.layer.cornerRadius = 12;
	cell.layer.masksToBounds = YES;
	// 为表格行的nameField、priceField的text设置值
	cell.nameField.text = [books objectAtIndex:rowNo];
	cell.timeField.text = [prices objectAtIndex:rowNo];
    cell.content.text=[books objectAtIndex:rowNo];
	return cell;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return books.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
// 该方法的返回值将作为表格行的高度。
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:
(NSIndexPath *)indexPath
{
	return 60;
}
#pragma mark - 轮播图

- (void)nextImage
{
    int page = (int)self.pageControl.currentPage;
    if (page == 2) {
        page = 0;
    }else
    {
        page++;
    }
    
    //  滚动scrollview
    CGFloat x = page * self.imgScroll.frame.size.width;
    self.imgScroll.contentOffset = CGPointMake(x, 0);
}

// scrollview滚动的时候调用
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    计算页码
    //    页码 = (contentoffset.x + scrollView一半宽度)/scrollView宽度
    CGFloat scrollviewW =  scrollView.frame.size.width;
    CGFloat x = scrollView.contentOffset.x;
    int page = (x + scrollviewW / 2) /  scrollviewW;
    self.pageControl.currentPage = page;
}

// 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //    关闭定时器(注意点; 定时器一旦被关闭,无法再开启)
    //    [self.timer invalidate];
    [self removeTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    //    开启定时器
    [self addTimer];
}

/**
 *  开启定时器
 */
- (void)addTimer{
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
/**
 *  关闭定时器
 */
- (void)removeTimer
{
    [self.timer invalidate];
}

@end
