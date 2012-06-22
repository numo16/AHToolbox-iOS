//
//  Error.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Error.h"
#import "Exception.h"


@implementation Error

@synthesize Commit_id;
@synthesize Date;
@synthesize Request_path;
@synthesize Message;
@synthesize exception;
@synthesize Url;

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
  id obj = [[Error alloc] initWithDictionary:dictionary];
  return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
  self=[super init];
  if(self)
  {
    Commit_id = [dictionary objectForKey:@"Commit_id"];
    Date = [dictionary objectForKey:@"Date"];
    Request_path = [dictionary objectForKey:@"Request_path"];
    Message = [dictionary objectForKey:@"Message"];
    
    exception = [[Exception alloc] initWithDictionary:[dictionary objectForKey:@"Exception"]];
    Url = [dictionary objectForKey:@"Url"];
  }
  return self;
}


@end