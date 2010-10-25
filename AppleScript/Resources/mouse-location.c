// mouse-location.c
// A Unix utility that returns the mouse cursor location in desktop coordinates

///////////////////////////////////////////////////////////////////////
// Assuming you have Xcode installed, you can compile the C-code yourself by moving mouse-location.c to a destination folder and in Terminal type: 

//    cd < path to the destination folder>

//    gcc -Wall -o mouse-location mouse-location.c  -framework ApplicationServices

// To use, type: 

//    ./mouse-location

// Mouse cursor location will be returned as an ordered pair:

//       649,  290

///////////////////////////////////////////////////////////////////////

   
#include <ApplicationServices/ApplicationServices.h>
   
      
int
main(int argc, char **argv)
{
    
    CGEventRef ourEvent = CGEventCreate(NULL);
    CGPoint ourLoc = CGEventGetLocation(ourEvent);
    
    CFRelease(ourEvent);
    
    
    printf("%5.0f,%5.0f\n",
               (float)ourLoc.x, (float)ourLoc.y);
   
    exit(0);
}
   
