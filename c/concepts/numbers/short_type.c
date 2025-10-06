#include <stdio.h>
#include "numbers/short_type.h"
#include <limits.h>

void format_short_hi(char* buf, size_t bufsize, signed short int val)
{
    snprintf(buf, bufsize, "%hi", val);
}

void format_short_hd(char* buf, size_t bufsize, signed short int val)
{
    snprintf(buf, bufsize, "%hd", val);
}

void format_short_hu(char* buf, size_t bufSize, unsigned short int val)
{
    snprintf(buf, bufSize, "%hu", val);
}

void format_short_hx(char* buf, size_t bufSize, unsigned short int val)
{
    snprintf(buf, bufSize, "%hx", val);
}