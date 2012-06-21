//
//  AHDomainObject.h
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AHDomainObject <NSObject>

- (NSDictionary*) asDict;
+ (id) fromDict:(NSDictionary*)dict;

@end