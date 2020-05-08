//
//  FileSelectorList.m
//  BAT100AppWap
//
//  Created by SK on 2020/4/29.
//  Copyright © 2020 BAT100. All rights reserved.
//


//       BOOL isDir = NO;
//       [[NSFileManager defaultManager] fileExistsAtPath:[documentPath stringByAppendingPathComponent:file] isDirectory:&isDir];
//       if(isDir){//是文件夹

#import "FileSelectorList.h"

#import "FileModel.h"

#import "FileSelectorCell.h"

@interface FileSelectorList ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>


@property (nonatomic, strong) NSMutableArray *sourceArray; //保存原数据

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UISearchBar *searchBar;
@end

@implementation FileSelectorList

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initData];
    [self createUI];
}

- (void)createUI {
    self.navigationItem.title = @"选择文件";
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    [self.view addSubview:_tableView];
    self.tableView.tableFooterView = [[UIView alloc]init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
    self.searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    self.tableView.tableHeaderView = self.searchBar;
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 30, 30);
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    tap.cancelsTouchesInView = NO;
    [self.tableView addGestureRecognizer:tap];

}

- (void)tap {
    [self.view endEditing:YES];
}
- (void)btnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)initData {
    self.dataArray = [ NSMutableArray new];
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSDirectoryEnumerator *myDirectoryEnumerator = [fileManager enumeratorAtPath:documentPath];  //baseSavePath 为文件夹的路径
    
    NSString *file;
    
    while((file=[myDirectoryEnumerator nextObject])){     //遍历当前目录
        if(
           //            [[file pathExtension] isEqualToString:@"wav"]||
           [[file pathExtension] isEqualToString:@"doc"]
           || [[file pathExtension] isEqualToString:@"apk"]
           || [[file pathExtension] isEqualToString:@"ipa"]
           || [[file pathExtension] isEqualToString:@"xlsx"]
           || [[file pathExtension] isEqualToString:@"xls"]
           || [[file pathExtension] isEqualToString:@"xlsm"]
           || [[file pathExtension] isEqualToString:@"docx"]
           || [[file pathExtension] isEqualToString:@"pdf"]
           || [[file pathExtension] isEqualToString:@"zip"]
           || [[file pathExtension] isEqualToString:@"rar"]
           || [[file pathExtension] isEqualToString:@"txt"]) {
            
            FileModel *model = [[FileModel alloc]init];
            NSLog(@"%@扩展名是%@",file,[file pathExtension]);
            NSString *key = [file componentsSeparatedByString:@"/"].lastObject;
            model.fileName = key;
            model.filePath = [documentPath stringByAppendingPathComponent:file];
            model.fileExtension = [file pathExtension];
            model.fileSize = [self fileSizeAtPath:model.filePath]; //文件大小
            
            NSError *error = nil;
            NSDictionary *fileAttributes = [[NSFileManager defaultManager] attributesOfItemAtPath:model.filePath error:&error];
            if (fileAttributes && !error) {
                //文件创建日期
                NSString *createDate = [fileAttributes objectForKey:NSFileCreationDate];
                NSDateFormatter *format = [[NSDateFormatter alloc] init];
                format.dateFormat = @"yyyy-MM-dd HH:mm";
                NSString *newString = [format stringFromDate:createDate];
                model.date = newString;
            }
            [self.dataArray addObject:model];
        }
    }
    self.sourceArray = [[NSMutableArray alloc]init];
    self.sourceArray = self.dataArray;
}

//单个文件的大小(字节)
- (NSString *)fileSizeAtPath:(NSString *)filePath {
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        long long size = [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        NSString *result;
        if (size > 1000000) {
            result = [NSString stringWithFormat:@"%.2fM",[self roundFloat:size /1024.0 /1024.0]];
        }else {
            result = [NSString stringWithFormat:@"%.2fK",[self roundFloat:size /1024.0]];
        }
        return result;
    }
    return 0;
}
// 四舍五入
- (float)roundFloat:(float)price{
    NSString *temp = [NSString stringWithFormat:@"%.7f",price];
    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:temp];
    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
    decimalNumberHandlerWithRoundingMode:NSRoundBankers scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:YES];
    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FileSelectorCell * cell = [tableView dequeueReusableCellWithIdentifier:@"FileSelectorCell"];
    if (cell == nil){
        cell = [[FileSelectorCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"FileSelectorCell"];
    }

  if (self.dataArray.count > indexPath.row) {
    FileModel *model = self.dataArray[indexPath.row];
      cell.nameLab.text = model.fileName;
      cell.sizeLab.text = model.fileSize;
    NSString *imageName;
    if ([model.fileExtension isEqualToString:@"wav"]) {
      imageName = @"icon_audio";
    }
    else if ([model.fileExtension isEqualToString:@"doc"]||[model.fileExtension isEqualToString:@"docx"]) {
      imageName = @"icon_docx";
    }
    else if ([model.fileExtension isEqualToString:@"pdf"]) {
      imageName = @"icon_pdf";
    }else if ([model.fileExtension isEqualToString:@"zip"] || [model.fileExtension isEqualToString:@"rar"]) {
      imageName = @"icon_zip";
    }else if ([model.fileExtension isEqualToString:@"png"]||[model.fileExtension isEqualToString:@"jpg"]||[model.fileExtension isEqualToString:@"jpeg"]) {
      imageName = @"icon_image";
    }else if ([model.fileExtension isEqualToString:@"xlsx"]||[model.fileExtension isEqualToString:@"xlsm"]||[model.fileExtension isEqualToString:@"xls"]) {
      imageName = @"icon_excel";
    }
    else {
      imageName = @"icon_file";
    }
    cell.imgView.image = [UIImage imageNamed:imageName];
    cell.dateLab.text = model.date;
  }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.dataArray.count > indexPath.row) {
        FileModel *model= self.dataArray[indexPath.row];
        if (self.callBackFilePath) {
            self.callBackFilePath(model.filePath);
        }
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 82.0;
}

#pragma mark ---searchBar  delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        self.dataArray = self.sourceArray;
    }else {
        NSMutableArray *tmpArr = [[NSMutableArray alloc]init];
        for (FileModel *model in self.dataArray) {
            if (@available(iOS 8.0, *)) {
                if ([[model.fileName lowercaseString] containsString:[searchText lowercaseString]]) {
                    [tmpArr addObject:model];
                }
            }
        }
        self.dataArray = tmpArr;
    }
    [self.tableView reloadData];
}

@end
