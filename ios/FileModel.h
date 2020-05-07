//
//  FileModel.h
//  BAT100AppWap
//
//  Created by SK on 2020/4/30.
//  Copyright © 2020 BAT100. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FileModel : NSObject

@property (nonatomic, copy) NSString *fileName;
@property (nonatomic, copy) NSString *filePath;
///文件创建日期
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *fileExtension;
///文件大小
@property (nonatomic, copy) NSString  *fileSize;



@end

NS_ASSUME_NONNULL_END
