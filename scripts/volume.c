#!/usr/bin/tcc -run
#include <stdio.h>

#define MAX_VOL 150
#define TICKS   7

int main()
{
	int vol;
	scanf(" %d", &vol);

	if (!vol) {
		printf("‹\\›");
		return 0;
	}

	for (int i = 0; i < TICKS; i++)
		/* I divide by MAX_VOL + 1 so the edge case vol = MAX_VOL prints properly  */
		printf("%s", (i == TICKS * vol / (MAX_VOL + 1)) ? "‹!›" : "·");

	return 0;
}
