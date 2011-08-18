//
//  GetOutOfTheWayViewController.m
//
//  Created by Peter Kananen on 3/15/11.
//

#import "GetOutOfTheWayViewController.h"
#import "UIViewController+LookAndFeel.h"
#import "EditableValueCell.h"

@interface GetOutOfTheWayViewController(private)

-(void)autocompleteSearch:(NSString*)text;
-(void)hideAutocompleteResultsView;

@end

@implementation GetOutOfTheWayViewController
@synthesize language;
@synthesize searchPhrase;
@synthesize searchPhraseField;
@synthesize allLanguages;
@synthesize languagePicker;
@synthesize pickerView;
@synthesize pickerDone;
@synthesize tableView;
@synthesize languageLabel;
@synthesize autocompleteView;
@synthesize autocompleteFrame;
@synthesize autocompleteDelegate;
@synthesize pickerUp, autocompleteUp;

#pragma mark - View lifecycle

- (void)dealloc {
    [searchPhraseField release];
    [language release];
    [allLanguages release];
    [searchPhrase release];
    [languagePicker release];
    [pickerView release];
    [pickerDone release];
    [tableView release];
    [autocompleteView release];
    [autocompleteFrame release];
    [autocompleteDelegate release];
    [languageLabel release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self applyClearBackgroundToTableView:self.tableView];
    self.view.backgroundColor = [UIColor clearColor];
    [self loadAndApplyRootBackgroundImageNamed:@"grad_background.png"];
    self.title = @"awesomer";
    
    AutocompleteDelegate* autoDeleg = [[AutocompleteDelegate alloc] init];
    self.autocompleteDelegate = autoDeleg;
    [autoDeleg release];
    
    self.autocompleteView.delegate = self.autocompleteDelegate;
    self.autocompleteView.dataSource = self.autocompleteDelegate;
    self.autocompleteDelegate.selectionDelegate = self;
    
    // start in upper left, full width, no height
    self.autocompleteView.frame = CGRectMake(0, 0, 320, 0);
    // start at bottom, full width, no height
    self.autocompleteFrame.frame = CGRectMake(0, 480, 320, 0);
    
    self.language = @"0";
    OrderedDictionary* languages = [[OrderedDictionary alloc] init];
    [languages setObject:@"Ruby" forKey:@"0"];
    [languages setObject:@"CoffeeScript" forKey:@"1"];
    [languages setObject:@"JavaScript" forKey:@"2"];
    [languages setObject:@"HTML" forKey:@"3"];
    [languages setObject:@"CSS" forKey:@"4"];
    [languages setObject:@"Objective-C" forKey:@"5"];
    [languages setObject:@"Python" forKey:@"6"];
    self.allLanguages = languages;
    [languages release];
}

- (void)viewDidUnload {
    self.searchPhraseField = nil;
    self.languageLabel = nil;
    self.allLanguages = nil;
    self.languagePicker = nil;
    self.pickerView = nil;
    self.pickerDone = nil;
    self.tableView = nil;
    self.autocompleteView = nil;
    [super viewDidUnload];
}

- (void) viewWillAppear:(BOOL)animated {
    [self.navigationController setNavigationBarHidden:YES animated:animated];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated {
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
    [super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)autocompleteSearch:(NSString*)text {
    NSArray* suggs = [NSArray arrayWithObjects:@"GitHub", @"Heroku", @"Couchly", @"Twitter", @"Shazam", @"Skitch", @"Angry Birds", nil];
    self.autocompleteDelegate.autocompleteSuggestions = suggs;
    [self.autocompleteView reloadData];
}

-(void)showAutocompleteResults {
    self.tableView.scrollEnabled = NO;
    self.autocompleteUp = YES;
    // autocomplete view is up now
    [UIView animateWithDuration:0.6
                     animations:^{
                         // set the frame of the tableView to be smaller so it scrolls up
                         self.tableView.frame = CGRectMake(0, 0, 320, 210);
                         // set the right amount of height (198 - 64 = 134) for the autocomplete frame
                         self.autocompleteFrame.frame = CGRectMake(0, 64, 320, 198);
                         // set the right amount of height for the autocomplete view
                         self.autocompleteView.frame = CGRectMake(0, 10, 320, 188);
                         // add the autocomplete frame to the main view
                         [self.view addSubview:self.autocompleteFrame];
                     }
                     completion:^(BOOL finished){
                         [self.searchPhraseField becomeFirstResponder];
                     }
     ];
}

-(void)hideAutocompleteResultsView {
    [UIView animateWithDuration:0.6
                     animations:^{
                         // collapse autocomplete again
                         self.autocompleteFrame.frame = CGRectMake(0, 480, 320, 0);
                         // set tableView back to full height
                         self.tableView.frame = CGRectMake(0, 0, 320, 324);
                         // remove the autocomplete
                         [self.autocompleteFrame removeFromSuperview];
                     }
                     completion:^(BOOL finished){
                         self.autocompleteUp = NO;
                     }
     ];
}

-(IBAction)hidePickerView {
    
    [UIView beginAnimations:@"pickerHide" context:nil];
    [UIView setAnimationDuration:0.8];
    // set tableView frame to be full height
    self.tableView.frame = CGRectMake(0, 0, 320, 324);
    [UIView setAnimationTransition:UIViewAnimationOptionTransitionCurlDown
                           forView:self.pickerView
                             cache:YES];

    // animate the frame down
    self.pickerView.frame = CGRectMake(0, 460, 320, 260);
    self.pickerUp = NO;
    [UIView commitAnimations];
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1]].selected = NO;
}

