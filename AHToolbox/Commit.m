//
//  Commit.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Commit.h"

@implementation Commit

@synthesize Id;
@synthesize Message;

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
  id obj = [[Commit alloc] initWithDictionary:dictionary];
  return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
  self=[super init];
  if(self)
  {
    Id = [dictionary objectForKey:@"Id"];
    Message = [dictionary objectForKey:@"Message"];
  }
  return self;
}

@end