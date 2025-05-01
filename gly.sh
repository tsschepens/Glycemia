## Uncomment depending on which shell you're using
## #!/bin/bash
## #!/bin/zsh
## source ~/.zshrc
## source ~/.bashrc
OUTPUT=$(gl)
GLYCEMIA=$(echo "$OUTPUT" | grep -oP '\d+(\.\d+)?')
SUPERLOW=40
LOW=70  
HIGH=180 
SUPERHIGH=400
if (( $(echo "$GLYCEMIA < $SUPERLOW" | bc -l) )); then
    COLOR="#fd84ff"
elif (( $(echo "$GLYCEMIA < $LOW" | bc -l) )); then
    COLOR="#f38ba8"
elif (( $(echo "$GLYCEMIA > $SUPERHIGH" | bc -l) )); then
    COLOR="#f5c2e7"
elif (( $(echo "$GLYCEMIA > $HIGH" | bc -l) )); then
    COLOR="#f9e2af" 
else
    COLOR="#94e2d5"
fi
echo "<span color='$COLOR'>$OUTPUT</span>"

