//
//  AutocompleteDelegate.m
//
//  Created by Peter Kananen on 6/21/11.
//

#import "AutocompleteDelegate.h"


@implementation AutocompleteDelegate
@synthesize autocompleteSuggestions;
@synthesize selectionDelegate;

-(void)dealloc {
    [autocompleteSuggestions release];
    [super dealloc];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.autocompleteSuggestions == nil) {
        return 1;
    }
    return [self.autocompleteSuggestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"AutocompleteCell";

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
    if (self.autocompleteSuggestions != nil) {
        cell.textLabel.text = [autocompleteSuggestions objectAtIndex:indexPath.row];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    else if (indexPath.row == 0) {
        cell.textLabel.textColor = [UIColor lightGrayColor];
        cell.textLabel.text = @"Are you looking for...?";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.autocompleteSuggestions == nil) {
        return nil;
    } 
    // length 2, row 1
    else if ([self.autocompleteSuggestions count] >= (indexPath.row + 1)) {
        return indexPath;
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectionDelegate autocompleteRowSelected:[self.autocompleteSuggestions objectAtIndex:indexPath.row]];
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

@end
