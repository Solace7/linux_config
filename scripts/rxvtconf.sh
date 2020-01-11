xrdb ~/.Xresources

echo "URxvt.perl-ext-common: default,clipboard,tabbed,resize-font" | xrdb -merge
echo "URxvt*scrollTtyOutput: false" | xrdb -merge
echo "URxvt*scrollWithBuffer: true" | xrdb -merge

echo "URxvt.secondaryScreen: 1" | xrdb -merge
echo "URxvt.secondaryScroll: 0" | xrdb -merge
echo "URxvt.secondaryWheel: 1" | xrdb -merge

echo "URxvt.depth: 32" | xrdb -merge
echo "URxvt.background: rgba:0f00/0f00/0f00/c800" | xrdb -merge
echo "URxvt.font: xft:FuraCode Nerd Font Mono:size=13" | xrdb -merge
echo "URxvt.scrollBar: false" | xrdb -merge

echo "URxvt.clipboard.autocopy: true" | xrdb -merge
echo "URxvt.keysym.M-c: perl:clipboard:copy" | xrdb -merge
echo "URxvt.keysym.M-v: perl:clipboard:paste" | xrdb -merge

echo "URxvt.url-launcher: /usr/bin/xdg-open" | xrdb -merge
echo "URxvt.matcher.button: 1" | xrdb -merge
echo "URxvt.cursorUnderline: true" | xrdb -merge
echo "URxvt.cursortBlink: true" | xrdb -merge

