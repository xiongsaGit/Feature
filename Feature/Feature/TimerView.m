//
//  TimerView.m
//  TestNetwork
//
//  Created by sa.xiong on 15/9/11.
//  Copyright © 2015年 sa.xiong. All rights reserved.
//

#import "TimerView.h"
#import <QuartzCore/CADisplayLink.h>

static CGFloat const kLabelWidth = 12;
static CGFloat const kLabelHeight = 20;
static CGFloat const kOriginX = 5;

@interface TimerView()

/**
 *  显示格式：12：13：14
 *  分别对应hourLabel,hourSingleLabel:minuteLabel,minuteSingleLabel:secondLabel,secondSingleLabel
 */
@property (nonatomic, strong) UILabel *hourLabel;
@property (nonatomic, strong) UILabel *hourSingleLabel;
@property (nonatomic, strong) UILabel *hourSepLabel;

@property (nonatomic, strong) UILabel *minuteLabel;
@property (nonatomic, strong) UILabel *minuteSingleLabel;
@property (nonatomic, strong) UILabel *minuteSepLabel;

@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *secondSingleLabel;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *theTimer;

@end

@implementation TimerView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.hourLabel = [self factoryForLabel];
        self.hourSingleLabel = [self factoryForLabel];
        self.hourSepLabel = [self factoryForLabel];
        self.minuteLabel = [self factoryForLabel];
        self.minuteSingleLabel = [self factoryForLabel];
        self.minuteSepLabel = [self factoryForLabel];
        self.secondLabel = [self factoryForLabel];
        self.secondSingleLabel = [self factoryForLabel];
        
        [self addSubview:self.hourLabel];
        [self addSubview:self.hourSingleLabel];
        [self addSubview:self.hourSepLabel];
        [self addSubview:self.minuteLabel];
        [self addSubview:self.minuteSingleLabel];
        [self addSubview:self.minuteSepLabel];
        [self addSubview:self.secondLabel];
        [self addSubview:self.secondSingleLabel];
        
        self.hourSepLabel.text = @":";
        self.minuteSepLabel.text = @":";
        self.hourSepLabel.backgroundColor = [UIColor clearColor];
        self.minuteSepLabel.backgroundColor = [UIColor clearColor];

        
        
        [self configureFrame];
//        [self refreshTime];
       
            
        _theTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(MyTask)];
        _theTimer.paused = YES;

        _theTimer.frameInterval = 1;
            
        [_theTimer addToRunLoop: [NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
            
  
//        //停用
//        
//        [theTimer invalidate];
//        
//        theTimer = nil;
        
    }
    return self;
}


/*
 
 self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTextColor)];
 self.displayLink.paused = YES;
 [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
 -(void)updateTextColor{}
 - (void)startAnimation{
 self.beginTime = CACurrentMediaTime();
 self.displayLink.paused = NO;
 }
 - (void)stopAnimation{
 self.displayLink.paused = YES;
 [self.displayLink invalidate];
 self.displayLink = nil;
 }
 
 */
- (void)MyTask
{
    [self refreshTime];
}

- (void)configureFrame
{
    CGFloat whiteSpace = (CGRectGetWidth(self.frame)-7*kLabelWidth-7*kOriginX)/2;
    
    [self.hourLabel mas_makeConstraints:^(MASConstraintMaker *make){
    
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.mas_left).offset(whiteSpace);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, kLabelHeight)).priorityHigh();
    
    }];
    
    [self.hourSingleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.hourLabel.mas_right).offset(kOriginX);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, kLabelHeight)).priorityHigh();
        
    }];
    
    [self.hourSepLabel mas_remakeConstraints:^(MASConstraintMaker *make){
    
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.hourSingleLabel.mas_right).offset(kOriginX);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth/2, kLabelHeight)).priorityHigh();

    }];
    
    [self.minuteLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.hourSepLabel.mas_right).offset(kOriginX);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, kLabelHeight)).priorityHigh();
        
    }];
    
    [self.minuteSingleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.minuteLabel.mas_right).offset(kOriginX);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, kLabelHeight)).priorityHigh();
        
    }];
    
    [self.minuteSepLabel mas_remakeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.self.minuteSingleLabel.mas_right).offset(kOriginX);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth/2, kLabelHeight)).priorityHigh();
        
    }];
    
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.minuteSepLabel.mas_right).offset(kOriginX);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, kLabelHeight)).priorityHigh();
        
    }];
    
    [self.secondSingleLabel mas_makeConstraints:^(MASConstraintMaker *make){
        
        make.centerY.mas_equalTo(self.mas_centerY);
        make.left.mas_equalTo(self.secondLabel.mas_right).offset(kOriginX);
        make.size.mas_equalTo(CGSizeMake(kLabelWidth, kLabelHeight)).priorityHigh();
        
    }];
    

}

