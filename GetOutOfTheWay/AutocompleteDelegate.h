//
//  AutocompleteDelegate.h
//
//  Created by Peter Kananen on 6/21/11.
//

#import <Foundation/Foundation.h>

@protocol AutocompleteSelectedDelegate <NSObject>
-(void)autocompleteRowSelected:(NSString*)keyword;
@end

@interface AutocompleteDelegate : NSObject <UITableViewDelegate, UITableViewDataSource> {
    NSArray* autocompleteSuggestions;
    id<AutocompleteSelectedDelegate> selectionDelegate;
}

@property (nonatomic, retain) NSArray* autocompleteSuggestions;
@property (nonatomic, assign) id<AutocompleteSelectedDelegate> selectionDelegate;

@end
