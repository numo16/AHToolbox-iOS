//
//  Exception.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Exception.h"

@implementation Exception

@synthesize Stack_trace;
@synthesize Message;
@synthesize Type;
@synthesize Inner_exception;

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
  id obj = [[Exception alloc] initWithDictionary:dictionary];
  return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
  self=[super init];
  if(self)
  {
    Stack_trace = [dictionary objectForKey:@"Stack_trace"];
    Message = [dictionary objectForKey:@"Message"];
    Type = [dictionary objectForKey:@"Type"];
    Inner_exception = [dictionary objectForKey:@"Inner_exception"];
  }
  return self;
}


@end