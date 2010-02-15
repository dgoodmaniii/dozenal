/* +AMDG */
/*
 * This document was begun on 18 Jan MAXLEN-110, the commemoration
 * of St. Prisca, virgin and martyr; and it is humbly
 * dedicated to her and to the Immaculate Heart of Mary for
 * their prayers, and to the Sacred Heart of Jesus, for His
 * mercy.
 */
/*
 * The main routine for the dozenal measurement conversion
 * program.
 */

#include<stdio.h>
#include<string.h>
#include<stdlib.h>
#include<float.h>
#include "tgmconv.h"
#include "conv.h"

#define MAXLEN 20

int getunit(char *s, char *inp);

int main(int argc, char *argv[])
{
	char inp[MAXLEN] = " ";
	char outp[MAXLEN] = " ";
	char *fromunit;
	char doznum[MAXLINE];
	int places = 4;
	char expnot = 0;
	double value = 0.001928;
	int i = 0;
	char c;

/* I know, bletcherous goto; but I need it to break out of
 * the loop/loop/switch when I hit an argument */
	startopt:
	while (--argc > 0 && (*++argv)[0] == '-') {
		if (isdigit(argv[0][1]) || argv[0][1] == '.')
			break; /* negative numbers are not optional args */
		while (c = *++argv[0])
			switch (c) {
			case 'e':
				expnot = 1;
				break;
			case 'v':
				printf("tgmconv v0.9\n");
				printf("Copyright (C) 2010  Donald P. Goodman III\n");
				printf("License GPLv3+:  GNU GPL version 3 or "
				"later <http://gnu.org/licenses/gpl.html>\n");
				printf("This is free software:  you are free "
				"to chnage and redistribute it.  There is NO "
				"WARRANTY, to the extent permitted by law.\n");
				return 0;
				break;
			case 'h':
				helpfunc();
				return 0;
				break;
			case 'k':
				if (isdigit(*++argv[0])) {
					places = dozprecis(argv[0]);
					goto startopt;
				} else if (*(argv+1) == NULL) {
					fprintf(stderr,"doz:  invalid precision quantity\n");
					exit(1);
				} else if (isdigit(*(argv+1)[0])) {
					places = dozprecis(*(argv+1));
					--argc, ++argv;
					goto startopt;
				} else {
					fprintf(stderr,"doz:  invalid precision quantity\n");
					exit(1);
				}
				break;
			case 'o':
				if (isalpha(*++argv[0]) || isdigit(*argv[0]) ||
				*argv[0] == '_') {
					strncpy(outp,*argv,MAXLEN-1);
					if (strlen(*argv) > (MAXLEN-1))
						outp[MAXLEN-1] = '\0';
					goto startopt;
				} else if (*(argv+1) == NULL) {
					fprintf(stderr,"tgmconv:  no output unit\n");
					exit(1);
				} else if (isalpha(*(argv+1)[0]) ||
				isdigit(*(argv+1)[0]) || *(argv+1)[0] == '_') {
					strncpy(outp,*argv+1,MAXLEN-1);
					if (strlen(*argv+1) > (MAXLEN-1))
						outp[MAXLEN-1] = '\0';
					--argc, ++argv;
					goto startopt;
				} else {
					fprintf(stderr,"tgmconv:  invalid output unit\n");
					exit(1);
				}
				break;
			case 'i':
				if (isalpha(*++argv[0]) || isdigit(*argv[0]) ||
				*argv[0] == '_') {
					strncpy(inp,*argv,MAXLEN-1);
					if (strlen(*argv) > (MAXLEN-1))
						inp[MAXLEN-1] = '\0';
					goto startopt;
				} else if (*(argv+1) == NULL) {
					fprintf(stderr,"tgmconv:  no input unit\n");
					exit(1);
				} else if (isalpha(*(argv+1)[0]) ||
				isdigit(*(argv+1)[0]) || *(argv+1)[0] == '_') {
					strncpy(inp,*argv+1,MAXLEN-1);
					if (strlen(*argv+1) > (MAXLEN-1))
						inp[MAXLEN-1] = '\0';
					--argc, ++argv;
					goto startopt;
				} else {
					fprintf(stderr,"tgmconv:  invalid input unit\n");
					exit(1);
				}
				break;
			default:
				fprintf(stderr,"tgmconv:  illegal option \"%c\"\n",c);
				break;
			}
	}
	if (argc >= 1) {
		if (*inp == ' ')
			getunit(*argv, inp);
		value = doztodec(*argv);
		value = getanswer(outp,inp,value);
		sprintf(doznum,"%.*f",DBL_MAX_10_EXP,value);
		doz(doznum,doznum,places,expnot);
		return 0;
	}
/*	while (getword(doznum,MAXLINE) != EOF);*/
	return 0;
}

