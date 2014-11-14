//
//  City.h
//  CityGuide
//
//  Created by Alasdair Allan on 16/10/2012.
//  Copyright (c) 2012 Babilim Light Industries. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface City : NSObject

@property (nonatomic, strong) NSString *cityName;
@property (nonatomic, strong) NSString *cityDescription;
@property (nonatomic, strong) UIImage *cityPicture;

@end
