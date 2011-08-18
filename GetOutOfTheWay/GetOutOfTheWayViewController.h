//
//  GetOutOfTheWayViewController.h
//
//  Created by Peter Kananen on 3/15/11.
//

#import <UIKit/UIKit.h>
#import "OrderedDictionary.h"
#import "AutocompleteDelegate.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface GetOutOfTheWayViewController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDelegate, UITableViewDataSource, AutocompleteSelectedDelegate> {
    
    UITextField *searchPhraseField;
    NSString* language;
    NSString* searchPhrase;
    OrderedDictionary* allLanguages;
    UIView* pickerView;
    UIPickerView* metroPicker;
    UIBarButtonItem* pickerDone;
    UITableView* tableView;
    UIView* autocompleteFrame;
    UITableView* autocompleteView;
    UILabel* languageLabel;
    AutocompleteDelegate* autocompleteDelegate;
    BOOL pickerUp;
    BOOL autocompleteUp;
}

@property (nonatomic, retain) UITextField *searchPhraseField;
@property (nonatomic, retain) NSString* searchPhrase;
@property (nonatomic, retain) NSString* language;
@property (nonatomic, retain) OrderedDictionary* allLanguages;
@property (nonatomic, retain) IBOutlet UIPickerView* languagePicker;
@property (nonatomic, retain) IBOutlet UIView* pickerView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem* pickerDone;
@property (nonatomic, retain) IBOutlet UITableView* tableView;
@property (nonatomic, retain) IBOutlet UIView* autocompleteFrame;
@property (nonatomic, retain) IBOutlet UITableView* autocompleteView;
@property (nonatomic, retain) UILabel* languageLabel;
@property (nonatomic, retain) AutocompleteDelegate* autocompleteDelegate;
@property (nonatomic, assign) BOOL pickerUp;
@property (nonatomic, assign) BOOL autocompleteUp;

-(IBAction)hidePickerView;

@end
