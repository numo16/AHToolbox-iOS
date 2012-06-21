//
//  URLParser.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface URLParser : NSObject

@property (strong, nonatomic) NSArray *variables;

- (id)initWithUrlString:(NSString*)url;
- (id)initWithParamString:(NSString*)params;
- (NSString*)valueForVariable:(NSString*)varName;

@end
