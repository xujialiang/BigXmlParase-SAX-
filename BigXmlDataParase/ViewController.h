//
//  ViewController.h
//  BigXmlDataParase
//
//  Created by Elliott on 13-7-30.
//  Copyright (c) 2013年 xujialiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSXMLParserDelegate>
- (IBAction)btnparase:(id)sender;

@property (strong, nonatomic) IBOutlet UILabel *count;

@property (strong, nonatomic) IBOutlet UILabel *startDate;

@property (strong, nonatomic) IBOutlet UILabel *endDate;

@property (strong, nonatomic) IBOutlet UILabel *costtime;

@end
