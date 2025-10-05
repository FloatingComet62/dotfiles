file="~/.config/hypr/hypr-zoom/hypr-zoom"
if [ -f "$file" ]; then
  ./hypr-zoom -duration=10 -steps=50 -interp=Linear
else
  cd ~/.config/hypr/hypr-zoom/
  go build -o hypr-zoom
  ./hypr-zoom -duration=10 -steps=50 -interp=Linear
fi
