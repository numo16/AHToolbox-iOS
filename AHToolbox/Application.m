//
//  Application.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Application.h"

@implementation Application
@synthesize name, slug, url;

- (NSDictionary *)asDict {
  NSMutableDictionary *dict = [NSMutableDictionary dictionary];
  
  [dict setValue:self.name forKey:@"name"];
  [dict setValue:self.slug forKey:@"slug"];
  [dict setValue:self.url forKey:@"url"];
  
  return dict;
}

+ (id)fromDict:(NSDictionary *)dict {
  Application *a = [Application new];
  
  a.name = [dict valueForKey:@"name"];
  a.slug = [dict valueForKey:@"slug"];
  a.url = [dict valueForKey:@"url"];
  
  return a;
}

@end
