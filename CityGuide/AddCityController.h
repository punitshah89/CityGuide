//
//  AddCityController.h
//  CityGuide
//
//  Created by Alasdair Allan on 16/10/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import <UIKit/UIKit.h>
@class City;

@interface AddCityController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    IBOutlet UITableView *tableView;
    IBOutlet UITableViewCell *nameCell;
    IBOutlet UITableViewCell *pictureCell;
    IBOutlet UITableViewCell *descriptionCell;
    
    UIImage *cityPicture;
    UIImagePickerController *pickerController;
}

- (IBAction)addPicture:(id)sender;
- (void) addCityToDatabase:(City *)newCity;

@end
