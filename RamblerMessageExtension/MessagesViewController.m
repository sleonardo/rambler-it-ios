//
//  MessagesViewController.m
//  RamblerMessageExtension
//
//  Created by Trishina Ekaterina on 13/09/16.
//  Copyright © 2016 Rambler. All rights reserved.
//

#import "MessagesViewController.h"

#import "EventListTableViewController.h"

#import "EventListModuleAssembly.h"
#import "MessageExtensionAssembly.h"
#import "PonsomizerAssembly.h"

#import "ServiceComponentsAssembly.h"

#import <MagicalRecord/MagicalRecord.h>

static NSString * const kRCFAppGroupIdentifier = @"group.ru.ramblerco.rambler.it";

@interface MessagesViewController ()

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation MessagesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self activateTyphoon];
    NSURL *directory = [[NSFileManager defaultManager] containerURLForSecurityApplicationGroupIdentifier:kRCFAppGroupIdentifier];
    NSURL *storeURL = [directory  URLByAppendingPathComponent:@"Conferences.sqlite"];
    [MagicalRecord setupCoreDataStackWithAutoMigratingSqliteStoreAtURL:storeURL];
   // [self.childViewController.output setupView];
   // [self setupChildView];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];

    //[self.containerView layoutIfNeeded];

}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.childViewController.view setNeedsUpdateConstraints];
    [self.childViewController.view updateConstraintsIfNeeded];

    [self.childViewController.view setNeedsLayout];
    [self.childViewController.view layoutIfNeeded];


}

- (void)activateTyphoon {
    TyphoonComponentFactory *factory = [TyphoonBlockComponentFactory factoryWithAssemblies:@[[MessageExtensionAssembly assembly], [EventListModuleAssembly assembly], [PonsomizerAssembly assembly], [ServiceComponentsAssembly assembly]]];
    [factory makeDefault];
    [factory inject:self];
}

- (void)setupChildView {
    [self addChildViewController:self.childViewController];
    self.childViewController.view.frame = self.containerView.bounds;
    [self.containerView addSubview:self.childViewController.view];
    [self.childViewController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Conversation Handling

-(void)didBecomeActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the inactive to active state.
    // This will happen when the extension is about to present UI.
    
    // Use this method to configure the extension and restore previously stored state.
}

-(void)willResignActiveWithConversation:(MSConversation *)conversation {
    // Called when the extension is about to move from the active to inactive state.
    // This will happen when the user dissmises the extension, changes to a different
    // conversation or quits Messages.
    
    // Use this method to release shared resources, save user data, invalidate timers,
    // and store enough state information to restore your extension to its current state
    // in case it is terminated later.
}

-(void)didReceiveMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when a message arrives that was generated by another instance of this
    // extension on a remote device.
    
    // Use this method to trigger UI updates in response to the message.
}

-(void)didStartSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user taps the send button.
}

-(void)didCancelSendingMessage:(MSMessage *)message conversation:(MSConversation *)conversation {
    // Called when the user deletes the message without sending it.
    
    // Use this to clean up state related to the deleted message.
}

-(void)willTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called before the extension transitions to a new presentation style.
    
    // Use this method to prepare for the change in presentation style.
    self.containerView.frame = [[UIScreen mainScreen] bounds];
}

-(void)didTransitionToPresentationStyle:(MSMessagesAppPresentationStyle)presentationStyle {
    // Called after the extension transitions to a new presentation style.
    
    // Use this method to finalize any behaviors associated with the change in presentation style.
}

@end