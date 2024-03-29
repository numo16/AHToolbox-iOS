//
//  URLParser.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "URLParser.h"

@implementation URLParser
@synthesize variables;

- (id)initWithUrlString:(NSString *)url {
  self = [super init];
  if (self != nil) {
    NSString *string = url;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    [scanner setCharactersToBeSkipped:[NSCharacterSet characterSetWithCharactersInString:@"&?"]];
    NSString *tempString;
    NSMutableArray *vars = [NSMutableArray new];
    [scanner scanUpToString:@"?" intoString:nil];       //ignore the beginning of the string and skip to the vars
    while ([scanner scanUpToString:@"&" intoString:&tempString]) {
      [vars addObject:[tempString copy]];
    }
    self.variables = vars;
  }
  return self;
}

- (id)initWithParamString:(NSString*)params {
  self = [super init];
  if (self != nil) {
    NSString *string = params;
    NSScanner *scanner = [NSScanner scannerWithString:string];
    
    NSString *tempString;
    NSMutableArray *vars = [NSMutableArray new];

    while ([scanner scanUpToString:@"&" intoString:&tempString]) {
      [vars addObject:[tempString copy]];
    }
    self.variables = vars;
  }
  return self;
}

- (NSString *)valueForVariable:(NSString *)varName {
  for (NSString *var in self.variables) {
    if ([var length] > [varName length]+1 && [[var substringWithRange:NSMakeRange(0, [varName length]+1)] isEqualToString:[varName stringByAppendingString:@"="]]) {
      NSString *varValue = [var substringFromIndex:[varName length]+1];
      return varValue;
    }
  }
  return nil;
}


@end
