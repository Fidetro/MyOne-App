//
//  ReadingTableViewController.m
//  working
//
//  Created by ios-28 on 16/3/8.
//  Copyright © 2016年 kun. All rights reserved.
//


#import "ReadingTableViewController.h"
#import "FIDReadingCell.h"
#import "PlayingToolView.h"
#import "AudioTool.h"
#import "FIMusic.h"
#import "UIImageView+FIDDownLoadImage.h"
#import "FIObserverNetWork.h"
@interface ReadingTableViewController ()<UIScrollViewDelegate,moveView,AVAudioPlayerDelegate>
@property(nonatomic,strong)NSArray *plistArray;
@property(nonatomic,strong)NSMutableArray *allMusic;

@property(nonatomic,strong)PlayingToolView *playingToolView; //播放栏
@property(nonatomic,strong)UIView *headView;//tableview的headview
@property(nonatomic,strong)NSTimer *currentTime;
@property(nonatomic,strong)AVAudioPlayer *currentPlayer;
@end

@implementation ReadingTableViewController
//记录当前播放的音乐名字
static FIMusic *_playingMusic;
- (instancetype)init{
    
    
    if (self = [super init]) {
        UIImage *deselectedImage = [[UIImage imageNamed:@"tabbar_item_reading"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UIImage *selectedImage = [[UIImage imageNamed:@"tabbar_item_reading_selected"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        // 底部导航item
        UITabBarItem *tabBarItem = [[UITabBarItem alloc] initWithTitle:@"音乐" image:nil tag:0];
        tabBarItem.image = deselectedImage;
        tabBarItem.selectedImage = selectedImage;
        self.tabBarItem = tabBarItem;
        self.navigationItem.title = @"音乐";
    }
    return self;
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
        [self.tableView.tableHeaderView setHidden:YES];
  
}
#pragma mark - 手势动作
-(void)tapGesture:(UITapGestureRecognizer *)sender
{
    // 1.获取点击的位置
    CGPoint point = [sender locationInView:sender.view];
    // 2.获取x除以总长度，得到点击位置在全长中的比例
    CGFloat ratio = point.x / self.playingToolView.progressSlider.bounds.size.width;
    
    // 3.改变歌曲播放的位置
    self.currentPlayer.currentTime = self.currentPlayer.duration * ratio;
  
    // 4.更新进度
    [self updateProgressInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];    
    self.tableView.showsVerticalScrollIndicator = NO;//隐藏右边滚动条

#pragma mark - ButtonItem
    UIBarButtonItem *showItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"miniplayer_btn_playlist_close"] style:UIBarButtonItemStylePlain target:self action:@selector(startMusicAnimate)];
    self.navigationItem.rightBarButtonItem =showItem;
 
    if(![self.currentPlayer isPlaying]){ //如果不在播放，rightBarButton不能点击
    self.navigationItem.rightBarButtonItem.enabled = NO;
    }

    self.playingToolView = [[PlayingToolView alloc]initWithTargetView:self.view andFrame:CGRectMake(0, -120, GetViewWidth(self.view),100)];
    
#pragma mark - 拖动手势控制进度条
//    UITapGestureRecognizer *tapGR= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];    
//    [self.playingToolView.progressSlider addGestureRecognizer:tapGR];
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.playingToolView.progressSlider addGestureRecognizer:panGesture];
    self.playingToolView.delegate = self;
    [self.playingToolView.playOrPauseButton addTarget:self action:@selector(playOrPause) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self.playingToolView.nextButton addTarget:self action:@selector(nextMusic) forControlEvents:UIControlEventTouchUpInside];
    [self.playingToolView.previousButton addTarget:self action:@selector(previousMusic) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];

    [self.playingToolView removeFromSuperview];//离开界面到时候移出headview
}

#pragma mark - 开始暂停
- (void)playOrPause{
    self.playingToolView.playOrPauseButton.selected = !self.playingToolView.playOrPauseButton.selected;
    if (self.currentPlayer.isPlaying) {
        [self.currentPlayer pause];

    }else{
        [self.currentPlayer play];
        
    }
}
#pragma mark - 下一首歌
- (void)nextMusic{
 
    NSInteger currentIndex = [self.allMusic indexOfObject:_playingMusic];

     NSInteger nextIndex = ++currentIndex;
    
#warning 因为歌只放了3首，allMusic.count是16首..要点16次..
    if (nextIndex >= self.allMusic.count) {
        nextIndex = 0;
    
    }
    _playingMusic =    (FIMusic *)self.allMusic[nextIndex];
    self.currentPlayer = [AudioTool playMusicWithName:_playingMusic.fileName];
    self.currentPlayer.currentTime = 0;
    self.currentPlayer.delegate = self;
    self.playingToolView.playOrPauseButton.selected = self.currentPlayer.isPlaying;
    
}

#pragma mark - 上一首歌
- (void)previousMusic{
    NSInteger currentIndex = [self.allMusic indexOfObject:_playingMusic];
    NSInteger previousIndex = --currentIndex;
    
#warning 因为歌只放了3首，allMusic.count是16首..要点16次..
    if (previousIndex < 0) {
        previousIndex = self.allMusic.count - 1;
      
    }

    _playingMusic =    (FIMusic *)self.allMusic[previousIndex];
    self.currentPlayer = [AudioTool playMusicWithName:_playingMusic.fileName];
    self.currentPlayer.currentTime = 0;
    self.currentPlayer.delegate = self;
    self.playingToolView.playOrPauseButton.selected = self.currentPlayer.isPlaying;
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - headView
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{

    
    self.headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, GetViewWidth(self.view), 100)];

    return self.headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 100;
}
#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  
    return self.allMusic.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *poster = ((FIMusic *)(self.allMusic[indexPath.row])).poster;
    NSString *name = ((FIMusic *)(self.allMusic[indexPath.row])).name;
    NSString *singer = ((FIMusic *)(self.allMusic[indexPath.row])).singer;
    UIImageView *imageview = [[UIImageView alloc]init];
    UILabel *label1 = [[UILabel alloc]init];

   
      UILabel *label2 = [[UILabel alloc]init];

      label1.layer.borderWidth = 1;
      label2.layer.borderWidth = 1;
    label1.layer.shouldRasterize = YES;
     label2.layer.shouldRasterize = YES;
      label2.numberOfLines = 0;

    FIDReadingCell *cell = [[FIDReadingCell alloc]setCellInTableViewDefault2InTableView:tableView
                                                                     CellHeight:[self tableView:tableView heightForRowAtIndexPath:indexPath]
                                                                   AddImageView:imageview
                                                                 AddFirstLabel:label1 AddSecondLabel:label2 reuseIdentifier:@"readCell"];
  
    label1.text = singer;
    label2.text = name;
    FIObserverNetWork *observerNetWork = [[FIObserverNetWork alloc]init];

    if ([observerNetWork isCurrentReachabilityStatus]) {
  
        [imageview setFIDdownloadImageTaskURLWithString:poster placeholderImage:[UIImage imageNamed:@"default_01"]];
    }

    
    return cell;
}

