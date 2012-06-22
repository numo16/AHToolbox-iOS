//
//  Exception.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Exception : NSObject

@property(nonatomic,strong) NSString * Stack_trace;
@property(nonatomic,strong) NSString * Message;
@property(nonatomic,strong) NSString * Type;
@property(nonatomic,strong) NSString * Inner_exception;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
