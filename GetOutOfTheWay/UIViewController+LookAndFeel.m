//
//  UIViewController+LookAndFeel.m
//
//  Created by Peter Kananen on 6/5/11.
//

#import "UIViewController+LookAndFeel.h"

@implementation UIViewController(LookAndFeel)

- (void)loadAndApplyRootBackgroundImageNamed:(NSString*)imageFileName {
    UIView *backgroundImageView = [[UIApplication sharedApplication].delegate backgroundImageView];
    backgroundImageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:imageFileName]];
}

- (void)applyGradientBackgroundToView:(UIView*)view {
    UIImage *backgroundImage = [UIImage imageNamed:@"grad_background.png"];
    UIColor *backgroundColor = [[UIColor alloc] initWithPatternImage:backgroundImage];
    view.backgroundColor = backgroundColor; 
    [backgroundColor release];
}

- (void)applyClearBackgroundToTableView:(UITableView*)tableView {
    tableView.backgroundColor = [UIColor clearColor];
}

@end