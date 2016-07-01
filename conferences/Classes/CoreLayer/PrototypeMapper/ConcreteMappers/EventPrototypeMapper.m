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

#import "EventPrototypeMapper.h"

#import "EventManagedObject.h"
#import "EventPlainObject.h"

#import "UIColor+Hex.h"

@implementation EventPrototypeMapper

// TODO: добавить маппинг лекций после того как будет создан класс PlainLecture, так же PlainRegistratinQuestions
- (void)fillObject:(EventPlainObject *)filledObject withObject:(EventManagedObject *)object {
    filledObject.eventDescription = object.eventDescription;
    filledObject.liveStreamLink = object.liveStreamLink;
    filledObject.name = object.name;
    filledObject.objectId = object.objectId;
    filledObject.startDate = object.startDate;
    filledObject.endDate = object.endDate;
    filledObject.timePadID = object.timePadID;
    filledObject.twitterLink = object.twitterLink;
    filledObject.tags = object.tags;
    // починить категорию
    filledObject.backgroundColor = [UIColor colorFromHexString:object.backgroundColor];
    filledObject.imageUrl = [NSURL URLWithString:object.imageUrl];
}



@end
