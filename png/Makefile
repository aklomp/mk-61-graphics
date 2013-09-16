all: \
  button-f button-shg-right button-shg-left button-v-o button-s-p \
  button-k button-p-to-x button-x-to-p button-bp button-pp \
  button-7 button-8 button-9 button-minus button-div \
  button-4 button-5 button-6 button-plus button-mul \
  button-1 button-2 button-3 button-swap button-v-up \
  button-0 button-period button-sign button-vp button-sx \
  button-sprite

button-%: ../mk-61.svg
	inkscape \
	  --export-png=temp.png \
	  --export-id=frame-$@ \
	  --export-dpi=360 \
	  $^
	pngtopnm < temp.png | pamscale 0.25 | pnmtopng > $@.png
	rm temp.png
	advpng -z4 $@.png
	pngout $@.png || true
