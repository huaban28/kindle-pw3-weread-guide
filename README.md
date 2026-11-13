# Kindle Paperwhite 3 + KOReader + 微信读书

A practical setup report for a **Kindle Paperwhite 3 (7th generation), Wi-Fi, firmware 5.16.2.1.1**. Includes SimpleUI and a direct 微信读书 bookshelf shortcut.

Tested on one device on **November 12, 2026**. This records a working setup, not a compatibility guarantee for other Kindles or future releases. Use the current upstream instructions when they differ from this report.

## Working setup

| Component | Version / choice |
| --- | --- |
| Jailbreak entry point | WinterBreak2, selected by the KindleModding wizard |
| Jailbreak completion marker | jb.sh v2.6.0 |
| Reader | KOReader 2026.07.1, **kindlepw2** package |
| 微信读书 plugin | finlater/weread.koplugin v1.7.0 |
| Interface | SimpleUI 3.0.3 |
| Chinese font | Noto Serif CJK SC Regular |

Confirmed on the device: KOReader launched, 微信读书 login worked, and the SimpleUI setup worked. The font file was installed and its copy verified; font appearance was not separately documented.

## 1. Prepare the Kindle

1. Charge above 50%, back up personal books and notes, and enable Airplane Mode.
2. Use a **micro-USB data cable**. A charging cable may power the Kindle without mounting its storage.
3. Confirm the Kindle shows **USB Drive Mode** and appears in the computer's file manager.
4. Use the [KindleModding jailbreak wizard](https://kindlemodding.org/jailbreak-wizard.html) with your own serial prefix, firmware, and registration status. Our registered PW3 was directed to WinterBreak2.
5. Follow [Prevent Automatic Updates](https://kindlemodding.org/jailbreaking/prevent-auto-update/). The procedure used temporary filler storage leaving 80 MB free before going online. Writing almost 2 GB took many minutes on this device. Do not unplug during a write.

If USB disconnect warnings occur, change the cable or USB port and verify the files before continuing. A completed copy alone does not prove the connection is stable.

## 2. Run the selected jailbreak

Follow the full [WinterBreak2 guide](https://kindlemodding.org/jailbreaking/WinterBreak2/), including its prerequisites:

1. Download `wb2.zip` from the guide's official release link.
2. Extract it so `winterbreak2/dialoger.html` exists at the Kindle storage root.
3. Safely eject and unplug, then connect the Kindle to Wi-Fi.
4. In the Kindle Experimental Browser, open the address specified by the guide and press **Jailbreak**.
5. Wait for completion. The device returned to its normal Home screen in this setup.

### Verify before installing anything else

Returning to Home is not sufficient evidence. We found `documents/JAILBROKEN.txt` with a success note and jb.sh v2.6.0. Entering **`;log`** in the Home search bar returned **“No arg passed”**, confirming that the custom command handler responded.

A marker file alone can be misleading: see the [WinterBreak2 issue about incomplete installations](https://github.com/KindleModding/Winterbreak2/issues/8). Investigate if commands only perform ordinary searches.

### Greyed-out “Update Your Kindle”

An additional universal hotfix was copied during troubleshooting, but the update option stayed greyed out. We did **not** force installation. The command handler worked and the setup proceeded successfully without installing that extra package.

Modern jailbreak stacks may already supply the hotfix and block updates. See the [current post-jailbreak instructions](https://kindlemodding.org/jailbreaking/whats-next/) and [maintainer discussion](https://github.com/KindleModding/Hotfix/issues/17). That discussion concerns a different Kindle; treat it as context, not proof about every device. Older jailbreaks may still require a hotfix. Do not install one merely because an old tutorial says to.

## 3. Install KOReader

Follow the [official Kindle installation instructions](https://github.com/koreader/koreader/wiki/Installation-on-Kindle-devices).

- For this PW3 on **5.16.2.1.1**, we used `koreader-kindlepw2-v2026.07.1.zip`. Do not select `kindlehf` for this firmware.
- Extract the package so `koreader/` and `extensions/` are at the USB storage root.
- Obtain the **KOReader launcher** from the scriptlet site linked by the official instructions, and put its `.sh` file in `documents/`. Our launcher appeared as **KOReader ASAP**.
- Safely eject, unplug, and open the launcher from the Library. Change the Library filter to All if needed.

This launcher requires working scriptlet support. If it does not appear or run, resolve the post-jailbreak setup first.

**Exit KOReader completely before connecting USB storage.** The official guide warns against plugging into USB mass-storage mode while KOReader is running.

## 4. Install and sign in to 微信读书

Use [finlater/weread.koplugin](https://github.com/finlater/weread.koplugin) and its release instructions:

1. Extract its release ZIP and copy `weread.koplugin/` into `koreader/plugins/`.
2. On your phone, open **微信读书 → 我 → 设置 → 微信读书 Skill → 获取 API Key** and generate the key.
3. Restart KOReader and enable Wi-Fi.
4. Open **工具 / Tools → 微信读书 → 微信扫码登录 / QR code login**.
5. Scan using WeChat, confirm on the phone, and enter any requested verification code on the Kindle.

If login reports **“No official API key was returned”**, enable 微信读书 Skill on the same account first, then request a fresh QR code and scan again. This was the login issue encountered in this setup.

Keep the key and login credentials private. Reading access depends on your account's existing entitlements; the plugin does not include a subscription or paid books. The open-source plugin's features differ from the author's separate closed-source WeReader product.

## 5. Add SimpleUI and the Chinese font

1. Exit KOReader, then connect USB.
2. Download the release ZIP from [SimpleUI](https://github.com/doctorhetfield-cmd/simpleui.koplugin/releases), extract it, and copy the correctly named `simpleui.koplugin/` folder into `koreader/plugins/`.
3. SimpleUI 3.0.3 requires KOReader 2026.03 or newer and the bundled **CoverBrowser** plugin enabled. Follow its current requirements; avoid combining competing interface plugins.
4. Download **Noto Serif CJK SC Regular** from the [official Noto CJK repository](https://github.com/notofonts/noto-cjk/tree/main/Serif/OTF/SimplifiedChinese), then copy the `.otf` into `koreader/fonts/`.
5. Safely eject, unplug, restart KOReader, and complete SimpleUI's welcome screen.
6. In a book, open the bottom font menu and select **Noto Serif CJK SC**. Use the font menu's default-setting option if you want it for future books.

### Add a 微信读书 button

In SimpleUI's Quick Actions, create an action of type **Plugin → 微信读书** and add it to the Navigation Bar. The plugin exposes `weread:openBookshelf()` as a launcher entry point.

For a fresh SimpleUI installation, this repository also supplies [an example settings file](config/sui_settings.example.lua). Exit KOReader first, back up any existing configuration, and copy the example to:

```text
koreader/settings/simpleui/sui_settings.lua
```

It adds Home Screen, 微信读书, Library, History, and Settings buttons. **Do not overwrite an existing configuration without a backup.** First-run layout selection or later UI updates may change the bar; use the Quick Actions UI to restore the button if necessary.

## Credits and scope

All jailbreaks, applications, plugins, and fonts belong to their respective upstream projects. This repository contains original documentation and a small example configuration only—no redistributed installers, books, account data, keys, or device photographs.

- [KindleModding](https://kindlemodding.org/) and [WinterBreak2](https://github.com/KindleModding/Winterbreak2)
- [KOReader](https://github.com/koreader/koreader)
- [微信读书 KOReader plugin](https://github.com/finlater/weread.koplugin)
- [SimpleUI](https://github.com/doctorhetfield-cmd/simpleui.koplugin)
- [Noto CJK](https://github.com/notofonts/noto-cjk)

Original documentation and configuration in this repository are licensed under MIT. Upstream software and fonts retain their own licenses.
