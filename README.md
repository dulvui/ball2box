<!--
SPDX-FileCopyrightText: 2023 Simon Dalvai <info@simondalvai.org>

SPDX-License-Identifier: CC0-1.0
-->
# Ball2Box
[![Android upload](https://github.com/dulvui/ball2box/actions/workflows/upload-android.yml/badge.svg)](https://github.com/dulvui/ball2box/actions/workflows/upload-android.yml)
[![iOS upload](https://github.com/dulvui/ball2box/actions/workflows/upload-ios.yml/badge.svg)](https://github.com/dulvui/ball2box/actions/workflows/upload-ios.yml)
[![itch.io upload](https://github.com/dulvui/ball2box/actions/workflows/upload-itchio.yml/badge.svg)](https://github.com/dulvui/ball2box/actions/workflows/upload-itchio.yml)
[![REUSE Compliance Check](https://github.com/dulvui/ball2box/actions/workflows/reuse.yml/badge.svg)](https://github.com/dulvui/ball2box/actions/workflows/reuse.yml)  

Swipe to toss the ball and hit the box in over 100 levels.
This game is open source, with no ads and no tracking.  

Made with [Godot Engine](https://godotengine.org) version 3.5.2  
Track the migration to Godot 4.x in [issue #6](https://github.com/dulvui/ball2box/issues/6)  

<a href="https://play.google.com/store/apps/details?id=com.salvai.ultimatetoss" target="_blank"><img src="store-images/PlayStore.svg" alt="Get it on Google Play" height="49px"></a>
<a href="https://apps.apple.com/us/app/ball2box/id1522604143" target="_blank"><img src="store-images/AppStore.svg" alt="Download on the App Store" height="50px" ></a>
<a href="https://f-droid.org/en/packages/com.simondalvai.ball2box/" target="_blank"><img src="store-images/get-it-on-en.webp" alt="Get it on F-Droid" height="50px" ></a>
<a href="https://github.com/dulvui/ball2box/releases/" target="_blank"><img src="store-images/Github.webp" alt="Get it on Github" height="50px" ></a>
<a href="https://simondalvai.itch.io/ball2box" target="_blank"><img src="store-images/itchio.webp" alt="Available on itch.io" height="50px" ></a>

<div>
  <img src="metadata/en-US/images/phoneScreenshots/Android-1.png" alt="Level 1" width="200"/>
  <img src="metadata/en-US/images/phoneScreenshots/Android-2.png" alt="Level 2" width="200"/>
  <img src="metadata/en-US/images/phoneScreenshots/Android-3.png" alt="Level 3" width="200"/>
  <img src="metadata/en-US/images/phoneScreenshots/Android-4.png" alt="Level 4" width="200"/>
</div>

## Table of contents
- [Ball2Box](#ball2box)
  - [Table of contents](#table-of-contents)
  - [Setup](#setup)
    - [export\_presets.cfg](#export_presetscfg)
  - [Contributions](#contributions)
  - [Licenses](#licenses)
    - [Code](#code)
    - [Audio](#audio)
    - [2D assets](#2d-assets)
    - [3D assets](#3d-assets)
    - [Font](#font)

## Setup
Get the latest version of the Godot Engine editor and check out the  
repo. Then open the `game/project.godot` file with the editor.

For further instructions, like exporting to mobile, please read the official [Godot Docs](https://docs.godotengine.org/en/stable/).

### export_presets.cfg

To be able to export for Android or iOS, copy the `export_presets.exmaple` file and fill in your values.
```sh
cp game/export_presets.example game/export_presets.cfg
```

## Contributions
If you want to contribute to the project, please fork the repo,    
make your changes and make a pull request with a short description  
of the changes you made.

## Licenses
The game itself is licensed under the [GNU AGPL v3.0](LICENSE) license and all  
assets made by myself are licensed under the [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/) license.

### Code

"Ball2Box"
Copyright: 2020 Simon Dalvai
License: [GNU AGPL v3.0](LICENSE)
```
game/src/**.tscn
game/src/**.gd
```

"Godot Engine"
Copyright: Juan Linietsky, Ariel Manzur and contributors
License: [MIT](godotengine.org/license)

### Audio

"The heist" Royalty-Free Music
Copyright: https://audiohub.com  
License: [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/)
```
game/assets/audio/heist.ogg
```

"Snares and Crash"
Copyright: LMMS (https://github.com/LMMS/assets)  
License: [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/)
```
game/assets/audio/snare05.ogg
game/assets/audio/snare02.ogg
game/assets/audio/crash02.ogg
```
### 2D assets

"2D Assets"
Copyright: 2020 Simon Dalvai
License: [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/)
```
icon.png
game/assets/target.jpg
game/assets/background-2.png
game/assets/pause.png
```

"Game Icons"
Copyright: kenney.nl (https://www.kenney.nl/assets/game-icons)  
License: [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/)
```
game/assets/star.png
game/assets/right.png
game/assets/musicOn.png
game/assets/musicOff.png
game/assets/left.png
game/assets/audioOn.png
game/assets/audioOff.png
game/assets/arrowDown.png
game/assets/information.png
game/assets/pointer.png
```

"Patterns Pack"
Copyright: kenney.nl (https://www.kenney.nl/assets/pattern-pack)  
License: [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/)
```
game/assets/patterns/pattern_04.png
game/assets/patterns/pattern_09.png
game/assets/patterns/pattern_27.png
```

"Patterns Pack 2"
Copyright: kenney.nl (https://www.kenney.nl/assets/pattern-pack-2)  
License: [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/)
```
game/assets/patterns/pattern_0001.png
game/assets/patterns/pattern_0003.png
game/assets/patterns/pattern_0007.png
game/assets/patterns/pattern_0008.png
game/assets/patterns/pattern_0021.png
game/assets/patterns/pattern_0024.png
game/assets/patterns/pattern_0025.png
```

### 3D assets

"Torus ball"
Copyright: 2020 Simon Dalvai
License: [CC-BY-SA-4.0](https://creativecommons.org/licenses/by-sa/4.0/)
```
game/assets/obj/torus-ball.obj
```


"Star"
Copyright: Savino (https://opengameart.org/content/star-0)  
License: [CC0-1.0](https://creativecommons.org/publicdomain/zero/1.0/)
```
game/assets/obj/star.obj
```

"Volleyball"
Copyright: PatelDev (https://skfb.ly/6VWCM)  
License: [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)
```
game/assets/obj/Volleyball.obj
```

"Football"
Copyright: siixarn (https://skfb.ly/KqJH)  
License: [CC-BY-4.0](http://creativecommons.org/licenses/by/4.0/)
```
game/assets/obj/Football.blend.obj
``` 

License: "Octoball"
Copyright: EZduzziteh (https://opengameart.org/content/some-more-wire-balls)  
[CC-BY-3.0](https://creativecommons.org/licenses/by/3.0/)
```
game/assets/obj/Octoball.obj
```

### Font

"manrope.thin.otf"
Copyright: sharanda (https://github.com/sharanda/manrope)  
License: [SIL Open Font License](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)
```
game/assets/font/manrope.thin.otf
```
