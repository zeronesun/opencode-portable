#define _GNU_SOURCE
#include <dlfcn.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

static pid_t (*original_fork)(void) = NULL;
static int (*original_execve)(const char *pathname, char *const argv[], char *const envp[]) = NULL;

__attribute__((constructor))
static void init(void) {
    original_fork = dlsym(RTLD_NEXT, "fork");
    original_execve = dlsym(RTLD_NEXT, "execve");
}

pid_t fork(void) {
    pid_t pid = original_fork();
    if (pid == 0) {
        // 子进程：清除LD_PRELOAD
        unsetenv("LD_PRELOAD");
    }
    return pid;
}

int execve(const char *pathname, char *const argv[], char *const envp[]) {
    // 执行新程序前：清除LD_PRELOAD
    unsetenv("LD_PRELOAD");
    return original_execve(pathname, argv, envp);
}
