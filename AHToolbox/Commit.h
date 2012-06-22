//
//  Commit.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Commit : NSObject

@property(nonatomic,strong) NSString * Id;
@property(nonatomic,strong) NSString * Message;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
