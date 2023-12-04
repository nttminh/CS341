#include <stdio.h>
int main()
{
  char line[100];
  int done =0;
  while (scanf("%[^\n]s", line) >0)
{
 //scanf("%[^\n]s", line);
printf("line is %s\n", line);
}
return 0;}

