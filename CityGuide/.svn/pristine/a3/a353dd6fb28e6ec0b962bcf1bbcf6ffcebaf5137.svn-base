//
//  CityController.m
//  CityGuide
//
//  Created by Alasdair Allan on 16/10/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import "CityController.h"
#import "CGAppDelegate.h" 
#import "City.h"

@interface CityController ()

@end

@implementation CityController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id)initWithIndexPath: (NSIndexPath *)indexPath {
    if ( (self = [super init]) ) {
        index = indexPath;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    CGAppDelegate *delegate = (CGAppDelegate *) [[UIApplication sharedApplication] delegate];
    City *thisCity = [delegate.cities objectAtIndex:index.row];
    self.title = thisCity.cityName;
    
    descriptionView.text = thisCity.cityDescription;
    descriptionView.editable = NO;
 
    pictureView.image = thisCity.cityPicture;
    UIImage *image = thisCity.cityPicture;
    if ( image == nil ) {
        image = [UIImage imageNamed:@"QuestionMark.jpg"];
    }
    pictureView.image = image;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
