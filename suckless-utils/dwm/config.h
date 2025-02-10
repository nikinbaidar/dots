/* appearance */
static const unsigned int borderpx = 1;
static const int startwithgaps[] = {1};
static const unsigned int gappx[] = {5};
static const unsigned int snap = 32;
static const int showbar = 1;
static const int topbar = 1;
static const char *fonts[] = {"monospace:size=14"};
static const char dmenufont[] = "monospace:size=14";
static const char col_gray1[] = "#222222";
static const char col_gray2[] = "#bbbbbb";
static const char col_gray3[] = "#c5c8c6";
static const char col_cyan[] = "#232323";
static const char col_dmenu[] = "#4c4f57";
static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {col_gray3, "#0F111B", "#444444"},
    [SchemeSel] = {col_gray3, col_cyan, "#444444"},
};

typedef struct {
  const char *name;
  const void *cmd;
} Sp;

const char *spcmd1[] = {"st",     "-n", "spterm", "-g",
                        "144x41", "-e", "nvim",   "/home/nikin/Dropbox/todo.md",
                        NULL};
const char *spcmd2[] = {"st", "-n", "spfm", "-g", "144x41", "-e", "lf", NULL};
const char *spcmd3[] = {"keepassxc", NULL};
const char *spcmd4[] = {"st", "-n",     "calculator", "-g", "120x31",
                        "-e", "octave", "--slient",   NULL};
static Sp scratchpads[] = {
    /* name          cmd  */
    {"spterm", spcmd1},
    {"spranger", spcmd2},
    {"keepassxc", spcmd3},
    {"calculator", spcmd4},
};

/* tagging */
static const char *tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance   title     tags mask     isfloating   monitor */
    {"Display", NULL, NULL, 0, 1, -1},
    {NULL, "spterm", NULL, SPTAG(0), 1, -1},
    {NULL, "spfm", NULL, SPTAG(1), 1, -1},
    {NULL, "keepassxc", NULL, SPTAG(2), 0, -1},
    {NULL, "calculator", NULL, SPTAG(3), 1, -1},
};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen =
    0; /* 1 will force focus on the fullscreen window */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[]=", tile},
    {"><>", NULL},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggletag, {.ui = 1 << TAG}},                \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
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
static const char *termcmd[] = {"st", "tmux", NULL};
static const char *screenshotcmd[] = {"grabScreenSelection", NULL};
static const char *blightup[] = {"blight", "set", "+10%", NULL};
static const char *blightdown[] = {"blight", "set", "-10%", NULL};
static const char *volup[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@",
                              "+5%", NULL};
static const char *voldown[] = {"pactl", "set-sink-volume", "@DEFAULT_SINK@",
                                "-5%", NULL};
static const char *detach_all[] = {"hlock", "-m", NULL};
static const char *reattach_all[] = {"hlock", "-a", NULL};
static const char *dualmon[] = {"moncon", "-d", NULL};
static const char *externalmon[] = {"moncon", "-e", NULL};
static const char *lapmon[] = {"moncon", "-l", NULL};
static const char *capturestop[] = {"screencast", "--stop", NULL};
static const char *captureprogress[] = {"screencast", "--progress", NULL};
static const char *mute[] = {"screencast", "--mute", NULL};
static const char *unmute[] = {"screencast", "--unmute", NULL};

static const Key keys[] = {
    /* modifier           key              function        argument */
    {MODKEY, XK_p, spawn, {.v = dmenucmd}},
    {MODKEY, XK_Return, spawn, {.v = termcmd}},
    {MODKEY, XK_bracketright, spawn, {.v = lapmon}},
    {MODKEY, XK_c, spawn, {.v = captureprogress}},
    {MODKEY | ShiftMask, XK_c, spawn, {.v = capturestop}},
    {MODKEY | ShiftMask, XK_m, spawn, {.v = mute}},
    {MODKEY | ShiftMask, XK_u, spawn, {.v = unmute}},
    {MODKEY, XK_bracketleft, spawn, {.v = externalmon}},
    {MODKEY | ShiftMask, XK_bracketright, spawn, {.v = dualmon}},
    {MODKEY | ShiftMask, XK_bracketleft, spawn, {.v = dualmon}},
    {MODKEY, XK_s, spawn, {.v = screenshotcmd}},
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
    {MODKEY, XK_a, view, {.ui = 3}},
    {MODKEY, XK_q, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {MODKEY, XK_space, togglefloating, {0}},
    {MODKEY, XK_f, togglefullscr, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY, XK_x, togglescratch, {.ui = 2}},
    {MODKEY, XK_y, togglescratch, {.ui = 0}},
    {MODKEY, XK_z, togglescratch, {.ui = 1}},
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
