<!-- markdownlint-disable MD004 MD033 -->

<div align="center">

**English** | [Русский](README_RU.md)

# InternalCooldowns

![Lua 5.1](https://img.shields.io/badge/Lua-5.1-2C2D72?style=flat-square&logo=lua&logoColor=white)
![WoW 3.3.5a](https://img.shields.io/badge/WoW-3.3.5a-C79C6E?style=flat-square)
[![License](https://img.shields.io/github/license/darhanger/InternalCooldowns?style=flat-square)](https://github.com/darhanger/InternalCooldowns/blob/main/LICENSE)
[![Last Release](https://img.shields.io/github/v/release/darhanger/InternalCooldowns?style=flat-square)](https://github.com/darhanger/InternalCooldowns/releases/latest)
[![Release Downloads](https://img.shields.io/github/downloads/darhanger/InternalCooldowns/1.31/total?style=flat-square)](https://github.com/darhanger/InternalCooldowns/releases/tag/1.31)
[![All Downloads](https://img.shields.io/github/downloads/darhanger/InternalCooldowns/total?style=flat-square)](https://github.com/darhanger/InternalCooldowns/releases)
[![Discord Server](https://img.shields.io/badge/Discord-7289DA?style=flat-square&logo=discord&logoColor=white)](https://discord.gg/ZKFkvrzaU4)

**InternalCooldowns** tracks hidden internal cooldowns triggered by procs from equipped items, enchants, meta gems and supported talents.

Designed for **World of Warcraft 3.3.5a**.

</div>

## Features

InternalCooldowns detects supported proc effects and exposes their internal cooldowns through the standard World of Warcraft cooldown system.

The addon can:

- detect procs from supported trinkets and other equipped items;
- track supported weapon and equipment enchant procs;
- track supported meta gem effects;
- track selected talent and set bonus procs;
- display cooldown spirals on equipped items in the character window;
- display internal cooldowns on action bar item buttons and compatible macros;
- refresh Bartender4 action buttons when a proc starts;
- send hidden cooldowns to ForteXorcist;
- show a notification when an internal cooldown becomes ready through LibSink-compatible output;
- save its output settings between sessions.

The addon works automatically after logging into the game.

## What is an internal cooldown?

Many equipment effects can trigger automatically when you deal damage, heal, cast a spell or receive an appropriate combat event.

The visible buff may last only a few seconds, but the item often has a hidden cooldown before it can trigger again. This hidden timer is commonly called an **internal cooldown**, or **ICD**.

InternalCooldowns starts that timer when a known proc is detected, allowing you to estimate when the effect can activate again.

## Display methods

### Character equipment slots

When a supported equipped item procs, the addon applies a standard cooldown spiral to the corresponding slot in the character window.

This makes it possible to see the remaining internal cooldown directly on the equipped item.

### Action bars and item macros

InternalCooldowns hooks the standard cooldown API used by item buttons.

A supported item placed on an action bar can therefore display its internal cooldown using the normal cooldown animation.

The addon also recognizes macros whose icon matches one of the equipped trinket slots.

### Bartender4

When Bartender4 is installed, InternalCooldowns refreshes visible Bartender4 buttons after a supported proc starts.

No separate Bartender4 configuration is required.

### ForteXorcist

When ForteXorcist is available, supported item and talent procs can be added as hidden cooldowns using their names, durations and icons.

### Ready notifications

After a tracked cooldown expires, the addon can send an `ICD Ready` notification through LibSink-compatible output.

The exact destination depends on the available scrolling combat text or message output addons.

## Supported proc sources

The bundled database contains mappings for many Wrath of the Lich King effects, including examples from:

- trinkets;
- Icecrown Citadel equipment;
- Ruby Sanctum equipment;
- reputation rings;
- tier set bonuses;
- weapon enchants;
- engineering enchants;
- meta gems;
- selected class talents.

Support is database-driven. A proc is tracked only when its spell, item, enchant or talent identifier is known to the addon.

## Example

A supported trinket proc can appear as a cooldown spiral on its equipped slot or action button:

<div align="center">

![InternalCooldowns example](https://media.forgecdn.net/attachments/107/418/icd1.jpg)

</div>

## Installation

1. Download the latest version from the [Releases](https://github.com/darhanger/InternalCooldowns/releases) page.
2. Extract the downloaded archive.
3. Copy the `InternalCooldowns` addon folder into:

```text
World of Warcraft\Interface\AddOns\
```

4. Make sure the resulting folder structure looks similar to:

```text
World of Warcraft
└── Interface
    └── AddOns
        └── InternalCooldowns
            ├── InternalCooldowns.toc
            ├── Core.lua
            ├── embeds.xml
            ├── modules.xml
            ├── Modules
            └── Libs
```

5. Restart the game client.
6. Enable **InternalCooldowns** in the character selection addon list.

## Usage

InternalCooldowns does not require slash commands.

1. Equip a supported item, enchant or meta gem.
2. Enter combat and trigger its proc.
3. The addon detects the combat log event.
4. The internal cooldown is displayed on supported equipment slots or action buttons.
5. When the timer expires, an optional ready notification is generated.

For the clearest result, place the equipped trinket or item on an action bar.

## How it works

InternalCooldowns listens to the combat log and checks whether a detected proc belongs to the player and corresponds to a supported equipped source.

When a proc is recognized, the addon stores:

- the source item or effect;
- the proc spell;
- the cooldown start time;
- the known internal cooldown duration.

It then supplies the stored timer through the standard functions used by the Blizzard UI:

- `GetInventoryItemCooldown`;
- `GetActionCooldown`;
- `GetItemCooldown`.

This allows compatible UI elements and addons to reuse the same timer without requiring a separate custom bar.

## Included libraries

The addon includes the required libraries, so they do not need to be installed separately:

- AceAddon-3.0
- AceConfig-3.0
- AceDB-3.0
- AceEvent-3.0
- LibInternalCooldowns-1.1
- LibSink-2.0
- LibStub
- CallbackHandler-1.0

## Optional integrations

InternalCooldowns can integrate with:

- **Bartender4**
- **ForteXorcist / Forte_Cooldown**
- scrolling combat text and message addons supported by **LibSink-2.0**

These addons are optional. InternalCooldowns can still track and display cooldowns through the standard Blizzard interface without them.

## Compatibility

- World of Warcraft **3.3.5a**
- Interface version **30300**
- Lua **5.1**
- Standard Blizzard combat log
- Standard Blizzard action bars and character equipment frame
- Optional Bartender4 and ForteXorcist integration

## Custom server limitations

Custom servers may change item IDs, spell IDs, proc names, proc durations or combat log behavior.

A proc may not be tracked when:

- the server uses a custom item or spell ID;
- the proc spell differs from the original 3.3.5a data;
- the internal cooldown duration was modified;
- the combat log does not report the expected event;
- the item is missing from the bundled database.

In these cases, the relevant mapping and cooldown duration must be added to the addon database.

## Why use InternalCooldowns?

The addon can help with:

- aligning offensive cooldowns with trinket procs;
- planning burst damage windows;
- timing healing cooldowns around equipment effects;
- checking when a passive proc can activate again;
- comparing proc behavior while testing equipment;
- debugging custom item and enchant mechanics;
- developing rotations and combat addons for WoW 3.3.5a.

## Support

For bug reports, feature requests and missing proc reports, use:

- [GitHub Issues](https://github.com/darhanger/InternalCooldowns/issues)

When reporting an unsupported or incorrect proc, include:

- the item link or item ID;
- the proc spell name and spell ID;
- the expected internal cooldown duration;
- the game server or client;
- a combat log example, when available;
- whether the normal or heroic item version is used.

## Credits

Original addon by **Ardentvark**.

World of Warcraft 3.3.5a support and maintenance by **DarhangeR**.

## Contributing

Contributions are welcome.

You can help by:

- reporting missing items and proc effects;
- verifying internal cooldown durations;
- adding support for custom server items;
- testing Bartender4 or ForteXorcist integration;
- improving documentation;
- submitting pull requests.

## License

This project is distributed under the terms of the [GNU General Public License v3.0](https://github.com/darhanger/InternalCooldowns/blob/main/LICENSE).

---

<div align="center">

Made for World of Warcraft 3.3.5a

[Download](https://github.com/darhanger/InternalCooldowns/releases) ·
[Report an issue](https://github.com/darhanger/InternalCooldowns/issues) ·
[Discord](https://discord.gg/ZKFkvrzaU4)

</div>