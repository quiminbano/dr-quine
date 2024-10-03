#include <unistd.h>
#include <fcntl.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <stdio.h>
#include <string.h>
#include <errno.h>
#ifdef __linux__
# include <linux/limits.h>
#elif defined(__APPLE__)
# include <libproc.h>
#endif

static int  execute_and_wait(char *file_name, char *program_name)
{
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

#ifdef __linux__
static int  check_executable_name(void)
{
    char path[PATH_MAX];
    char *name;

    bzero(path, sizeof(path));
    if (readlink("/proc/self/exe", path, PATH_MAX) == -1)
        return (0);
    name = strrchr(path, '/');
    if (!name)
        return (0);
    if (strcmp(name + 1, "Sully"))
        return (0);
    return (1);
}
#elif defined(__APPLE__)
static int  check_executable_name(void)
{
    pid_t process_id;
    char path[PROC_PIDPATHINFO_MAXSIZE];
    char *name;

    process_id = getpid();
    bzero(path, sizeof(path));
    if (proc_pidpath(process_id, path, PROC_PIDPATHINFO_MAXSIZE) <= 0)
        return (0);
    name = strrchr(path, '/');
    if (!name)
        return (0);
    if (strcmp(name + 1, "Sully"))
        return (0);
    return (1);
}
#endif

int main(void)
{
    int i = 5;
    int dprintf_ret = 0;
    int to_replace;
    int fd = -1;
    char program_name[50];
    char file_name[50];
    const char *str = "#include <unistd.h>%1$c#include <fcntl.h>%1$c#include <stdlib.h>%1$c#include <sys/wait.h>%1$c#include <stdio.h>%1$c#include <string.h>%1$c#include <errno.h>%1$c#ifdef __linux__%1$c# include <linux/limits.h>%1$c#elif defined(__APPLE__)%1$c# include <libproc.h>%1$c#endif%1$c%1$cstatic int  execute_and_wait(char *file_name, char *program_name)%1$c{%1$c    pid_t pid;%1$c    extern char **environ;%1$c    int exit_status;%1$c%1$c    pid = fork();%1$c    if (pid == -1)%1$c        return (-1);%1$c    if (!pid)%1$c    {%1$c        if (execlp(%2$ccc%2$c, %2$ccc%2$c, %2$c-Wall%2$c, %2$c-Wextra%2$c, %2$c-Werror%2$c, %2$c-Wpedantic%2$c, file_name, %2$c-o%2$c, program_name, NULL) == -1)%1$c        {%1$c            dprintf(STDERR_FILENO, %2$cError compiling %3$cs%3$cc%2$c, program_name, 10);%1$c            exit(1);%1$c        }%1$c        exit(0);%1$c    }%1$c    wait(&exit_status);%1$c    if (WEXITSTATUS(exit_status) != 0)%1$c        return (-1);%1$c    pid = fork();%1$c    if (pid == -1)%1$c        return (-1);%1$c    if (!pid)%1$c    {%1$c        if (execve(program_name, (char *const[]){program_name, NULL}, environ) == -1)%1$c        {%1$c            dprintf(STDERR_FILENO, %2$cError executing %3$cs%3$cc%2$c, program_name, 10);%1$c            exit(1);%1$c        }%1$c        exit(0);%1$c    }%1$c    wait(&exit_status);%1$c    if (WEXITSTATUS(exit_status) != 0)%1$c        return (-1);%1$c    return (0);%1$c}%1$c%1$c#ifdef __linux__%1$cstatic int  check_executable_name(void)%1$c{%1$c    char path[PATH_MAX];%1$c    char *name;%1$c%1$c    bzero(path, sizeof(path));%1$c    if (readlink(%2$c/proc/self/exe%2$c, path, PATH_MAX) == -1)%1$c        return (0);%1$c    name = strrchr(path, '/');%1$c    if (!name)%1$c        return (0);%1$c    if (strcmp(name + 1, %2$cSully%2$c))%1$c        return (0);%1$c    return (1);%1$c}%1$c#elif defined(__APPLE__)%1$cstatic int  check_executable_name(void)%1$c{%1$c    pid_t process_id;%1$c    char path[PROC_PIDPATHINFO_MAXSIZE];%1$c    char *name;%1$c%1$c    process_id = getpid();%1$c    bzero(path, sizeof(path));%1$c    if (proc_pidpath(process_id, path, PROC_PIDPATHINFO_MAXSIZE) <= 0)%1$c        return (0);%1$c    name = strrchr(path, '/');%1$c    if (!name)%1$c        return (0);%1$c    if (strcmp(name + 1, %2$cSully%2$c))%1$c        return (0);%1$c    return (1);%1$c}%1$c#endif%1$c%1$cint main(void)%1$c{%1$c    int i = %4$d;%1$c    int dprintf_ret = 0;%1$c    int to_replace;%1$c    int fd = -1;%1$c    char program_name[50];%1$c    char file_name[50];%1$c    const char *str = %2$c%5$s%2$c;%1$c%1$c    if (i <= 0)%1$c        return (0);%1$c    if (check_executable_name() == 1)%1$c        to_replace = i;%1$c    else%1$c        to_replace = i - 1;%1$c    bzero(program_name, sizeof(program_name));%1$c    bzero(file_name, sizeof(file_name));%1$c    snprintf(file_name, 50, %2$cSully_%3$cd.c%2$c, to_replace);%1$c    snprintf(program_name, 50, %2$cSully_%3$cd%2$c, to_replace);%1$c    fd = open(file_name, O_RDWR | O_CREAT | O_TRUNC, 0644);%1$c    if (fd == -1)%1$c    {%1$c        dprintf(STDERR_FILENO, %2$cError trying to create/modify %3$cs%3$cc%2$c, file_name, 10);%1$c        return (1);%1$c    }%1$c    dprintf_ret = dprintf(fd, str, 10, 34, 37, to_replace, str);%1$c    close(fd);%1$c    if (dprintf_ret < 0)%1$c    {%1$c        dprintf(STDERR_FILENO, %2$cError trying to write in %3$cs%3$cc%2$c, file_name, 10);%1$c        return (1);%1$c    }%1$c    if (to_replace >= 0 && execute_and_wait(file_name, program_name) == -1)%1$c        return (1);%1$c    return (0);%1$c}%1$c";

    if (i <= 0)
        return (0);
    if (check_executable_name() == 1)
        to_replace = i;
    else
        to_replace = i - 1;
    bzero(program_name, sizeof(program_name));
    bzero(file_name, sizeof(file_name));
    snprintf(file_name, 50, "Sully_%d.c", to_replace);
    snprintf(program_name, 50, "Sully_%d", to_replace);
    fd = open(file_name, O_RDWR | O_CREAT | O_TRUNC, 0644);
    if (fd == -1)
    {
        dprintf(STDERR_FILENO, "Error trying to create/modify %s%c", file_name, 10);
        return (1);
    }
    dprintf_ret = dprintf(fd, str, 10, 34, 37, to_replace, str);
    close(fd);
    if (dprintf_ret < 0)
    {
        dprintf(STDERR_FILENO, "Error trying to write in %s%c", file_name, 10);
        return (1);
    }
    if (to_replace >= 0 && execute_and_wait(file_name, program_name) == -1)
        return (1);
    return (0);
}
