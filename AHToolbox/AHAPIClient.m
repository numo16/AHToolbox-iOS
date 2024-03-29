//
//  AHAPIClient.m
//  AHToolbox
//
//  Created by Tyler Koske on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AHAPIClient.h"
#import "AFHTTPRequestOperation.h"
#import "AFJSONRequestOperation.h"
#import "URLParser.h"
#import "AFOAuth2Client.h"
#import "Application.h"

@implementation AHAPIClient
@synthesize code, token, delegate;

+ (AHAPIClient *)sharedClient {
  static AHAPIClient* _sharedClient = nil;
  static dispatch_once_t onceToken;
  
  dispatch_once(&onceToken, ^{
    _sharedClient = [[AHAPIClient alloc] initWithBaseURL:[NSURL URLWithString:[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding]]];
  });
  
  return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url {
  self = [super initWithBaseURL:url];
  
  if(!self)
    return nil;
  
  NSLog(@"Intializing APIClient");
  
  return self;
}

- (void)startAuthorize {
  NSLog(@"Starting authorization");
  
//  if([UserDefaults objectForKey:@"oauth_token"] == nil) {
  
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/user/authorizations/new?client_id=%@&redirect_uri=%@", [NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], [NSString stringWithCString:kAH_CLIENT_ID encoding:NSUTF8StringEncoding], [NSString stringWithCString:kAH_REDIRECT encoding:NSUTF8StringEncoding]]];
    
    BOOL result = [[UIApplication sharedApplication] openURL:url];
    if (!result) {
      NSLog(@"*** %s: cannot open url \"%@\"", __PRETTY_FUNCTION__, url);
    }
//  } else {
//    token = [UserDefaults stringForKey:@"oauth_token"];
//    
//    [self setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"BEARER %@", token]];
//    
//    [self setDefaultHeader:@"Accept" value:@"application/json"];
//    [self setDefaultHeader:@"Content-type" value:@"application/json"];
//    
//    NSLog(@"Token exists, %@, setting auth value and moving on", token);
//    NSLog(@"Header: %@ & %@", [self defaultValueForHeader:@"Authorization"], [self defaultValueForHeader:@"Accept"]);
//  }
}

- (BOOL)handleOpenURL:(NSURL *)url {
  URLParser *parser = [[URLParser alloc] initWithUrlString:[url absoluteString]];
  code = [parser valueForVariable:@"code"];
  
  NSLog(@"Returned code: %@", code);
  
  NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:[NSString stringWithCString:kAH_CLIENT_ID encoding:NSUTF8StringEncoding], @"client_id", [NSString stringWithCString:kAH_SECRET_KEY encoding:NSUTF8StringEncoding], @"client_secret", code, @"code", nil];
  
  AHAPIClient *c = [AHAPIClient sharedClient];
  
  [c postPath:@"/tokens" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    NSLog(@"Reponse: %@", operation.responseString);
    
    URLParser *parser = [[URLParser alloc] initWithParamString:operation.responseString];
    
    [c setDefaultHeader:@"Authorization" value:[NSString stringWithFormat:@"BEARER %@", [parser valueForVariable:@"access_token"]]];
    
    [c setDefaultHeader:@"Accept" value:@"application/json"];
    
//    [UserDefaults setValue:[parser valueForVariable:@"access_token"] forKey:@"oauth_token"];

    c.token = [parser valueForVariable:@"access_token"];
    
    [c setDefaultHeader:@"Content-type" value:@"application/json"];
    
    NSLog(@"Header: %@ & %@", [self defaultValueForHeader:@"Authorization"], [self defaultValueForHeader:@"Accept"]);
  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    NSLog(@"Error: %@", error);
    [NotificationCenter postNotificationName:@"AHAuthenticationFail" object:self];
  }];
  
  return YES;
}

- (void)retrieveApplications {
  AHAPIClient *c = [AHAPIClient sharedClient];
  NSMutableArray *array = [[NSMutableArray alloc] init];
  
  NSString *t = [UserDefaults stringForKey:@"oauth_token"];
  
  NSString *urlString = [NSString stringWithFormat:@"%@/applications",[NSString stringWithCString:kAH_BASE_URL encoding:NSUTF8StringEncoding], t];
  
  NSLog(@"Request URL: %@", urlString);
  
  NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
  [request setValue:@"application/json" forHTTPHeaderField:@"Content-type"];
  [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
  [request setValue:[NSString stringWithFormat:@"BEARER %@", t] forHTTPHeaderField:@"Authorization"];
  
  AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
    
    NSLog(@"Response: %@", JSON);
    
    for(NSDictionary *dict in JSON) {
      [array addObject:[Application fromDict:dict]];
    }
    
    NSLog(@"Number of apps: %i", [array count]);
    
    if([c.delegate respondsToSelector:@selector(didReceiveResponseWithResults:)]){
      [c.delegate didReceiveResponseWithResults:array];
    }
    
  } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
    [MKInfoPanel showPanelInWindow:[ApplicationDelegate window] type:MKInfoPanelTypeError title:@"Application Retrieval Error" subtitle:@"Unable to retrieve applications"];
    NSLog(@"Error: %@", error);
  }];
  
  [operation start];
}

@end
