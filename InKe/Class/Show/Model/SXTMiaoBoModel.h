//
//  SXTMiaoBoModel.h
//  InKe
//
//  Created by sjq on 17/9/14.
//  Copyright © 2017年 sjq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SXTMiaoBoModel : NSObject

/** 直播封面图 */
@property (nonatomic, strong) NSString   *bigpic;
/** 主播头像 */
@property (nonatomic, strong) NSString   *smallpic;
/** 直播流地址 */
@property (nonatomic, strong) NSString   *flv;
/** 所在城市 */
@property (nonatomic, strong) NSString   *gps;
/** 主播名 */
@property (nonatomic, strong) NSString   *myname;
/** 个性签名 */
@property (nonatomic, strong) NSString   *signatures;
/** 用户ID */
@property (nonatomic, strong) NSString   *userId;
/** 星级 */
@property (nonatomic, assign) NSUInteger starlevel;
/** 朝阳群众数目 */
@property (nonatomic, assign) NSNumber *allnum;
/** 这玩意未知 */
@property (nonatomic, assign) NSUInteger lrCurrent;
/** 直播房间号码 */
@property (nonatomic, assign) NSUInteger roomid;
/** 所处服务器 */
@property (nonatomic, assign) NSUInteger serverid;
/** 用户ID */
@property (nonatomic, strong) NSString *useridx;
/** 排名 */
@property (nonatomic, assign) NSUInteger pos;
/** starImage */
@property (nonatomic, strong) UIImage *starImage;

@property (nonatomic, assign) NSInteger sex;
@property (nonatomic, assign) NSInteger liveTimes;//直播时长
@property (nonatomic, assign) BOOL isRealName;    //是否实名
@property (nonatomic, assign) BOOL isCommentIphone;  //是否关联手机

+(SXTMiaoBoModel *)modelWithDict:(NSDictionary *)dic;

@end
