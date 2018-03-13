//
//  FNAlertHelper.m
//  FengNiao
//
//  Created by NetEase on 16/8/31.
//  Copyright © 2016年 浙江翼信科技有限公司. All rights reserved.
//

#import "PSTAlertController.h"

@implementation FNAlertHelper

+ (PSTAlertController *)showAlertWithTitle:(NSString*)title msg:(NSString*)message chooseBlock:(void (^)(NSInteger buttonIdx))block  buttonsStatement:(NSString*)cancelString, ...
{
    if (cancelString) {
        NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:2];
        [argsArray addObject:cancelString];
        id arg;
        va_list argList;
        if(cancelString)
        {
            va_start(argList,cancelString);
            while ((arg = va_arg(argList,id)))
            {
                [argsArray addObject:arg];
            }
            va_end(argList);
        }
        
      return [self showAlertWithTitle:title
                                  msg:message
                          chooseBlock:block
                         buttonsArray:argsArray];
    } else {
        DDLogError(@"alert中的按钮个数不能为空");
    }
    
    return nil;
}

+ (PSTAlertController *)showAlertWithTitle:(NSString*)title
                                       msg:(NSString*)message
                               chooseBlock:(void (^)(NSInteger buttonIdx))block
                              buttonsArray:(NSArray<NSString*> *)buttonArray {
    if (buttonArray.count > 0) {
        PSTAlertController *alert = [PSTAlertController alertWithTitle:title message:message];
        [buttonArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [alert addAction:[PSTAlertAction actionWithTitle:obj handler:^(PSTAlertAction * _Nonnull action) {
                if (block) {
                    block(idx);
                }
            }]];
        }];
        [alert showWithSender:nil controller:nil animated:YES completion:nil];
        return alert;
    } else {
        DDLogError(@"alert中的按钮个数不能为空");
    }
    
    return nil;
}


+ (PSTAlertController *)showAlertWithTitle:(NSString*)title
                                       msg:(NSString*)message
                          textFiledPholder:(NSString *)textFiledPholder
                               chooseBlock:(void (^)(NSInteger buttonIdx, NSString *text))block
          buttonsStatement:(NSString*)cancelString, ... NS_REQUIRES_NIL_TERMINATION {
    if (cancelString) {
        NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:2];
        [argsArray addObject:cancelString];
        id arg;
        va_list argList;
        if(cancelString)
        {
            va_start(argList,cancelString);
            while ((arg = va_arg(argList,id)))
            {
                [argsArray addObject:arg];
            }
            va_end(argList);
        }
        
        PSTAlertController *alert = [PSTAlertController alertWithTitle:title message:message];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = textFiledPholder;
            textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        }];
        
        [argsArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [alert addAction:[PSTAlertAction actionWithTitle:obj handler:^(PSTAlertAction * _Nonnull action) {
                UITextField *textFiled = [[alert textFields] firstObject];
                if (block && textFiled) {
                    block(idx, textFiled.text);
                }
            }]];
        }];
        [alert showWithSender:nil controller:nil animated:YES completion:nil];
        
        return alert;
        
    } else {
        DDLogError(@"alert中的按钮个数不能为空");
    }
    
    return nil;
}

+ (PSTAlertController *)showAlertWithTitle:(NSString*)title
                                       msg:(NSString*)message
                                       text:(NSString*)text
                          textFiledPholder:(NSString *)textFiledPholder
                                  delegate:(id<UITextFieldDelegate>)delegate
                               chooseBlock:(void (^)(NSInteger buttonIdx, NSString *text))block
                          buttonsStatement:(NSString*)cancelString, ... NS_REQUIRES_NIL_TERMINATION {
    if (cancelString) {
        NSMutableArray* argsArray = [[NSMutableArray alloc] initWithCapacity:2];
        [argsArray addObject:cancelString];
        id arg;
        va_list argList;
        if(cancelString)
        {
            va_start(argList,cancelString);
            while ((arg = va_arg(argList,id)))
            {
                [argsArray addObject:arg];
            }
            va_end(argList);
        }
        
        PSTAlertController *alert = [PSTAlertController alertWithTitle:title message:message];
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
            textField.placeholder = textFiledPholder;
            
            
            if(text){
                textField.text = text;
                textField.delegate = delegate;
                textField.clearButtonMode = UITextFieldViewModeWhileEditing;
            }
        }];
        
        [argsArray enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL *stop) {
            [alert addAction:[PSTAlertAction actionWithTitle:obj handler:^(PSTAlertAction * _Nonnull action) {
                UITextField *textFiled = [[alert textFields] firstObject];
                if (block && textFiled) {
                    block(idx, textFiled.text);
                }
            }]];
        }];
        [alert showWithSender:nil controller:nil animated:YES completion:nil];
        
        return alert;
        
    } else {
        DDLogError(@"alert中的按钮个数不能为空");
    }
    
    return nil;
}

@end
