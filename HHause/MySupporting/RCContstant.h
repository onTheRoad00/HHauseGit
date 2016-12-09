//
//  RCContstant.h
//  HHause
//
//  Created by HHause on 16/5/3.
//  Copyright © 2016年 HHause. All rights reserved.
//

#ifndef RCContstant_h
#define RCContstant_h
/**
 * 屏幕bounds
 */
#define kUIScreenBounds ([UIScreen mainScreen].bounds)

/**
 * 屏幕宽度
 */
#define kScreeWidth [UIScreen mainScreen].bounds.size.width

/**
 * 屏幕高度
 */
#define kScreeHeight [UIScreen mainScreen].bounds.size.height

#pragma mark--------------API-----------------------

/**
 * 前缀
 */
#define KAPIPrefix @"https://api.hhause.com/1"

//////////七牛////////
#define KAPIQINIU @"http://7xqgvl.com2.z0.glb.qiniucdn.com/"
//////////汇率////////
#define KAPIEXCHANGE            [NSString stringWithFormat:@"%@/util/get_exchange",KAPIPrefix]

///////////////////////Home////////////////////
/**
 * 获得热门区域列表
 */
#define KAPIGet_hot_areas       [NSString stringWithFormat:@"%@/home/get_hot_areas",KAPIPrefix]
/**
 * 获得精选好房推荐
 */
#define KAPIGet_recommendeds [NSString stringWithFormat:@"%@/home/get_recommends",KAPIPrefix]

/**
 * 获取推荐搜索词汇
 */
#define KAPISearch_suggest [NSString stringWithFormat:@"%@/search/suggest",KAPIPrefix]
/**
 *  得到二级城市
 */
#define KAPIList_cities [NSString stringWithFormat:@"%@/search/list_cities?metro_area",KAPIPrefix]

/**
 * 搜索房源
 */
#define KAPIHome_search [NSString stringWithFormat:@"%@/home/search",KAPIPrefix]
/**
 * 获取房源详细信息
 */
#define KAPIHome_get [NSString stringWithFormat:@"%@/home/get",KAPIPrefix]
/**
 * 房源附近学校列表详细信息
 */
#define KAPISchool_List_around [NSString stringWithFormat:@"%@/school/list_around",KAPIPrefix]
/**
 * 城市详细信息
 */
#define KAPICity_get_data [NSString stringWithFormat:@"%@/city/get_data",KAPIPrefix]
//////////////////登陆注册  account////////////////////////////////////
/**
 注册新用户
 */
#define KAPIAccount_register [NSString stringWithFormat:@"%@/account/register",KAPIPrefix]
/**
 * 用户登录
 */
#define KAPIAccount_login [NSString stringWithFormat:@"%@/account/login",KAPIPrefix]

/**
 * 修改密码
 */
#define KAPIAccount_update_password [NSString stringWithFormat:@"%@/account/update_password",KAPIPrefix]

/**
 * 忘记密码
 */
#define KAPIAccount_reset_password [NSString stringWithFormat:@"%@/account/reset_password",KAPIPrefix]

/**
 * 发动短信验证码
 */
#define KAPIUtil_send_vcode [NSString stringWithFormat:@"%@/util/send_vcode",KAPIPrefix]

/**
 * 第三方登陆验证
 */
#define KAPIAUTHORIZE [NSString stringWithFormat:@"%@/account/authorize",KAPIPrefix]

/**
 * 刷新访问令牌
 */
#define KAPIREFRESH [NSString stringWithFormat:@"%@/account/refresh",KAPIPrefix]

/**
 * 提交反馈
 */
#define KAPIFEEDBACK [NSString stringWithFormat:@"%@/feedback/post",KAPIPrefix]

/**
 * 收藏房源
 */
#define KAPIFAVOR_add_home [NSString stringWithFormat:@"%@/favor/add_home",KAPIPrefix]

/**
 * 删除收藏
 */
