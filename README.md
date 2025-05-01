<br />
<div align="center">
  <h3 align="center">Glycemia Data and Waybar implementation</h3>

  <p align="center">
    Unofficial Repo made by a diabetic nerd
  </p>
</div>

## Installation
* Librelink API Repo (Not made by me of course, huge thanks to the creator of this)
    ```sh 
    https://github.com/DRFR0ST/libre-link-unofficial-api
    ```
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
* You're all setup for the scripting part, to start the script and display your glycemia in your terminal, run this command (don't forget to change 'your-path' to the actual path):
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
The interval is very important. I've tried putting a minute but I would get rate limit at some point... 2 minutes is the bare minimum. Feel free to try shortest intervall and make a pull request if you're finding one that doesnt rate limit.

* Then, in your 'module-(right, center or left)', you just add it like any other module (custom/glycemia in this case). In my case : 
    ```sh
    "modules-right": ["custom/glycemia", "custom/padd","battery", "custom/padd", "clock","custom/notification","custom/padd"],
    ```
