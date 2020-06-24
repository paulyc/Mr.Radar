#include "daemon.h"

#include <string.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <errno.h>
#include <stdlib.h>

int daemonize(int argc, char **argv, int (*mainloop)(int,char**)) {
	int res;
	pid_t pid, sid;
	pid = fork();
	if (pid < 0) {
		return pid;
	}
	if (pid > 0) {
		return 0;
	}

	// Now in daemon process
	umask(0);

	sid = setsid();
        if (sid < 0) {
		fprintf(stderr, "daemonize(): setsid() err %d %s\n", errno, strerror(errno));
		exit(sid);
	}
	res = chdir("/");
	if (res < 0) {
		fprintf(stderr, "daemonize(): chdir() err %d %s\n", errno, strerror(errno));
		exit(res);
	}

	close(STDIN_FILENO);
	close(STDOUT_FILENO);
	close(STDERR_FILENO);

	return mainloop(argc, argv);
}
