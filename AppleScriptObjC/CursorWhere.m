//
//  CursorWhere.m
//  AutoHideKeyboard
//
//
//  Created by Eric Nitardy on 10/19/10.
//  Copyright 2010.
//

#import "CursorWhere.h"


@implementation CursorWhere

+(BOOL) isCursorOverBoundsFrom: (NSPoint) pt1 To: (NSPoint) pt2 {
	
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	int x = pt1.x;
	int y = pt1.y;
	
	CGPoint ptCG1;
	ptCG1.x = x;
	ptCG1.y = y;
	
	x = pt2.x;
	y = pt2.y;
	
	CGPoint ptCG2;
	ptCG2.x = x;
	ptCG2.y = y;
	
	CGEventRef ourEvent = CGEventCreate(NULL);
    CGPoint ourLoc = CGEventGetLocation(ourEvent);
    
    CFRelease(ourEvent);
	
	if ((ptCG1.x <= ourLoc.x) && (ourLoc.x <= ptCG2.x) && (ptCG1.y <= ourLoc.y) && (ourLoc.y <= ptCG2.y)) 
		return YES;
	else
		return NO;
	
}

@end
