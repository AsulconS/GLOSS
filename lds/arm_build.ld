SECTIONS
{
    . = 0x00000000;
    .text :
    {
        * (exception);
        * (.text);
    }
    fd_start = .;

    rd_start = 0x0000a000;
    . = rd_start;
    .data : AT (fd_start)
    {
        * (.data);
    }
    data_size = SIZEOF(.data);
}
