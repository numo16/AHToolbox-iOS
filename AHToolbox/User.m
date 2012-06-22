//
//  User.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "User.h"

@implementation User

@synthesize Id;
@synthesize Name;

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
  id obj = [[User alloc] initWithDictionary:dictionary];
  return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
  self=[super init];
  if(self)
  {
    Id = [dictionary objectForKey:@"Id"];
    Name = [dictionary objectForKey:@"Name"];
  }
  return self;
}


@end
