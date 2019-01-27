//
//  ZFStudent.h
//  ZFBaseFramework_Example
//
//  Created by zf on 2019/1/27.
//  Copyright © 2019 478043385@qq.com. All rights reserved.
//

#import <Realm/Realm.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZFStudent : RLMObject

@property int num;
@property NSString *name;
@property int age;
@property NSString *dis;
@end

NS_ASSUME_NONNULL_END

//RLMArray<XXX *><XXX> *arr
RLM_ARRAY_TYPE(ZFStudent)
