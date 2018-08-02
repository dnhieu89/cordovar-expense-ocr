/********* ExpenseOCR.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>

@interface ExpenseOCR : CDVPlugin {
  // Member variables go here.
}

- (void)coolMethod:(CDVInvokedUrlCommand*)command;
@end

@implementation ExpenseOCR

- (void)openCameraOCR:(CDVInvokedUrlCommand*)command
{
	[self openCamera];
    CDVPluginResult* pluginResult = nil;
    NSString* echo = [command.arguments objectAtIndex:0];

    if (echo != nil && [echo length] > 0) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

// Implement
- (void)openCamera{
    UIImagePickerController *standardPicker = [[UIImagePickerController alloc] init];
    standardPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    standardPicker.allowsEditing = NO;
    standardPicker.delegate = self;
    [self.viewController presentViewController:standardPicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    OCRViewController *vc = [[OCRViewController alloc] initWithNibName:@"OCRViewController" bundle:nil];
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    vc.image = image;
    vc.delegate = self;
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
    
    [picker dismissViewControllerAnimated:NO
                               completion:^{
                                   [self.viewController presentViewController:navi animated:YES completion:^{
                                       
                                   }];
                               }];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)completeWithImage:(UIImage *)img dictionary:(NSDictionary *)dic{
    
}

@end
