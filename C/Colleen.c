#include <stdio.h>
/*
    Comment outside the program
*/

static void print_me(const char *s) {
    printf(s, 10, 34, s);
}

int main(void) {
/*
    Comment inside the program
*/
    const char  *s = "#include <stdio.h>%1$c/*%1$c    Comment outside the program%1$c*/%1$c%1$cstatic void print_me(const char *s) {%1$c    printf(s, 10, 34, s);%1$c}%1$c%1$cint main(void) {%1$c/*%1$c    Comment inside the program%1$c*/%1$c    const char  *s = %2$c%3$s%2$c;%1$c%1$c    print_me(s);%1$c    return (0);%1$c}%1$c";

    print_me(s);
    return (0);
}
