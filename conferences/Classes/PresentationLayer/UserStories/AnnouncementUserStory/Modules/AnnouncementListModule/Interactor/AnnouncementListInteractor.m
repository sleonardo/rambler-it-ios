// Copyright (c) 2015 RAMBLER&Co
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AnnouncementListInteractor.h"
#import "AnnouncementListInteractorOutput.h"
#import "EventService.h"
#import "EventModelObject.h"
#import "EventPrototypeMapper.h"
#import "EventPlainObject.h"

#import "EXTScope.h"

@implementation AnnouncementListInteractor

#pragma mark - AnnouncementListInteractorInput

- (void)updateEventList {
    @weakify(self)
    [self.eventService updateEventWithPredicate:nil completionBlock:^(id data, NSError *error) {
        @strongify(self);
        NSArray *events = [self.eventService obtainEventWithPredicate:nil];
        
        [self.output didUpdateEventList:events];
    }];
}

- (NSArray *)obtainEventList {
    NSArray *events = [self.eventService obtainEventWithPredicate:nil];
    
    return events;
}

#pragma mark - Private methods

- (NSArray *)getPlainEventsFromManagedObjects:(NSArray *)manajedObjectEvents {
    NSMutableArray *eventPlainObjects = [NSMutableArray array];
    for (EventModelObject *managedObjectEvent in manajedObjectEvents) {
        EventPlainObject *eventPlainObject = [EventPlainObject new];
        
        [self.eventPrototypeMapper fillObject:eventPlainObject withObject:managedObjectEvent];
        
        [eventPlainObjects addObject:eventPlainObject];
    }
    
    return [self sortEventsByDate:eventPlainObjects];
}

- (NSArray *)sortEventsByDate:(NSMutableArray *)events {
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:NSStringFromSelector(@selector(startDate)) ascending:NO];
    events = [[events sortedArrayUsingDescriptors:@[sortDescriptor]] mutableCopy];
    
    return events;
}

@end