- (void)handleTimerRefresh
{
    [self refreshTime];
}

/*
- (void)startAnimation{
    self.beginTime = CACurrentMediaTime();
    self.displayLink.paused = NO;
}
- (void)stopAnimation{
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}
*/
- (void)closeTimer
{

    self.theTimer.paused = YES;
    
//    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)openTimer
{
    self.theTimer.paused = NO;
//    [self.timer setFireDate:[NSDate distantPast]];
}


- (NSInteger)getTime:(NSString *)timeString
{
    NSInteger sumCount = 0;
    NSArray *arr = [timeString componentsSeparatedByString:@":"];
    for (int i = 0;i < arr.count; i ++)
    {
        int count = 10*[[arr[i] substringToIndex:1] intValue]+[[arr[i] substringFromIndex:1] intValue];
        if (i == 0)
        {
            sumCount += 3600 *count;
        }else if (i == 1)
        {
            sumCount += 60 *count;
        }else
            sumCount += count;
    }
    return sumCount;
}


- (NSMutableArray *)getStringTime:(NSInteger)counts
{
    NSMutableArray *array = [NSMutableArray array];
    if (counts >3600)
    {
        if (counts/3600>9)
        {
            [array addObject:[NSString stringWithFormat:@"%ld",counts/3600/9]];
            [array addObject:[NSString stringWithFormat:@"%ld",counts/3600%9]];
        }else
        {
            [array addObject:@"0"];
            [array addObject:[NSString stringWithFormat:@"%ld",counts/3600%9]];
        }
        if (counts%3600/60>9)
        {
            [array addObject:[NSString stringWithFormat:@"%ld",counts%3600/60/9]];
            [array addObject:[NSString stringWithFormat:@"%ld",counts%3600/60%9]];
            
        }else
        {
            [array addObject:@"0"];
            [array addObject:[NSString stringWithFormat:@"%ld",counts%3600/60%9]];
            
        }
        
        if (counts%3600%60>9)
        {
            [array addObject:[NSString stringWithFormat:@"%ld",counts%3600%60/9]];
            [array addObject:[NSString stringWithFormat:@"%ld",counts%3600%60%9]];
            
        }else
        {
            [array addObject:@"0"];
            [array addObject:[NSString stringWithFormat:@"%ld",counts%3600%60%9]];
            
        }
        
    }else if (counts>60&&counts<3600)
    {
        [array addObject:@"0"];
        [array addObject:@"0"];

        /**
         *  这里算的有错无
         
         */
        if (counts/60>9)
        {
            [array addObject:[NSString stringWithFormat:@"%ld",counts/60/9]];
            [array addObject:[NSString stringWithFormat:@"%ld",counts/60%9]];
        }else
        {
            [array addObject:@"0"];
            [array addObject:[NSString stringWithFormat:@"%ld",counts/60%9]];
        }
        
        if (counts%60>9)
        {
            [array addObject:[NSString stringWithFormat:@"%ld",counts%60/9]];
            [array addObject:[NSString stringWithFormat:@"%ld",counts%60%9]];
            
        }else
        {
            [array addObject:@"0"];
            [array addObject:[NSString stringWithFormat:@"%ld",counts%60]];
            
        }
    }else
    {
        [array addObject:@"0"];
        [array addObject:@"0"];
        [array addObject:@"0"];
        [array addObject:@"0"];
        if (counts>9)
        {
            [array addObject:[NSString stringWithFormat:@"%ld",counts/9]];
            [array addObject:[NSString stringWithFormat:@"%ld",counts%9]];

        }else
        {
            [array addObject:@"0"];

            [array addObject:[NSString stringWithFormat:@"%ld",counts]];

        }
    }
    return array;
}


- (NSInteger)getIntervalBetweenDateNow:(NSString *)dateNow baseDate:(NSString*)baseDate
{
    NSArray *nowArray = [dateNow componentsSeparatedByString:@":"];
    NSArray *baseArray = [baseDate componentsSeparatedByString:@":"];
    
    
    NSInteger nowCounts = 0;
    NSInteger baseCounts = 0;
    for (int i = 0; i< nowArray.count; i++)
    {
        if (i == 0)
        {
            nowCounts+=3600 *[nowArray[0] intValue];
            baseCounts += 3600 *[baseArray[0] intValue];
        }else if (i ==1)
        {
            nowCounts+=60 *[nowArray[1] intValue];
            baseCounts += 60 *[baseArray[1] intValue];
        }else
        {
            nowCounts+=[nowArray[2] intValue];
            baseCounts += [baseArray[2] intValue];
        }
    
    }
    
    if (nowCounts<baseCounts)
    {
        
        NSInteger minus = baseCounts-nowCounts;
        if (minus>3600)
        {
//            minus/3600;//时
//            minus%3600;//分
        }
        
        return baseCounts-nowCounts;
    }
    return -1;

}

- (NSMutableArray *)timeFormatted:(NSInteger)totalSeconds
{
    NSMutableArray *sourceArray = [NSMutableArray array];
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
    NSInteger hours = totalSeconds / 3600;
    
    if (hours >9)
    {
        [sourceArray addObject:[NSString stringWithFormat:@"%ld",hours/10]];
        [sourceArray addObject:[NSString stringWithFormat:@"%ld",hours%10]];
    }else
    {
        [sourceArray addObject:@"0"];
        [sourceArray addObject:[NSString stringWithFormat:@"%ld",hours]];
    }
    
    if (minutes >9)
    {
        [sourceArray addObject:[NSString stringWithFormat:@"%d",minutes/10]];
        [sourceArray addObject:[NSString stringWithFormat:@"%d",minutes%10]];
    }else
    {
        [sourceArray addObject:@"0"];
        [sourceArray addObject:[NSString stringWithFormat:@"%d",minutes]];
    }
    
    if (seconds >9)
    {
        [sourceArray addObject:[NSString stringWithFormat:@"%d",seconds/10]];
        [sourceArray addObject:[NSString stringWithFormat:@"%d",seconds%10]];
    }else
    {
        [sourceArray addObject:[NSString stringWithFormat:@"%d",0]];
        [sourceArray addObject:[NSString stringWithFormat:@"%d",seconds]];
    }
    
    return sourceArray;
}

- (void)refreshTime
{
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm:ss"];
    date = [formatter stringFromDate:[NSDate date]];
    
    
    [self showTime:[self timeFormatted:[self getIntervalBetweenDateNow:date baseDate:@"20:00:00"]]];
    
}

- (void)showTime:(NSMutableArray *)array
{
    [self.hourLabel setText:array[0]];
    [self.hourSingleLabel setText:array[1]];
    
    [self.minuteLabel setText:array[2]];
    [self.minuteSingleLabel setText:array[3]];
    
    [self.secondLabel setText:array[4]];
    [self.secondSingleLabel setText:array[5]];
}


- (UILabel *)factoryForLabel
{
    UILabel *lbl = [[UILabel alloc] init];
    [lbl setTextColor:[UIColor lightGrayColor]];
    [lbl setBackgroundColor:UIColorFromHex(0x343436)];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    [lbl setFont:[UIFont systemFontOfSize:13]];
    return lbl;
}


/**
 *  什么时候停止计时器
 *  [timer invalidate];
 *   timer = nil;
 */
- (void)dealloc
{
    [self.timer invalidate];
    self.timer = nil;
    
    [self.theTimer invalidate];
    self.theTimer = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
