#ifndef __GLOSS__MEMUTILS_H
#define __GLOSS__MEMUTILS_H

#define LLSB(v) ((v) & 0xff)
#define MLSB(v) ((v) & 0xff00) >> 0x8
#define LMSB(v) ((v) & 0xff0000) >> 0x10
#define MMSB(v) ((v) & 0xff000000) >> 0x18

#define RDH(p)  *(const uint8_t*)(p) |\
                (*((const uint8_t*)(p) + 0x1) << 0x8)

#define RDW(p)  *(const uint8_t*)(p) |\
                (*((const uint8_t*)(p) + 0x1) << 0x8) |\
                (*((const uint8_t*)(p) + 0x2) << 0x10) |\
                (*((const uint8_t*)(p) + 0x3) << 0x18)

#define STH(p, v)   *((uint8_t*)(p)      ) = LLSB(v);\
                    *((uint8_t*)(p) + 0x1) = MLSB(v);

#define STW(p, v)   *((uint8_t*)(p)      ) = LLSB(v);\
                    *((uint8_t*)(p) + 0x1) = MLSB(v);\
                    *((uint8_t*)(p) + 0x2) = LMSB(v);\
                    *((uint8_t*)(p) + 0x3) = MMSB(v);\

#endif // __GLOSS__MEMUTILS_H
