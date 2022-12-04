#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int same_characters(const char *, const char *);

int same_characters3(const char *, const char *, const char *);

int prio(char p);

int string_comp(char *);

int string_comp2(char *, char *, char *);

int main() {
  FILE *fp;
  char *line = NULL;
  char *line2 = NULL;
  char *line3 = NULL;
  size_t len = 0;
  long r = 0;

  fp = fopen("input.txt", "r");

  while ((getline(&line, &len, fp)) != -1) {
    r = r + string_comp(line);
  }
  printf("%ld\n", r);
  fclose(fp);
  r = 0;

  fp = fopen("input.txt", "r");

  while ((getline(&line, &len, fp)) != -1) {
    getline(&line2, &len, fp);
    getline(&line3, &len, fp);
    r = r + string_comp2(line, line2, line3);
  }
  printf("%ld\n", r);
  fclose(fp);
  free(line);
  free(line2);
  free(line3);
  return 0;
}

int string_comp2(char *a, char *b, char *c) {
  return prio(same_characters3(a, b, c));
}

int string_comp(char *p) {
  char leftHalf[100], rightHalf[100], v;
  int length, mid, i, k, priority;
  length = strlen(p);
  mid = length / 2;
  for (i = 0; i < mid; i++) {
    leftHalf[i] = p[i];
  }
  for (i = mid, k = 0; i <= length; i++, k++) {
    rightHalf[k] = p[i];
  }

  v = same_characters(leftHalf, rightHalf);
  return prio(v);
}

int same_characters(const char *p, const char *q) {
  int counter = 0;
  int i;
  int j;
  for (j = 0; p[j] != '\0'; ++j) {
    for (i = 0; q[i] != '\0'; ++i) {
      if (p[j] == q[i]) {
        return p[j];
      }
    }
  }
  return counter;
}

int same_characters3(const char *p, const char *q, const char *s) {
  int i;
  int j;
  int k;
  for (k = 0; s[k] != '\0'; ++k) {
    for (j = 0; p[j] != '\0'; ++j) {
      for (i = 0; q[i] != '\0'; ++i) {
        if (p[j] == q[i] && q[i] == s[k]) {
          return p[j];
        }
      }
    }
  }
  return 0;
}

int prio(char p) {
  int x = (int)p;
  if (isupper(x)) {
    return (x - 38);
  } else {
    return (x - 96);
  }
}
