#include <stdio.h>
#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>

/*
 Comment here
*/

#define TOPRINT(str) (printf(str, 10, 34, str))
#define REDIRECT(fd) (dup2(fd, STDOUT_FILENO))
#define FT_MAIN()int main(void) { const char *str = "#include <stdio.h>%1$c#include <unistd.h>%1$c#include <fcntl.h>%1$c#include <stdlib.h>%1$c%1$c/*%1$c Comment here%1$c*/%1$c%1$c#define TOPRINT(str) (printf(str, 10, 34, str))%1$c#define REDIRECT(fd) (dup2(fd, STDOUT_FILENO))%1$c#define FT_MAIN()int main(void) { const char *str = %2$c%3$s%2$c; int fd = open(%2$cGrace_kid.c%2$c, O_RDWR | O_CREAT, 0644); if (fd == -1) { exit(1); } if (REDIRECT(fd) == -1) { close(fd); exit(1); } TOPRINT(str); return (0); }%1$c%1$cFT_MAIN()%1$c"; int fd = open("Grace_kid.c", O_RDWR | O_CREAT, 0644); if (fd == -1) { exit(1); } if (REDIRECT(fd) == -1) { close(fd); exit(1); } TOPRINT(str); return (0); }

FT_MAIN()
