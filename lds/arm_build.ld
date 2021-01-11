SECTIONS
{
    . = 0x00000000;
    .text :
    {
        * (exception);
        * (.text);
    }
    .rodata :
    {
        * (.rodata);
    }
    fd_start = .;

    rd_start = 0x000a0000;
    . = rd_start;
    .data : AT (fd_start)
    {
        * (.data);
    }
    data_size = SIZEOF(.data);
}