int getunit(char *s, char *inp)
{
	int i, n = 0;

	while (isdozdig(*(s++)))
		continue;
	if (*s == '\0') {
		fprintf(stderr,"tgmconv:  no input unit specified;\n"
		"Usage:  tgmconv -i input unit value\n");
		exit(1);
	}
	for (i=0; (inp[i] = s[i]) != '\0'; ++i);
	inp[i] = '\0'; /* FIXME:  add bounds checking */
	*(s-1) = '\0';
	return 0;
}

int helpfunc(void)
{
	printf("tgmconv, v0.9.\n");
	printf("Usage:  tgmconv -i input unit -o output unit quantity\n");
	printf("Acceptable units:\n");
	printf("TGM:\n");
	printf("\tTm");
	printf("\tGf");
	printf("\tMz");
	printf("\tVl");
	printf("\tG\n");
	printf("\tSf");
	printf("\tVm");
	printf("\tDz");
	printf("\tVv");
	printf("\tMv\n");
	printf("\tMg");
	printf("\tTz");
	printf("\tPm");
	printf("\tWg");
	printf("\tPv\n");
	printf("\tVsd");
	printf("\tVsn");
	printf("\tFq");
	printf("\trGf");
	printf("\trVl\n");
	printf("\trG");
	printf("\tRMv");
	printf("\tRMg");
	printf("\tQMz");
	printf("\tKr\n");
	printf("\tPl");
	printf("\tOg");
	printf("\tGo");
	printf("\tQl");
	printf("\tKp\n");
	printf("\tMt");
	printf("\tFm");
	printf("\tFz");
	printf("\tGn");
	printf("\tLk\n");
	printf("\tMb");
	printf("\tPz");
	printf("\tQPz");
	printf("\tLp");
	printf("\tLd\n");
	printf("\tSz");
	printf("\tQLd");
	printf("\tCg");
	printf("\tCk");
	printf("\tCsp\n");
	printf("\tCdu");
	printf("\tTgr");
	printf("\tWsp");
	printf("\tFlo");
	printf("\tVsp\n");
	printf("\tAg");
	printf("\tRQl");
	printf("\tRy");
	printf("\tEdu");
	printf("\tIm\n");
	printf("\tQz");
	printf("\tDp");
	printf("\tEgr");
	printf("\tRFm");
	printf("\tMgr\n");
	printf("\tLq");
	printf("\tKn");
	printf("\tPGf");
	printf("\tLf");
	printf("\tOsp\n");
	printf("\tMlz");
	printf("\tSlz");
	printf("\tVlz");
	printf("\tMlv");
	printf("\tMlm\n");
	printf("\tWlz");
	printf("\tEul");
	printf("\tClz");
	printf("\tOlz\n");
	printf("Metric:\n");
	printf("\ts");
	printf("\tm");
	printf("\tg");
	printf("\tL");
	printf("\tN\n");
	printf("\tkgf");
	printf("\tPa");
	printf("\tJ");
	printf("\tW");
	printf("\tWh\n");
	printf("\tHz");
	printf("\trad");
	printf("\tA");
	printf("\tV");
	printf("\tOhm\n");
	printf("\tMho");
	printf("\tS");
	printf("\tC");
	printf("\tF");
	printf("\tWb\n");
	printf("\tT");
	printf("\tH");
	printf("\tlm");
	printf("\tcd");
	printf("\tK\n");
	printf("\tAt");
	printf("\tmol\n");
	printf("Customary/Imperial:\n");
	printf("\tft");
	printf("\tlb");
	printf("\tgali");
	printf("\tgalc");
	printf("\tlbf\n");
	printf("\tinHg");
	printf("\tbtu");
	printf("\thp");
	printf("\tRPM");
	printf("\tdeg\n");
	printf("For more information, please see the man page, \n");
	printf("or go to http://dozenal.sourceforge.net/ and see \n");
	printf("the documentation.\n");
	return 0;
}