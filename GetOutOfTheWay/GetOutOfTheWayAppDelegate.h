//
//  GetOutOfTheWayAppDelegate.h
//  GetOutOfTheWay
//
//  Created by Peter Kananen on 8/17/11.
//

#import <UIKit/UIKit.h>

@class GetOutOfTheWayViewController;

@interface GetOutOfTheWayAppDelegate : NSObject <UIApplicationDelegate> {
    
    UITabBarController *tabBarController;
    UIView* backgroundImageView;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) UIView* backgroundImageView;

@end
