
#import "RNFileSelector.h"
#import "FileSelectorList.h"

@implementation RNFileSelector

RCT_EXPORT_MODULE()


RCT_EXPORT_METHOD(Show:(nonnull NSDictionary *)props onDone:(RCTResponseSenderBlock)onDone onCancel:(RCTResponseSenderBlock)onCancel) {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        FileSelectorList *vc = [[FileSelectorList alloc]init];
        vc.callBackFilePath = ^(NSString * _Nonnull filePath) {
            onDone(@[filePath]);
        };
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        nav.modalPresentationStyle = UIModalPresentationFullScreen;
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:nav animated:YES completion:nil];
    });
}

@end
  
