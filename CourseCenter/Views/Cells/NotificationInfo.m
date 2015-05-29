//
//  NotificationInfo.m
//  CourseCenter
//
//  Created by renxiaojian on 15/5/28.
//  Copyright (c) 2015年 line0.com. All rights reserved.
//

#import "NotificationInfo.h"

@implementation NotificationInfo

- (id)initDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        self.name = [dict objectForKey: kname];
        self.date = [dict objectForKey: kdate];
        self.title = [dict objectForKey:ktitle];
        self.message = [dict objectForKey:kmessage];
        NSArray *imgArray = [dict objectForKey:kimgs];
        NSMutableArray *imgs = [[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<imgArray.count; i++) {
            imgInfo *img = [[imgInfo alloc] init];
            img.url = [imgArray[i] objectForKey:@"url"];
            [imgs addObject:img];
        }
        self.imgs = imgs;
        NSMutableArray *items = [[NSMutableArray alloc] initWithCapacity:0];
        NSArray *array = [dict objectForKey:kitems];
        for (int i=0; i<array.count; i++) {
            Item *itemIfno = [[Item alloc] init];
            itemIfno.itemContent = [array[i] objectForKey:@"itemContent"];
            itemIfno.itemName = [array[i] objectForKey:@"itemName"];
            itemIfno.toName = [array[i] objectForKey:@"toName"];
            [items addObject:itemIfno];
        }
        self.items = items;
    }
    return self;
}


@end

@implementation Item


@end

@implementation imgInfo


@end
