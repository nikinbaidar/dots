/* user and group to drop privileges to */
static const char *user  = "nikin";
static const char *group = "nobody";

static const char *colorname[NUMCOLS] = {
	[INIT] =   "black",     /* after initialization */
	[INPUT] =  "#005577",   /* during input */
	[FAILED] = "#CC3333",   /* wrong password */
};

/* treat a cleared input like a wrong password (color) */
static const int failonclear = 1;

static const unsigned short int randomize = 0;

static const char *dirpath = "/home/nikin/Pictures/walls";

static char *imgpath = "/home/nikin/Pictures/walls/thumb-1920-1185028.jpg";

/*Enable blur*/
#define BLUR
static const int blurRadius=5;

/*Enable Pixelation*/
#define PIXELATION
static const int pixelSize=5;