#define KAPIFAVOER_romeve_home [NSString stringWithFormat:@"%@/favor/remove_home",KAPIPrefix]

/**
 * 获取收藏列表
 */
#define KAPIFAVOR_list_homes [NSString stringWithFormat:@"%@/favor/list_homes",KAPIPrefix]

/**
 * 获取历史记录
 */
#define KAPIHOME_list_visited [NSString stringWithFormat:@"%@/home/list_visited",KAPIPrefix]



//////////////////文章  wiki////////////////////////////////////
/**
 * 获取"置业百科"首页内容
 */
#define KAPIwikiGet_index [NSString stringWithFormat:@"%@/wiki/get_index",KAPIPrefix]
/**
 * 获取置业百科文章列表
 */
#define KAPIWikiLists [NSString stringWithFormat:@"%@/wiki/lists",KAPIPrefix]
/**
 * 获取文章具体内容
 */
#define KAPIwikiGet [NSString stringWithFormat:@"%@/wiki/get",KAPIPrefix]
///////////////////////查房价////////////////////
/**
 * 都市圈下的城市列表数据
 */
#define KAPICity_lists [NSString stringWithFormat:@"%@/city/lists",KAPIPrefix]
/**
 * 都市圈下的城市数据
 */
#define KAPICity_get [NSString stringWithFormat:@"%@/city/get",KAPIPrefix]

/**
 * 获取某地区的全部关键数据
 */
#define KAPIMarket_data_get_all [NSString stringWithFormat:@"%@/market_data/get_all",KAPIPrefix]
/**
 * 获取指定区域最近一个月的房价数据
 */
#define KAPIMarket_data_get_latest [NSString stringWithFormat:@"%@/market_data/get_latest",KAPIPrefix]



#define KAPI [NSString stringWithFormat:@"%@",KAPIPrefix]


#pragma mark-----------UserDefaults KEY-----------------
#define KKEYSearch_suggest          @"search_suggest_city"
//登陆成功OR失败
#define KKEYLogin_successORdefeat   @"Login_successORdefeat"
//成功
#define KKEYLogin_success           @"success"
//失败
#define KKEYLogin_defeat            @"defeat"
//授权令牌
#define KKEYAccess_token            @"access_token"
//刷新令牌
#define KKEYRefresh_token           @"refresh_token"
//昵称
#define KKEYNickName                @"nickname"
#define KKEYHeadImageUrl            @"headImageUrl"
//搜索历史
#define KKEYSearchHistoryAry        @"searchHistoryAry"

#define KKEYExchange                @"Exchange"
#define KKEYUUID                    @"X-Tracing-Id"
#pragma mark-----------颜色-----------------
/**
 * 灰
 */
#define KColor  [UIColor colorWithRed:238/255.0 green:239/255.0 blue:240/255.0 alpha:1]
/**
 * 蓝
 */
#define KTextColor  [UIColor colorWithRed:66/255.0 green:112/255.0 blue:191/255.0 alpha:1]
/**
 * 浅灰
 */
#define KborderColor [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1]
/**
 * 棕色
 */
#define KbuttonColor [UIColor colorWithRed:198/255.0 green:153/255.0 blue:78/255.0 alpha:1]
/**
 * 灰
 */
#define KGaryColor [UIColor colorWithRed:174/255.0 green:174/255.0 blue:174/255.0 alpha:1]
/**
 * 239 灰
 */
#define K239GaryColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1]
/**
 * 249 灰
 */
#define K249GaryColor [UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1]
/**
 * 153 灰
 */
#define K153GaryColor [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1]

/**
 * 102 灰
 */
#define K102GaryColor [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1]
/**
 * 51 灰
 */
#define K51GaryColor [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1]
/**
 * 3 灰
 */
#define K3GaryColor [UIColor colorWithRed:3/255.0 green:3/255.0 blue:3/255.0 alpha:1]
#endif 
/* RCContstant_h */
