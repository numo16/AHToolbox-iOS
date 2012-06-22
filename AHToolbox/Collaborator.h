//
//  Collaborator.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"


@class User;

@interface Collaborator : NSObject

@property(nonatomic,strong) User * user;
@property(nonatomic,strong) NSString * Role;
@property(nonatomic,strong) NSString * Url;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end