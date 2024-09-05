#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <stdio.h>

static int dup_and_close(int fd) {
    if (dup2(fd, STDOUT_FILENO))
    {
        close(fd);
        return (-1);
    }
    return (0);
}

int main(void) {
    int i = 5;
    int fd = -1;
    int exit_status;
    int backup;
    pid_t pid;
    const char *str = "";
    char *arr[] = {"cc", "-Wall", "-Wextra", "-Werror", "Sully_4.c", "-o", "Sully_4"};

    fd = open("Sully_4.c", O_RDWR | O_CREAT, 0644);
    if (fd == -1)
        return (1);
    backup = dup(STDOUT_FILENO);
    dup_and_close(fd);
    printf(str, 10, 34, (i - 1), (i - 2), str);
    if (dup_and_close(fd) == -1)
    {
        close(backup);
        return (1);
    }
    if ((i - 1) == 0) {
        close(fd);
        return (1);
    }
    if (dup_and_close(backup) == -1)
        return (1);
    pid = fork();
    if (pid == -1)
        return (1);
    if (pid == 0) {
        if (execve("cc", arr, NULL) == -1)
            exit(1);
        exit(0);
    }
    else {
        waitpid(pid, &exit_status, 0);
        if (WEXITSTATUS(exit_status) != 0)
            return (1);
    }
    return (0);
}
