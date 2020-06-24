
#include <stdio.h>
#include <string.h>
#include <rsl.h>

void dump_radar_header(FILE *output, const Radar *const r) {
	char radar_type[sizeof(r->h.radar_type)];
	strncpy(radar_type, r->h.radar_type, sizeof(radar_type));
	fprintf(output, "Radar [%p]:\nType: %s\nTimestamp: %02d/%02d/%d [M/D/Y] %d:%d:%f\n\n",
		r, radar_type, r->h.month, r->h.day, r->h.year, r->h.hour, r->h.minute, r->h.sec);
}

int usage(int argc, char *argv[]) {
	fprintf(stderr, "%s <radar binary>\n", argv[0]);
	return 1;
}

int main(int argc, char *argv[]) {
	if (argc < 2) {
		return usage(argc, argv);
	}

	Radar *rad = RSL_anyformat_to_radar(argv[1]);
	if (rad == NULL) {
		fprintf(stderr, "Not any matching format\n");
		return 2;
	} else {
		printf("It's something\n");
		dump_radar_header(stdout, rad);
		return 0;
	}
}
