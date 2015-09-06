//
//  ServerConfig.h
//  CourseCenter
//
//  Created by renxiaojian on 15/6/4.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#ifndef CourseCenter_ServerConfig_h
#define CourseCenter_ServerConfig_h


#pragma mark- 服务器IP

//***********测试环境************/
    ///服务器IP
#define kServerIP           [NSString stringWithFormat:@"%@%@",@"http://",[[NSUserDefaults standardUserDefaults]objectForKey:@"schoolUrl"]]
    ///服务器端口号
#define kServerPort         @"/AppServer"

////***********正式环境************/
//    ///服务器IP
//#define kServerIP           @"http://cooc.smmu.edu.cn"
//    ///服务器端口号
//#define kServerPort         @"/AppServer"




#define kSerVerName         @"/ies2"
#define kServiceName        @""


#endif
