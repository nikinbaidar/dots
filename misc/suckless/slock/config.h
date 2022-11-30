/* user and group to drop privileges to */
static const char *user  = "nikin";
static const char *group = "nikin";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "#182021",   /* after initialization */
	/* [INPUT] =  "#2596be",   /1* during input *1/ */
	[INPUT] =  "#1ca5d6",   /* during input */
	[FAILED] = "#182021",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

/* insert grid pattern with scale 1:1, the size can be changed with logosize */
static const int logosize = 60;
/* grid width and height for right center alignment */
static const int logow = 12;
static const int logoh = 8;

static XRectangle rectangles[9] = {
	/* x    y       w       h */
	{ 0,    3,      1,      3 },
	{ 1,    3,      2,      1 },
	{ 0,    5,      8,      1 },
	{ 3,    0,      1,      5 },
	{ 5,    3,      1,      2 },
	{ 7,    3,      1,      2 },
	{ 8,    3,      4,      1 },
	{ 9,    4,      1,      2 },
	{ 11,   4,      1,      2 },
};

/*Enable blur*/
#define BLUR
/*Set blur radius*/
static const int blurRadius=5;
/*Enable Pixelation*/
//#define PIXELATION
/*Set pixelation radius*/
static const int pixelSize=1;
