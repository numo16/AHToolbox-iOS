#ifndef Macros_h
#define Macros_h

#define ApplicationDelegate                 ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define NotificationCenter                  [NSNotificationCenter defaultCenter]
#define SharedApplication                   [UIApplication sharedApplication]
#define Bundle                              [NSBundle mainBundle]
#define MainScreen                          [UIScreen mainScreen]
#define ShowNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = YES
#define HideNetworkActivityIndicator()      [UIApplication sharedApplication].networkActivityIndicatorVisible = NO
#define NetworkActivityIndicatorVisible(x)  [UIApplication sharedApplication].networkActivityIndicatorVisible = x
#define NavBar                              self.navigationController.navigationBar
#define TabBar                              self.tabBarController.tabBar
#define NavBarHeight                        self.navigationController.navigationBar.bounds.size.height
#define TabBarHeight                        self.tabBarController.tabBar.bounds.size.height
#define ScreenWidth                         [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight                        [[UIScreen mainScreen] bounds].size.height
#define TouchHeightDefault                  44
#define TouchHeightSmall                    32
#define ViewWidth(v)                        v.frame.size.width
#define ViewHeight(v)                       v.frame.size.height
#define ViewX(v)                            v.frame.origin.x
#define ViewY(v)                            v.frame.origin.y
#define SelfViewWidth                       self.view.bounds.size.width
#define SelfViewHeight                      self.view.bounds.size.height
#define RectX(f)                            f.origin.x
#define RectY(f)                            f.origin.y
#define RectWidth(f)                        f.size.width
#define RectHeight(f)                       f.size.height
#define RectSetWidth(f, w)                  CGRectMake(RectX(f), RectY(f), w, RectHeight(f))
#define RectSetHeight(f, h)                 CGRectMake(RectX(f), RectY(f), RectWidth(f), h)
#define RectSetX(f, x)                      CGRectMake(x, RectY(f), RectWidth(f), RectHeight(f))
#define RectSetY(f, y)                      CGRectMake(RectX(f), y, RectWidth(f), RectHeight(f))
#define RectSetSize(f, w, h)                CGRectMake(RectX(f), RectY(f), w, h)
#define RectSetOrigin(f, x, y)              CGRectMake(x, y, RectWidth(f), RectHeight(f))
#define DATE_COMPONENTS                     NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
#define TIME_COMPONENTS                     NSHourCalendarUnit|NSMinuteCalendarUnit|NSSecondCalendarUnit
#define FlushPool(p)                        [p drain]; p = [[NSAutoreleasePool alloc] init]
#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0];

#endif