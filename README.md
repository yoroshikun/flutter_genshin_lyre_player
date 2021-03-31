## Flutter Genshin Lyre Auto Player

A native flutter implementation of a midi to Genshin Lyre player.

## Features

- Nativly compiled program, no pre-requisits required!
- Visual UI for ease of use
- Easy to use select your .mid to play
- Playback controls
- Soon: Easy editing of playback options

## How to use

1. Download the latest release from the releases tab (.zip)
2. Run the program in administrator mode (this is required for input into genshin client)
3. Open the .mid file you would like to player
4. Soon: Adjust the settings as you prefer
5. Click play to start playback (please ensure you are in the genshin window when playback starts)

> The UI will get better with time, I had to rush to put it all together

### Contributing

This project was hastily written with flutter and dart, if you want to contribute your knowledge please do so! I am still very new to OOP and flutter and would love feedback and contributions from the community.

Translations is also something I am looking for, if you know other languages and would like to translate the project please reach out!

#### Development setup

Fork and pull down this repo and follow the steps below :)

The flutter SDK is required and installation instructions are [here](https://flutter.dev/docs/get-started/install).

To develop in this repo with your own flutter setup you must first enable desktop compiling.

```bash
flutter config --enable-windows-desktop
```

> You can develop this app with other operating systems such as macosx and linux however many features require the windows API to work such as the file_picker and keypressing

It is highly recommended that you download the flutter dev tools for your IDE of choice to assist with developing

### Special Thanks

- Misaka17032 for the original inspiration and lyre auto play python script
- Dart_Midi package for native dart midi support
- Flutter team, for making flutter!

### Post script

Please credit this source when you use this program for content creation (Youtube, Reddit, etc.).
This program is Opensource and freeware, please do not sell it.

Please leave a star on the project if you enjoyed using it!
