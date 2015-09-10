//
//  ZHWWeakTimer.m
//  ScrollViewUnit
//
//  Created by zhw on 15/9/9.
//  Copyright (c) 2015年 zhw. All rights reserved.
//

#import "ZHWWeakTimer.h"


@interface ZHWWeakTimerTarget : NSObject

/**
 *  伪装的target
 */
@property(nonatomic,weak) id target;
/**
 *  要执行的方法
 */
@property(nonatomic,assign) SEL selector;
/**
 *  定时器
 */
@property(nonatomic,weak)NSTimer *timer;

@end

@implementation ZHWWeakTimerTarget

-(void)fire:(NSTimer *)timer;{
    if (self.target) {
        
#pragma clang  diagnostic push
#pragma clang  diagnostic ignord "-Warc-performSelector-leaks"
        
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
        
#pragma clang diagnostic pop
        
    } else {
        [self.timer invalidate];
    }
}

@end


@interface ZHWWeakTimer ()

@end

@implementation ZHWWeakTimer

+(NSTimer*)scheduleTimerWithTimeInterval:(NSTimeInterval)interval
                                  target:(id)myTarget
                                selector:(SEL)mySelector
                                userinfo:(id)userInfo
                                 repeats:(BOOL)repeats{
    ZHWWeakTimerTarget *timerTarget = [[ZHWWeakTimerTarget alloc]init];
    timerTarget.target = myTarget;
    timerTarget.selector = mySelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    return timerTarget.timer;
}

+(NSTimer *)scheduleTimerWithTimeInterVAl:(NSTimeInterval)interval
                                    block:(ZHWTimerHandler)block
                                 userInfo:(id)userInfo
                                  repeats:(BOOL)repeats{
    NSMutableArray *userInfoArray = [NSMutableArray arrayWithObject:[block copy]];
    if (userInfo != nil) {
        [userInfoArray addObject:userInfo];
        
    }
    
    return [self scheduleTimerWithTimeInterval:interval
                                        target:self
                                      selector:@selector(_timerBlcokInvoke:)
                                      userinfo:[userInfoArray copy]
                                       repeats:repeats];

}

+(void)_timerBlcokInvoke:(NSArray *)userInfo{
    ZHWTimerHandler block = userInfo[0];
    id info = nil;
    if (userInfo.count == 2) {
        info = userInfo[1];
    }
    
    //or `!block ?: block();` @sunnyxx
    
    if (block) {
        block(info);
    }
}

@end
