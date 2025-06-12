#!/bin/zsh
source ~/.zshrc
OUTPUT=$("Alias de votre commande. Ex : 'gl'")
GLYCEMIA=$(echo "$OUTPUT" | grep -oP '\d+(\.\d+)?')
SUPERLOW=40
LOW=70  
HIGH=180 
SUPERHIGH=400
if (( $GLYCEMIA < $SUPERLOW )); then
    COLOR="#fd84ff"
elif (( $GLYCEMIA < $LOW )); then
    COLOR="#f38ba8"
elif (( $GLYCEMIA > $SUPERHIGH )); then
    COLOR="#f5c2e7"
elif (( $GLYCEMIA > $HIGH )); then
    COLOR="#f9e2af" 
else
    COLOR="#94e2d5"
fi
echo "^fg($COLOR)$OUTPUT^fg(#bcb5ff)"
