#include <stdint.h>
#include <memutils.h>

#define WIDTH 240
#define HEIGHT 160
#define VGA_DMA_ADDR 0xc8000000

void _img_syscall(void* buffer)
{
    const uint8_t* data_buffer = (const uint8_t*)buffer;
    uint32_t data_offset = RDW(data_buffer + 0xa);

    uint16_t pixel_color;
    uint32_t pixel_offset;
    data_buffer += data_offset;
    for(int y = HEIGHT - 1; y >= 0; --y)
    {
        for(int x = 0; x < WIDTH; ++x)
        {
            pixel_color = RDH(data_buffer);
            pixel_offset = (y << 0xa) + (x << 0x1);
            STH(VGA_DMA_ADDR + pixel_offset, pixel_color);
            data_buffer += 0x2;
        }
    }
}
