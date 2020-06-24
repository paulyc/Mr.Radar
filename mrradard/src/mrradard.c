#include "daemon.h"

#include <time.h>
#include <errno.h>
#include <stdio.h>

int mainloop(int argc, char **argv) {
    int res;
    struct timespec remaintime, sleeptime = {
        .tv_sec = 60,
        .tv_nsec = 0,
    };
	for (;;) {
        
        res = nanosleep(&sleeptime, &remaintime);
        if (res < 0) {
            if (errno == EINTR) {
            }
		
       }
	}
	return 0;
}

typedef struct config {
    int daemonize;
} config_t;

static config_t cfg = {
    .daemonize = 0,
};

int main(int argc, char **argv) {
    if (cfg.daemonize) {
        return daemonize(argc, argv, mainloop);
    } else {
        return mainloop(argc, argv);
    }
}
