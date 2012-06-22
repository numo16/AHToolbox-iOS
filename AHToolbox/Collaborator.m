//
//  Collaborator.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Collaborator.h"
#import "User.h"

@implementation Collaborator

@synthesize user;
@synthesize Role;
@synthesize Url;

+ (id) objectWithDictionary:(NSDictionary*)dictionary
{
  id obj = [[Collaborator alloc] initWithDictionary:dictionary];
  return obj;
}

- (id) initWithDictionary:(NSDictionary*)dictionary
{
  self=[super init];
  if(self)
  {
    
    user = [[User alloc] initWithDictionary:[dictionary objectForKey:@"User"]];
    Role = [dictionary objectForKey:@"Role"];
    Url = [dictionary objectForKey:@"Url"];
  }
  return self;
}


@end