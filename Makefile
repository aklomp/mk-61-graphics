# List all buttons by row. Use the IDs in the SVG file, without the `button-'
# prefix.
IDS :=   f   shg-right   shg-left   v-o     s-p
IDS +=   k   p-to-x      x-to-p     bp      pp
IDS +=   7   8           9          minus   div
IDS +=   4   5           6          plus    mul
IDS +=   1   2           3          swap    v-up
IDS +=   0   period      sign       vp      sx

# Output directory.
OUTDIR := out

# Output directories for PNGs with white and alpha backgrounds.
DIR_ALPHA := $(OUTDIR)/png/alpha
DIR_WHITE := $(OUTDIR)/png/white

# Create the filenames for the PNGs with alpha background.
PNG_ALPHA := $(patsubst %,$(DIR_ALPHA)/button-%.png,$(IDS))

# Create the filenames for the PNGs with white background.
PNG_WHITE := $(patsubst %,$(DIR_WHITE)/button-%.png,$(IDS))

# The `sprite' button is a pseudo-button that consists of all other buttons
# laid out tightly together to form a sprite image. It is only added to the PNG
# outputs.
PNG_ALPHA += $(DIR_ALPHA)/button-sprite.png
PNG_WHITE += $(DIR_WHITE)/button-sprite.png

.PHONY: all clean

# Default rule: create both sets of PNGs.
all: $(PNG_ALPHA) $(PNG_WHITE)

# Rule to create the output directories.
$(DIR_ALPHA) $(DIR_WHITE):
	mkdir -p $@

# Output files depend on the existence of their output directory. This
# dependency is order-only, the modification time does not need to be checked.
$(PNG_ALPHA): | $(DIR_ALPHA)
$(PNG_WHITE): | $(DIR_WHITE)

# Set the background color for each PNG output type.
$(PNG_ALPHA): BACKGROUND=none
$(PNG_WHITE): BACKGROUND=white

# Generate the PNGs using a type-dependent background.
out/%.png: mk-61.svg
	rsvg-convert \
	  --background-color $(BACKGROUND) \
	  --export-id $(shell basename $@ .png) \
	  --output tmp.png \
	  $<
	pngcrush -brute tmp.png $@
	$(RM) tmp.png

clean:
	$(RM) -r $(OUTDIR)
