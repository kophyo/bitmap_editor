# Bitmap editor

## Running

To run the bitmap editor:

`bin/bitmap_editor examples/show.txt`

## Commands

There are 6 available commands:

```
I M N - Create a new M x N image with all pixels coloured white (O). Can override with an argument at the end (eg., I M N X).
C - Clears the table, setting all pixels to white (O).
L X Y C - Colours the pixel (X,Y) with colour C.
V X Y1 Y2 C - Draw a vertical segment of colour C in column X between rows Y1 and Y2 (inclusive).
H X1 X2 Y C - Draw a horizontal segment of colour C in row Y between columns X1 and X2 (inclusive).
S - Show the contents of the current image

```

## Tests
`bundle exec rspec`
