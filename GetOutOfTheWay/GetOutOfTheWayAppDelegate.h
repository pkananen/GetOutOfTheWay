//
//  GetOutOfTheWayAppDelegate.h
//  GetOutOfTheWay
//
//  Created by Peter Kananen on 8/17/11.
//

#import <UIKit/UIKit.h>

@class GetOutOfTheWayViewController;

@interface GetOutOfTheWayAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet GetOutOfTheWayViewController *viewController;

@end
