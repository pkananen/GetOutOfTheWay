//
//  EditableValueCell.h
//
//  Created by Peter Kananen on 7/27/09.
//

#import <UIKit/UIKit.h>


@interface EditableValueCell : UITableViewCell {
	
	UILabel *labelForCell;
	UITextField *editableValueForCell;

}

@property (nonatomic, retain) IBOutlet UILabel *labelForCell;
@property (nonatomic, retain) IBOutlet UITextField *editableValueForCell;

@end
