//
//  ZHWWeakTimer.h
//  ScrollViewUnit
//
//  Created by zhw on 15/9/9.
//  Copyright (c) 2015年 zhw. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^ZHWTimerHandler)(id userInfo);

@interface ZHWWeakTimer : NSObject
/**
 *  类方法 创建定时器
 *
 *  @param interval   时间间隔
 *  @param myTarget   target
 *  @param mySelector 要执行的方法
 *  @param userInfo   userInfo
 *  @param repeats    是否重复执行
 *
 *  @return NSTimer
 */
+(NSTimer *)scheduleTimerWithTimeInterval:(NSTimeInterval)interval
                                   target:(id)myTarget
                                 selector:(SEL)mySelector
                                 userinfo:(id)userInfo
                                  repeats:(BOOL)repeats;

/**
 *  类方法 使用block创建
 *
 *  @param interval 时间间隔
 *  @param block    block
 *  @param userInfo userInfo
 *  @param repeats  是否重复执行
 *
 *  @return NSTimer
 */
+(NSTimer *)scheduleTimerWithTimeInterVAl:(NSTimeInterval)interval
                                    block:(ZHWTimerHandler)block
                                 userInfo:(id)userInfo
                                  repeats:(BOOL)repeats;

@end
