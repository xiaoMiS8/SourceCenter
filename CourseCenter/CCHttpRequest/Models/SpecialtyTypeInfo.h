//
//  SpecialtyTypeInfo.h
//  
//
//  Created by jian on 15/6/19.
//
//

#import <Foundation/Foundation.h>

@interface SpecialtyTypeInfo : NSObject

    //学科ID
@property(nonatomic, assign) long SpecialtyTypeID;
    //学科编号
@property(nonatomic, strong) NSString *SpecialtyTypeNo;
    //学科门类：哲学
@property(nonatomic, strong) NSString *SpecialtyTypeName;
    //父节点ID
@property(nonatomic, assign) long ParentID;

@end