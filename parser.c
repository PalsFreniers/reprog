#include <stdio.h>
#include <string.h>

// extern int list_cmd(char *);
// 
// int handle_cmd(char *cmd) {
//         char s[32];
//         if(cmd == ((void *)0)) return 0;
//         int i;
//         for (i = 0; cmd[i] != 0 || cmd[i] != ' '; i++) s[i] = cmd[i];
//         if(strcmp(s, "list")) return list_cmd(cmd + i);
//         else return 0;
// }

int main(int argc, char **argv, char **envp) {
        while(*envp) {
                printf("%s\n", *envp++);
        }
        return 0;
}
