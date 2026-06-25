/* appearance */
static const unsigned int borderpx = 1;
static const int startwithgaps[] = {1};
static const unsigned int gappx[] = {5};
static const unsigned int snap = 32;
static const int showbar = 1;
static const int topbar = 1;
static const char *fonts[] = {"Adobe Helvetica:size=14"};
static const char dmenufont[] = "Adobe Helvetica:size=14";
static const char col_gray1[] = "#222222";
static const char col_gray3[] = "#B5A8D5";
static const char col_cyan[] = "#373b41";
static const char col_dmenu[] = "#4c4f57";
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, "#0F111B", "#27293a"},
    [SchemeSel] = {col_gray3, "#1a1b26", "#27293a"},
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;

const char *spcmd0[] = {"keepassxc", NULL};
const char *spcmd1[] = {"st", "-c", "st-floating", "-T", "Notes Server", "-n", "spnotes", "-e", "previewnotes", NULL};

static Sp scratchpads[] = {
    /* name          cmd  */
    {"keepassxc", spcmd0},
    {"spnotes", spcmd1},
    {"spterm", NULL},
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

                                                                                                         
static const Rule rules[] = {                                                                                                         
    /* xprop(1):                                                                                                         
     *  WM_CLASS(STRING) = instance, class                                                                                                         
     *  WM_NAME(STRING) = title                                                                                                         
     *                                                                                                          
     *
     * WARN: This dwm configures the floatx variable differently from what the
     * original author of the patch intended. It calculates the 'x' position
     * from the right edge of the screen and subtracts the floatx value.
     *
     * TODO: Optimize later for multimonitor setups.                                                                                                         
     *
 	 * { class,
     *   instance,
     *   title, 
     *   tags mask,
     *   iscentered,
     *   isfloating,
     *   monitor,
     *   float x,y,w,h,
     *   floatborderpx ,
     *
     *                                                                  C  F       x,  y,  r,  b   */
    {"Rustdesk",                  NULL,         NULL,     1 << 5,   -1, 0, 0,     -1, },
    {NULL,                        "keepassxc",  NULL,     SPTAG(0), -1, 0, 0,     -1, },
    {"st-floating",               "spnotes",    NULL,     SPTAG(1), -1, 1, 1,     -1, },
    {"st-floating",               "spterm",     NULL,     SPTAG(2), -1, 1, 1,     -1, },
    {"Lehte",                     NULL,         NULL,     0,        -1, 1, 1,     -1, },
    {"Interactive User Input",    NULL,         NULL,     0,        -1, 1, 1,     -1, },
    {"satty",                     NULL,         NULL,     0,        -1, 1, 1,     -1, },
    {"Display",                   NULL,         NULL,     0,        -1, 0, 1,    425,  50,  1, -1 },
    {"Display",                   NULL,         "Timer",  0,        -1, 0, 1,    175,  75,  1,  1 },
    {"Display",                   "REC",         NULL,    0,          -1, 0, 1,  250,  75,  1,  1 },
};

/* layout(s) */
static const float mfact = 0.50; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints = 0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[ ] =", tile},
    {"><>", NULL},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, comboview, {.ui = 1 << TAG}},                                  \
      {MODKEY | ControlMask, KEY, toggletag, {.ui = 1 << TAG}},                \
      {MODKEY | ShiftMask, KEY, combotag, {.ui = 1 << TAG}},                   \
      {MODKEY | ControlMask | ShiftMask, KEY, toggleview, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] = "0";
static const char *dmenucmd[] = {
    "dmenu_run", "-m",      dmenumon, "-fn",    dmenufont, "-nb",     col_gray1,
    "-nf",       col_gray3, "-sb",    col_cyan, "-sf",     col_gray3, NULL};
static const char *termcmd[] = {"st", "lterm", NULL};
static const char *elapsedcmd[] = {"record_time.sh", NULL};
static const char *screenshotcmd[] = {"grabScreenSelection", NULL};
static const char *blightup[] = {"blight", "set", "+10%", NULL};
static const char *blightdown[] = {"blight", "set", "-5%", NULL};
static const char *volup[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@",
                              "+5%", NULL};
static const char *voldown[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@",
                                "-5%", NULL};
static const char *detach_all[] = {"hlock", "-m", NULL};
static const char *reattach_all[] = {"hlock", "-a", NULL};
static const char *dualmon[] = {"moncon", "--dual", NULL};
static const char *externalmon[] = {"moncon", "-i", NULL};
static const char *lapmon[] = {"moncon", "--laptop", NULL};
static const char *capturestop[] = {"sc", "-s", NULL};
static const char *capturepause[] = {"sc", "-p", NULL};

static const Key keys[] = {
    /* modifier           key              function        argument */
    {MODKEY, XK_p, spawn, {.v = dmenucmd}},
    {MODKEY, XK_Return, spawn, {.v = termcmd}},
    {MODKEY | ShiftMask, XK_bracketright, spawn, {.v = lapmon}},
    {MODKEY, XK_F2, spawn, {.v = capturepause}},
    {MODKEY, XK_F1, spawn, {.v = capturestop}},
    {MODKEY, XK_bracketleft, spawn, {.v = externalmon}},
    {MODKEY, XK_bracketright, spawn, {.v = dualmon}},
    {MODKEY | ShiftMask, XK_bracketleft, spawn, {.v = dualmon}},
    {MODKEY, XK_s, spawn, {.v = screenshotcmd}},
    {MODKEY, XK_e, spawn, {.v = elapsedcmd}},
    {MODKEY, XK_Up, spawn, {.v = blightup}},
    {MODKEY, XK_Down, spawn, {.v = blightdown}},
    {MODKEY | ShiftMask, XK_k, spawn, {.v = volup}},
    {MODKEY | ShiftMask, XK_j, spawn, {.v = voldown}},
    {MODKEY, XK_semicolon, spawn, {.v = detach_all}},
    {MODKEY | ShiftMask, XK_semicolon, spawn, {.v = reattach_all}},
    {MODKEY, XK_m, zoom, {0}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_r, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY, XK_q, killclient, {0}},
    // {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_t, togglefloating, {0}},
    {MODKEY, XK_f, togglefullscr, {0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY, XK_x, togglescratch, {.ui = 0}},
    {MODKEY, XK_n, togglescratch, {.ui = 1}},
    {MODKEY, XK_z, togglescratch, {.ui = 2}},
    {MODKEY, XK_minus, setgaps, {.i = -5}},
    {MODKEY, XK_equal, setgaps, {.i = +5}},
    {MODKEY | ShiftMask, XK_minus, setgaps, {.i = GAP_RESET}},
    {MODKEY | ShiftMask, XK_equal, setgaps, {.i = GAP_TOGGLE}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},
};

/* button definitions */
static Button buttons[] = {
    /* click          event mask    button          function        argument */
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
};
