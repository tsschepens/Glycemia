![Downloads](https://img.shields.io/github/commit-activity/m/tsschepens/Glycemia)

<br />
<div align="center">
  <h3 align="center">Glycemia Data and Waybar implementation</h3>

  <p align="center">
    Unofficial Repo made by a diabetic nerd
  </p>
</div>

## Installation
* [Librelink API Repo](https://github.com/DRFR0ST/libre-link-unofficial-api) (Not made by me of course, huge thanks to the creator of this)

* Don't forget to put this line in your package.json
    ```sh
    "type": "module"
    ```
## Once you've setup the node modules and installed all the dependencies
### In glyBase.js : 
* First you have to change that line according to the path of your cache file
    ```sh
    const cacheFile = path.join("/home/user/.cache/", "your-cache-file");
    ```
* Then you have to put your LibreLink credentials
    ```sh
    const client = new LibreLinkClient({ email: "your-email", password: "your-password" });
    ```
### In gly.sh : 
* Uncommment the line corresponding to your shell
    ```sh
    ## Uncomment depending on which shell you're using
    ## #!/bin/bash
    ## #!/bin/zsh
    ## source ~/.zshrc
    ## source ~/.bashrc
    ```
* You're all setup for the scripting part, to start the script and display your glycemia in your terminal, run this command (make sure you have an internet connection):
    ```sh
    export LIBRE_LINK_UP_VERSION=4.12.0
    node ~/your-path/glyBase.js'
    ```
* You can also create an alias to avoid typing this everytime :
    ```sh
    alias gl='export LIBRE_LINK_UP_VERSION=4.12.0
    node ~/your-path/glyBase.js'
    ```

## Waybar implementation
### Waybar config file 
* In your config.jsonc, you want to add this module (again, change 'your-path') : 
    ```sh
    "custom/glycemia": {
        "exec": "~/your-path/gly.sh",
        "interval": 120,
        "tooltip": false
    },
    ```
The interval is very important. I've tried putting a minute but I would get rate limit at some point... 2 minutes is the bare minimum. Feel free to try shorter intervall and make a pull request if you found one that doesn't get rate limit.

* Then, in your 'module-(right, center or left)', you just add it like any other module (custom/glycemia in this case). In my case : 
    ```sh
    "modules-right": ["custom/glycemia", "custom/padd","battery", "custom/padd", "clock","custom/notification","custom/padd"],
    ```

## Sandbar / River implementation
* First in your status config file, you want to add the glycemia function (or whatever you want to call it) : 
    ```sh
    glycemia() {
        glycemia="$(exec ~/your-path/glyColorless.sh || echo 'No Data')"
    }
    ```
Note that this is a different script than the one for Waybar. The output line is a bit different.
* The output line looks like this :  
    ```sh
    echo "^fg($COLOR)$OUTPUT^fg(#'default-text-color')"
    ```
The part :
    ``` 
    ^fg(#'default-text-color')
    ```
is meant to override the color output for the rest of the line. Without it, you would have everything after the glycemia function colored like the glycemia. We don't want that...

* Then, still in the status config file, you add another line in the while loop (assuming you used a while loop to time the refresh rate of your Sandbar modules. If not, you should, it's litteraly the default config recommended): 
    ```sh
    [ $((sec % 120)) -eq 0 ] && glycemia
    ```
Again, 120 seconds is the minimum refresh rate accepted by the API (at least for what I tested) if you don't want to get rate limit

## Fastfetch implementation
* Additionally, if you want your glycemia displayed in Fastfetch, you can display the content of your cache file in a module : 
    ```sh
    {
      "type": "command",
      "key":  "  Glycemia",
      "keyColor": "magenta",
      "text": "cat ~/.cache/your-cache-file"
    },
    ```
You want to display the cache file and not launch the script everytime you're starting fastfetch because of rate limit problems and fastfetch time loading (you can even have display problems...)

## Final recommandation
You want to be careful when modifying your waybar / Sandbar (either if it concerns the script or not). I would advise commenting the line that call the scripts in your waybar when modifying it, it avoid some (again) rate limit problems

Also, this tutorial could be applied to many more use, I plan on expanding the repo with some server implementation, up to remaking the entire LibreLink app... Maybe one day...
