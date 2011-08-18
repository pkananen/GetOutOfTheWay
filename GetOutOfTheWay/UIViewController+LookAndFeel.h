//
//  UIViewController+LookAndFeel.h
//
//  Created by Peter Kananen on 6/5/11.
//

#import <Foundation/Foundation.h>


@interface UIViewController(LookAndFeel)
    
- (void)loadAndApplyRootBackgroundImageNamed:(NSString*)imageFileName;

- (void)applyGradientBackgroundToView:(UIView*)view;

- (void)applyClearBackgroundToTableView:(UITableView*)tableView;

//- (HeaderView*)prepareHeaderView;

@end
