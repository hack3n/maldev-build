<a name="readme-top"></a>

[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
[![LinkedIn][linkedin-shield]][linkedin-url]

<h3>MalDev Build</h3>

<p>
  PowerShell script to spin up malware development tooling.
  <br />
  <a href="#installation"><strong>Install »</strong></a>
</p>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#installation">Installation</a>
    </li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

A PowerShell script to get basic malware development tooling configured.
 - [x] Installs Visual Studio + Visual Studio Code
 - [x] Disables Windows Defender
 - [x] Installs debugging tools and utilities like SysInternals
 - [x] Installs Google Chrome

### Built With

 - [![Chocolatey][Chocolatey-img]][Chocolatey-url]
 - Defender removal script ganked from https://github.com/jeremybeaume

### Installation

Start with a clean Windows VM, disable "Tamper Protection", then run the below in an elevated PowerShell.
```powershell
Set-ExecutionPolicy Bypass -Scope Process
Invoke-Expression (Invoke-RestMethod "https://raw.githubusercontent.com/hack3n/maldev-build/main/build.ps1")
```

To permanently disable Microsoft Defender:
 - Open Local Group Policy Editor (type gpedit in the search box)
 - Computer Configuration > Administrative Templates > Windows Components > Microsoft Defender Antivirus
 - Enable Turn off Microsoft Defender Antivirus
 - Reboot

## License

Distributed under the MIT License. See `LICENSE.txt` for more information.


## Contact

Project Link: [https://github.com/hack3n/maldev-build](https://github.com/hack3n/maldev-build)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[issues-shield]: https://img.shields.io/github/issues/hack3n/maldev-build.svg?style=for-the-badge
[issues-url]: https://github.com/hack3n/maldev-build/issues
[license-shield]: https://img.shields.io/github/license/hack3n/maldev-build.svg?style=for-the-badge
[license-url]: https://github.com/hack3n/maldev-build/blob/main/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/liam-o-brien-017aa6178/
[Chocolatey-img]: https://chocolatey.org/
[Chocolatey-url]: https://img.shields.io/badge/Chocolatey-black.svg?style=for-the-badge&logo=chocolatey&logoColor=white
