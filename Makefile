# List all buttons by row. Use the IDs in the SVG file, without the `button-'
# prefix.
IDS :=   f   shg-right   shg-left   v-o     s-p
IDS +=   k   p-to-x      x-to-p     bp      pp
IDS +=   7   8           9          minus   div
IDS +=   4   5           6          plus    mul
IDS +=   1   2           3          swap    v-up
IDS +=   0   period      sign       vp      sx

# The `sprite' button is a pseudo-button that consists of all other buttons
# laid out tightly together to form a sprite image.
IDS += sprite

# Create the list of PNG files to produce.
PNGS := $(patsubst %,button-%.png,$(IDS))

.PHONY: all clean

all: $(PNGS)

%.png: mk-61.svg
	rsvg-convert \
	  --background-color white \
	  --export-id $* \
	  --output tmp.png \
	  $^
	pngcrush -brute tmp.png $@
	$(RM) tmp.png

clean:
	$(RM) $(PNGS)
