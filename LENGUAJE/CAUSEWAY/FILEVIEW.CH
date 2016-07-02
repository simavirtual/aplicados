// These are the values that can be returned by the codeblock supplied
// to CWFileView().  Note that the values are additive, so you can
// generate more than one behavior at a time.  For example, to go to
// the first line and then scroll down and right, you would return
// FV_TOP + FV_DOWN + FV_RIGHT.  To go to the bottom of the file and
// the first column, you would return FV_BOTTOM + FV_LEFTEDGE.
//
// Note that it's silly to combine contradictory behaviors like
// FV_TOP + FV_BOTTOM (although it works).

#define FV_TOP          1       // Go to first row
#define FV_BOTTOM       2       // Go to last row
#define FV_LEFTEDGE     4       // Go to first column
#define FV_RIGHTEDGE    8       // Go to last column

#define FV_UP           16      // Scroll up one row
#define FV_DOWN         32      // Scroll down one row
#define FV_LEFT         64      // Scroll left one column
#define FV_RIGHT        128     // Scroll right one column

#define FV_PGUP         256     // Scroll up one page
#define FV_PGDN         512     // Scroll down one page
#define FV_PGLEFT       1024    // Scroll left one page
#define FV_PGRIGHT      2048    // Scroll right one page

#define FV_QUIT         65536   // Terminate file view