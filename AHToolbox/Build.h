
#import <Foundation/Foundation.h>
#import "JSONKit.h"


@class Commit;

@interface Build : NSObject

@property(nonatomic,strong) NSString * Status;
@property(nonatomic,strong) NSString * Created;
@property(nonatomic,strong) NSString * Deployed;
@property(nonatomic,strong) Commit * commit;
@property(nonatomic,strong) NSString * Download_url;
@property(nonatomic,strong) NSString * Tests_url;
@property(nonatomic,strong) NSString * Url;

+ (id) objectWithDictionary:(NSDictionary*)dictionary;
- (id) initWithDictionary:(NSDictionary*)dictionary;

@end