- (void)tableView:(UITableView *)tableViewz didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self showAutocompleteResults];        
        [tableViewz cellForRowAtIndexPath:indexPath].selected = NO;
    }
    else if (indexPath.section == 1) {
        [self.searchPhraseField resignFirstResponder];
        [tableViewz cellForRowAtIndexPath:indexPath].selected = YES;
        if (!CGRectEqualToRect(self.pickerView.frame, CGRectMake(0, 176, 320, 260))) {
            
            self.pickerUp = YES;
            [UIView beginAnimations:@"picker" context:nil];
            [UIView setAnimationDuration:0.8];
            // condense the tableView frame (note dimension differences)
            self.tableView.frame = CGRectMake(0, 0, 320, 230);
            
            // set a place for the picker to come from
            self.pickerView.frame = CGRectMake(0, 460, 320, 260);
            // scroll to the right row
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
            // set a place for the picker to go
            self.pickerView.frame = CGRectMake(0, 176, 320, 260);
            [UIView setAnimationTransition:UIViewAnimationOptionTransitionCurlUp
                                   forView:self.pickerView
                                     cache:YES];
            // add the pickerView
            [self.view addSubview:self.pickerView];
            
            [UIView commitAnimations];
        }
        
    }
    else if (indexPath.section == 2) {
        [tableViewz cellForRowAtIndexPath:indexPath].selected = NO;
    }
}

#pragma mark - UITextFieldDelegate methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (!self.pickerUp) {
        if (textField == self.searchPhraseField) {
            [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        }
        return YES;
    }
    return NO;
}

-(BOOL)textFieldShouldClear:(UITextField *)textField {
    self.autocompleteDelegate.autocompleteSuggestions = nil;
    [self.autocompleteView reloadData];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField == self.searchPhraseField) {
        [self.searchPhraseField resignFirstResponder];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.searchPhrase = textField.text;
    [self hideAutocompleteResultsView];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSString* text = [NSString stringWithString:textField.text];
    text = [text stringByReplacingCharactersInRange:range withString:string];
    if ([text length] >= 2) {
        [self autocompleteSearch:text];
    }
    else if ([text length] < 2) {
        self.autocompleteDelegate.autocompleteSuggestions = nil;
        [self.autocompleteView reloadData];
    }
    return YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    NSIndexPath* searchPos = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView scrollToRowAtIndexPath:searchPos atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableViewz cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    if (indexPath.section == 0) {
    
        static NSString *cellTypeIdentifier = @"EditableValueCellTypeIdentifier";
        cell = (EditableValueCell*)[tableViewz dequeueReusableCellWithIdentifier:cellTypeIdentifier];
        if (cell == nil) {
            NSArray *topLevelNibObjects = [[NSBundle mainBundle] loadNibNamed:@"EditableValueCell" owner:self options:nil];
            for (id aNibObject in topLevelNibObjects) {
                if ([aNibObject isKindOfClass:[EditableValueCell class]]) {
                    cell = (EditableValueCell *)aNibObject;
                }
            }
        }
        ((EditableValueCell*)cell).labelForCell.text = @"search";
        ((EditableValueCell*)cell).editableValueForCell.placeholder = @"Project, Product...";
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.searchPhraseField = ((EditableValueCell*)cell).editableValueForCell;
        self.searchPhraseField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.searchPhraseField.delegate = self;
    }
    else if (indexPath.section == 1) {
        static NSString *CellIdentifier = @"Cell";   
        cell = [tableViewz dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        cell.detailTextLabel.text = [self.allLanguages objectForKey:self.language];
        cell.detailTextLabel.font = [UIFont boldSystemFontOfSize:18.0f];
        cell.detailTextLabel.minimumFontSize = 10.0f;
        cell.detailTextLabel.adjustsFontSizeToFitWidth = YES;
        cell.detailTextLabel.textAlignment = UITextAlignmentCenter;
        self.languageLabel = cell.detailTextLabel;
        cell.textLabel.text = @"language";
    }
    else if (indexPath.section == 2) {
        static NSString *CellIdentifier = @"SearchCell";    
        cell = [tableViewz dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        }
        cell.textLabel.text = @"Search";
        cell.backgroundColor = UIColorFromRGB(0xA6C0E9);
        cell.textLabel.font = [UIFont boldSystemFontOfSize:22.0f];
        cell.textLabel.textAlignment = UITextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

#pragma mark -
#pragma mark AutocompleteSelectedDelegate methods

-(void)autocompleteRowSelected:(NSString*)keyword {
    self.searchPhraseField.text = keyword;
    self.searchPhrase = keyword;
}

#pragma mark -
#pragma mark Table view delegate

- (NSIndexPath*)tableView:(UITableView*)tableviewz willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && self.pickerUp) {
        return nil;
    }
    else if (indexPath.section == 1 && self.autocompleteUp) {
        return nil;
    }
    else if (indexPath.section == 2 && (self.autocompleteUp || self.pickerUp)) {
        return nil;
    }
    return indexPath;
}



-(CGFloat)tableView:(UITableView*)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}



#pragma mark -
# pragma UIPickerViewDelegate methods

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSString* key = [self.allLanguages keyAtIndex:row];
    self.language = key;
    self.languageLabel.text = [self.allLanguages objectForKey:key];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.allLanguages objectForKey:[self.allLanguages keyAtIndex:row]];
}

#pragma mark -
# pragma UIPickerViewDataSource methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.allLanguages count];
}

@end
