//
//  FileSelectorList.h
//  BAT100AppWap
//
//  Created by SK on 2020/4/29.
//  Copyright © 2020 BAT100. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <React/RCTComponent.h>
//#import <React/RCTBridge.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileSelectorList : UIViewController

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonnull, copy) void (^callBackFilePath)(NSString *filePath);

@end

NS_ASSUME_NONNULL_END
