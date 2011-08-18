//
//  EditableValueCell.m
//
//  Created by Peter Kananen on 7/27/09
//

#import "EditableValueCell.h"


@implementation EditableValueCell

@synthesize labelForCell;
@synthesize editableValueForCell;


- (void)dealloc {
	[labelForCell release];
	[editableValueForCell release];
    [super dealloc];
}


@end
