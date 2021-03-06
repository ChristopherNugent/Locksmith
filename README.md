<div align="center">
  <span align="center"> <img width="80" height="80" class="center" src="https://github.com/ChristopherNugent/Locksmith/blob/master/data/images/com.github.christophernugent.locksmith.png" alt="Icon"></span>
  <h1 align="center">Locksmith</h1>
  <h3 align="center">Generate strong, secure passwords</h3>
</div>

<br/>

<p align="center">
    <a href="https://appcenter.elementary.io/com.github.christophernugent.locksmith">
        <img src="https://appcenter.elementary.io/badge.svg">
    </a>
</p>

<p align="center">
  <a href="https://github.com/ChristopherNugent/Locksmith/blob/master/LICENSE">
    <img src="https://img.shields.io/badge/License-GPL-blue.svg">
  </a>
  <a href="https://github.com/ChristopherNugent/Locksmith/releases">
    <img src="https://img.shields.io/badge/Release-%201.3.1-orange.svg">
  </a>
</p>

<p align="center">
    <img  src="https://i.imgur.com/HoGedDY.png" alt="Screenshot"> <br>
    <img  src="https://i.imgur.com/6iq4EkD.png" alt="Screenshot"> <br>    
  <a href="https://github.com/ChristopherNugent/Locksmith/issues/new"> Report a problem! </a>
</p>

## Installation

### Dependencies
These dependencies must be present before building:
 - `meson`
 - `valac`
 - `debhelper`
 - `libgranite-dev`
 - `libgtk-3-dev`
 - `libgee-0.8-dev`

Use the App script to simplify installation by running `./app install-deps`
 
 ### Building

```
git clone https://github.com/ChristopherNugent/Locksmith.git com.github.christophernugent.locksmith && cd com.github.christophernugent.locksmith
./app install-deps && ./app install
```

### Deconstruct

```
./app uninstall
```

### Development & Testing

Locksmith includes a script to simplify the development process. This script can be accessed in the main project directory through `./app`.

```
Usage:
  ./app [OPTION]

Options:
  clean             Removes build directories (can require sudo)
  generate-i18n     Generates .pot and .po files for i18n (multi-language support)
  install           Builds and installs application to the system (requires sudo)
  install-deps      Installs missing build dependencies
  run               Builds and runs the application
  test              Builds and runs testing for the application
  test-run          Builds application, runs testing and if successful application is started
  uninstall         Removes the application from the system (requires sudo)
```

### Contributing

To help, access the links below:

- [Guide on Code Style](https://github.com/ChristopherNugent/Locksmith/wiki/Guide-on-code-style)

- [Proposing Design Changes](https://github.com/ChristopherNugent/Locksmith/wiki/Proposing-Design-Changes)

- [Reporting Bugs](https://github.com/ChristopherNugent/Locksmith/wiki/Reporting-Bugs)

- [Translate](https://github.com/ChristopherNugent/Locksmith/wiki/Translate)


### License

This project is licensed under the GPL-3.0 License - see the [LICENSE](LICENSE) file for details.

### Change Log

#### 1.3.1
* Make the UI appear more like an ElementaryOS dialog
* Abstract parts of PasswordView to create more shared code.

#### 1.3.0
* UI overhaul

#### 1.2.0
* Locksmith now restores previous state on re-launch

#### 1.1.0
* Locksmith can now generate "xkcd style" passwords

#### 1.0.0
* MVP release for Locksmith
