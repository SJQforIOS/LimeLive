//
//  APIConfig.h
//  InKe
//
//  Created by sjq on 17/9/8.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APIConfig : NSObject

/*
 *喵播资源
 */

//信息类服务器地址
#define SERVER_HOST @"http://live.9158.com/Fans/"

//热门直播
#define API_HotLive @"http://live.9158.com/Fans/GetHotLive?page=%d"

/*
 *我家直播后台数据
 */

//附近的人
#define API_NearLive @"api/live/near_recommend" //?uid=85149891&latitude=40.090562&longitude=116.413353

//广告地址
#define API_Advertise @"advertise/get"


//测试直播地址
#define Live_SJQ @"rtmp://p68ed453b.live.126.net/live/sjq"

//ceshi
//rtmp://live.hkstv.hk.lxdns.com/live/hks
//rtmp://live.hkstv.hk.lxdns.com:1935/live/sunjiaqi
//rtmp://p68ed453b.live.126.net/live/484ff1cfe86a496799f6548b7febd29d?wsSecret=cedf71973e8fd4e3f68f8ba418eab01c&wsTime=1516673905

@end