#pragma mark - 代理方法：playingToolView移出范围的代理方法
- (void)moveView{
    [UIView animateWithDuration:2
                          delay:0
         usingSpringWithDamping:1
          initialSpringVelocity:4
                        options:UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                      
        self.playingToolView.frame =CGRectMake(0, -120, GetViewWidth(self.playingToolView), GetViewHeight (self.playingToolView));
        self.playingToolView.alpha = 0;
    } completion:nil];
}

#pragma mark - 点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
       self.navigationItem.rightBarButtonItem.enabled = YES;
    
    [self startPlayMusicAndSelectRowAtIndexPath:indexPath];
    
    [self startMusicAnimate];
    
    
}

- (void)startMusicAnimate{
      [self.headView addSubview:self.playingToolView];
    self.playingToolView.playOrPauseButton.selected = self.currentPlayer.isPlaying;
    [UIView animateWithDuration:2 delay:0 usingSpringWithDamping:1.0 initialSpringVelocity:6.9 options:UIViewAnimationOptionCurveEaseInOut animations:^{
     
        self.playingToolView.frame = CGRectMake(0, 0, GetViewWidth(self.view), GetViewHeight(self.playingToolView));
        self.playingToolView.alpha = 1;
        
        
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [NSTimer scheduledTimerWithTimeInterval:5
                                                              target:self
                                                            selector:@selector(moveView)
                                                            userInfo:nil
                                                             repeats:NO];
                         }
                     }];
}

