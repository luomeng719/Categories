//
//  MPNEmailManager.m
//  MaskPhoneNumber
//
//  Created by luomeng on 15/10/16.
//  Copyright (c) 2015年 ILegendsoft. All rights reserved.
//

#import "MPNEmailManager.h"
#import <MessageUI/MessageUI.h>

@interface MPNEmailManager () <MFMailComposeViewControllerDelegate> {

    MFMailComposeViewController *_picker;
}

@end

@implementation MPNEmailManager

+ (instancetype)defaultManager {
    static MPNEmailManager *_manager = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        _manager = [[MPNEmailManager alloc] init];
    });
    
    return _manager;
}

- (void)openEmailInViewController:(UIViewController *)vc withSubject:(NSString *)subject EmailBody:(NSString *)emailBody {
    if (![MFMailComposeViewController canSendMail]) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error", @"")
                                                       message:NSLocalizedString(@"Please set up email account in order to send email.", @"")
                                                      delegate:nil
                                             cancelButtonTitle:NSLocalizedString(@"OK", @"")
                                             otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    _picker = [[MFMailComposeViewController alloc] init];
    _picker.mailComposeDelegate = self;
    _picker.modalPresentationStyle = UIModalPresentationFormSheet;
    
    [_picker setSubject:subject];
    [_picker setMessageBody:emailBody isHTML:YES];
    [_picker setToRecipients:@[@"here is your support email"]];
    
    [vc presentViewController:_picker animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    //message.hidden = NO;
    // Notifies users about errors associated with the interface
    switch (result) {
        case MFMailComposeResultCancelled:
            //message.text = @"You canceled the email.";
            break;
        case MFMailComposeResultSaved:
            //message.text = @"The email have been saved.";
            break;
        case MFMailComposeResultSent:
            //message.text = @"The email message was queued in your outbox. It is ready to send the next time you connect to email.";
            break;
        case MFMailComposeResultFailed:
            //message.text = @"It is failed to send the email.";
            break;
        default: {
            UIAlertView *alerts = [[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Error",@"")
                                                            message:[error localizedFailureReason]
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"OK",@"")
                                                  otherButtonTitles:nil];
            [alerts show];
            break;
        }
    }
    
    [_picker dismissViewControllerAnimated:YES completion:nil];
}

@end
