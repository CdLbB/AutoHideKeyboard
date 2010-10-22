//
//  CursorWhere.h
//  AutoHideKeyboard
//
//
//  Created by Eric Nitardy on 10/19/10.
//  Copyright 2010.
//

#include <ApplicationServices/ApplicationServices.h>


@interface CursorWhere : NSObject 

+(BOOL) isCursorOverBoundsFrom: (NSPoint) pt1 To: (NSPoint) pt2;

@end