#pragma mark - 点击行播放
- (void)startPlayMusicAndSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //点击后把playtoolView加进headView里
  
    /**
     *  点击获取fileName，AudioTool播放fileName音乐
     */
 
    _playingMusic =    (FIMusic *)self.allMusic[indexPath.row];
    self.currentPlayer = [AudioTool playMusicWithName:_playingMusic.fileName];
    self.currentPlayer.currentTime = 0;
     self.currentPlayer.delegate = self;
    self.playingToolView.playOrPauseButton.selected = self.currentPlayer.isPlaying;
    [self removeProgressTimer];
    [self addProgressTimer];
    
}
#pragma mark - 播完自动下一首歌AVAudioPlayerDelegate协议方法
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
//    NSLog(@"真的播完了");
//    if (flag) {
//        NSLog(@"播完了");
        [self nextMusic];
//    }
    NSLog(@"播完了");
}

#pragma mark - 加入定时器
- (void)addProgressTimer
{
    [self updateProgressInfo];
    self.currentTime = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateProgressInfo) userInfo:nil repeats:YES];
}
- (void)removeProgressTimer
{
    NSLog(@"remove");
    [self.currentTime invalidate];
    self.currentTime = nil;
}
#pragma mark - 更新进度条
-(void)updateProgressInfo
{

    self.playingToolView.progressSlider.value = self.currentPlayer.currentTime / self.currentPlayer.duration;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}





#pragma mark - 从字典获取存进music对象里，再放进数组
- (NSMutableArray *)allMusic{
    if (!_allMusic) {
        NSString *filePath = [[NSBundle mainBundle]pathForResource:@"Ame" ofType:@"plist"];
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        
        _allMusic = [NSMutableArray array];
        
        for (NSDictionary *dic in array) {
            FIMusic *music = [FIMusic musicWithDict:dic];
            
            [_allMusic addObject:music];
            
            
            
            
        }
     
        
    }
    return _allMusic;
}
- (void)dealloc{
//    NSLog(@"%@",self.playingToolView);
//    NSLog(@"%@",self.headView);
}


//#pragma mark - 归档
//- (void)saveCaches:(NSIndexPath *)indexPath{
//    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[((FIMusic *)self.allMusic[indexPath.row]).poster lastPathComponent]];
//
//    NSMutableData *arrayData = [NSMutableData data];
//
//
//
//
//        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:((FIMusic *)self.allMusic[indexPath.row]).poster]];
//        NSString *singer = ((FIMusic *)self.allMusic[indexPath.row]).singer;
//        NSString *name =((FIMusic *)self.allMusic[indexPath.row]).name;
//        NSString *poster =((FIMusic *)self.allMusic[indexPath.row]).poster;
//
//        NSDictionary *dic = @{@"posterData":data,
//                              @"singer":singer,
//                              @"name":name,
//                              @"poster":poster
//                              };
//
//
//
//    NSKeyedArchiver *KeyedArchiver =    [[NSKeyedArchiver alloc]initForWritingWithMutableData:arrayData];//初始化归档成MutableData
//
//    [KeyedArchiver encodeObject:dic forKey:@"array"];
//    [KeyedArchiver finishEncoding];//完成归档
//    [arrayData writeToFile:cachesPath atomically:YES];//
//
//}
//#pragma mark - 反归档
//- (NSDictionary *)loadCaches:(NSIndexPath *)indexPath{
//    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[((FIMusic *)self.allMusic[indexPath.row]).poster lastPathComponent]];
//
//    NSData *arrayData = [NSData dataWithContentsOfFile:cachesPath];
//    NSKeyedUnarchiver *Unarchiver = [[NSKeyedUnarchiver alloc]initForReadingWithData:arrayData];
//    NSDictionary *dic = [Unarchiver decodeObjectForKey:@"array"];
//
//
//    return dic;
//
//}

//- (NSDictionary *)localData{
//    if (!_localData) {
//        _localData = [NSDictionary dictionary];
//    }
//    return _localData;
//}
//- (FIMusic *)musicList{
//    if (!_musicList) {
//        _musicList = [[FIMusic alloc]init];
//    }
//    return _musicList;
//}
//
//
////存储music对象的数组
//- (NSMutableDictionary *)allMusicDic{
//    if (!_allMusicDic) {
//        _allMusicDic = [NSMutableDictionary dictionary];
//    }
//    return _allMusicDic;
//}
@end
