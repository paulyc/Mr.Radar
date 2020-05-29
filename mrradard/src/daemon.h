#ifndef MR_RADAR_DAEMON_H
#define MR_RADAR_DAEMON_H

#ifdef __cplusplus
extern "C" {
#endif

int daemonize(int argc, char **argv, int (*mainloop)(int,char**));

#ifdef __cplusplus
}
#endif

#endif
