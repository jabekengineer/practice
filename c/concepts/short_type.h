#ifndef SHORT_TYPE_H
#define SHORT_TYPE_H

#ifdef __cplusplus
extern "C"
{
#endif

#include <stddef.h>

    void format_short_hi(char* buf, size_t bufsize, signed short int num);
    void format_short_hd(char* buf, size_t bufsize, signed short int num);
    void format_short_hu(char* buf, size_t bufsize, unsigned short int num);
    void format_short_hx(char* buf, size_t bufsize, unsigned short int num);
#ifdef __cplusplus
}
#endif

#endif // SHORT_TYPE_H