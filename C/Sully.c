#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>

static int  execute_and_wait(char *file_name, char * program_name) {
    pid_t pid;
    extern char **environ;
    int exit_status;

    pid = fork();
    if (pid == -1)
        return (-1);
    if (!pid)
    {
        if (execlp("cc", "cc", "-Wall", "-Wextra", "-Werror", "-Wpedantic", file_name, "-o", program_name, NULL) == -1)
        {
            dprintf(STDERR_FILENO, "Error compiling %s%c", program_name, 10);
            exit(1);
        }
        exit(0);
    }
    wait(&exit_status);
    if (WEXITSTATUS(exit_status) != 0)
        return (-1);
    pid = fork();
    if (pid == -1)
        return (-1);
    if (!pid)
    {
        if (execve(program_name, (char *const[]){program_name, NULL}, environ) == -1)
        {
            dprintf(STDERR_FILENO, "Error executing %s%c", program_name, 10);
            exit(1);
        }
        exit(0);
    }
    wait(&exit_status);
    if (WEXITSTATUS(exit_status) != 0)
        return (-1);
    return (0);
}

int main(void) {
    int i = 5;
    int fd = -1;
    char program_name[50];
    char file_name[50];
    const char *str = "#include <unistd.h>%1$c#include <fcntl.h>%1$c#include <stdlib.h>%1$c#include <sys/wait.h>%1$c#include <stdio.h>%1$c#include <string.h>%1$c%1$cstatic int  execute_and_wait(char *file_name, char * program_name) {%1$c    pid_t pid;%1$c    extern char **environ;%1$c    int exit_status;%1$c%1$c    pid = fork();%1$c    if (pid == -1)%1$c        return (-1);%1$c    if (!pid)%1$c    {%1$c        if (execlp(%2$ccc%2$c, %2$ccc%2$c, %2$c-Wall%2$c, %2$c-Wextra%2$c, %2$c-Werror%2$c, %2$c-Wpedantic%2$c, file_name, %2$c-o%2$c, program_name, NULL) == -1)%1$c        {%1$c            dprintf(STDERR_FILENO, %2$cError compiling %3$cs%3$cc%2$c, program_name, 10);%1$c            exit(1);%1$c        }%1$c        exit(0);%1$c    }%1$c    wait(&exit_status);%1$c    if (WEXITSTATUS(exit_status) != 0)%1$c        return (-1);%1$c    pid = fork();%1$c    if (pid == -1)%1$c        return (-1);%1$c    if (!pid)%1$c    {%1$c        if (execve(program_name, (char *const[]){program_name, NULL}, environ) == -1)%1$c        {%1$c            dprintf(STDERR_FILENO, %2$cError executing %3$cs%3$cc%2$c, program_name, 10);%1$c            exit(1);%1$c        }%1$c        exit(0);%1$c    }%1$c    wait(&exit_status);%1$c    if (WEXITSTATUS(exit_status) != 0)%1$c        return (-1);%1$c    return (0);%1$c}%1$c%1$cint main(void) {%1$c    int i = %4$d;%1$c    int fd = -1;%1$c    char program_name[50];%1$c    char file_name[50];%1$c    const char *str = %2$c%5$s%2$c;%1$c%1$c    bzero(program_name, sizeof(program_name));%1$c    bzero(file_name, sizeof(file_name));%1$c    snprintf(file_name, 50, %2$cSully_%3$cd.c%2$c, (i - 1));%1$c    snprintf(program_name, 50, %2$cSully_%3$cd%2$c, (i - 1));%1$c    fd = open(file_name, O_RDWR | O_CREAT | O_TRUNC, 0644);%1$c    if (fd == -1)%1$c        return (1);%1$c    dprintf(fd, str, 10, 34, 37, (i - 1), str);%1$c    close(fd);%1$c    if ((i - 1) != 0 && execute_and_wait(file_name, program_name) == -1)%1$c        return (1);%1$c    return (0);%1$c}%1$c";

    bzero(program_name, sizeof(program_name));
    bzero(file_name, sizeof(file_name));
    snprintf(file_name, 50, "Sully_%d.c", (i - 1));
    snprintf(program_name, 50, "Sully_%d", (i - 1));
    fd = open(file_name, O_RDWR | O_CREAT | O_TRUNC, 0644);
    if (fd == -1)
        return (1);
    dprintf(fd, str, 10, 34, 37, (i - 1), str);
    close(fd);
    if ((i - 1) != 0 && execute_and_wait(file_name, program_name) == -1)
        return (1);
    return (0);
}
