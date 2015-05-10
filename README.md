# CFxNES

A Nintendo Entertainment System emulator written in ECMAScript 6.

![CFxNES logo](https://raw.githubusercontent.com/jpikl/cfxnes/master/src/app/client/images/logo-md.png)

Try CFxNES out at [cfxnes.heroku.com](http://cfxnes.herokuapp.com)

CFxNES is in early development, so many of the NES games are not playable yet.
For best berformance, at least 2 GHz CPU and the **latest Google Chrome** or **Firefox**
are recommended.

The source code is licensed under the MIT License.
See LICENSE.txt for more details.

## Building and Running

    npm install
    bower install
    gulp

or alternatively

    npm install
    ./node_modules/bower/bin/bower install
    ./node_modules/gulp/bin/gulp.js

Application is running at <http://localhost:5000>.

## Game Library

Put your *.nes* ROM files inside the `dist/app/roms` directory to make them available in game library.
On non-Widows platforms, symbolic link `roms` to this directory is automatically created.

To have custom thumbnails you have to add image with the same name as the ROM file.
E.g., thumbnail for `Super Mario Bros.nes` should be named `Super Mario Bros.jpg`.
Supported image formats are *JPG*, *PNG* and *GIF*.

## Using CFxNES as a library

*The library API is currently unstable and undocumented.*

CFxNES can be used as a JS library to run NES games on your website.
The source code below provides a minimal example how to setup and run emulator.

    <!DOCTYPE html>
    <html>
    <head>
        <title>CFxNES</title>
        <script type="text/javascript" src="cfxnes.min.js"></script>
        <script type="text/javascript">
            window.onload = function() {
                var cfxnes = new CFxNES;
                cfxnes.setVideoOutput(document.getElementById("canvas"));
                cfxnes.downloadCartridge("game.nes", function() {
                    cfxnes.start(); // Success, run the game.
                }, function(error) {
                    alert("Error: " + error);
                });
            };
        </script>
    </head>
    <body>
        <canvas id="canvas"></canvas>
    </body>
    </html>

The `cfxnes.min.js` file can be obtained from http://cfxnes.herokuapp.com/scripts/cfxnes.min.js
or it can be build using `gulp lib` command. The output is generated to the `dist/lib` directory.
