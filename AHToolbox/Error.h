//
//  Error.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"


@class Exception;

@interface Error : NSObject

@property(nonatomic,strong) NSString * Commit_id;
@property(nonatomic,strong) NSString * Date;
@property(nonatomic,strong) NSString * Request_path;
@property(nonatomic,strong) NSString * Message;
@property(nonatomic,strong) Exception * exception;
@property(nonatomic,strong) NSString * Url;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end