# flipper-bambu

NFC supported-card plugin for reading Bambu Lab filament spool RFID tags on [Flipper Zero](https://flipper.net).

<p>
  <img src="media/screenshot-1-main.png" alt="Screenshot showing filament color, code and production date" width="384" />
  <img src="media/screenshot-2-config.png" alt="Screenshot showing configurations" width="384" />
</p>

## Features

- Reads Bambu Lab MIFARE Classic 1K spool RFID tags directly from the NFC app
- Derives the tag keys from the spool UID, so no manual key matching or custom firmware is required
- Shows material family and detailed variant, such as PLA Basic, PLA Matte, PETG HF, ABS, and TPU
- Displays the raw hex code read from the tag and the mapped Bambu color name on the next line
- Shows the Bambu filament code for easier reordering
- Shows production date, spool weight, diameter, spool width, and filament length when present
- Shows print configuration details including hotend min/max, drying temperature/time, and minimum nozzle diameter
- Includes a standalone parser test suite with real Bambu Lab NFC dumps

Watch the [demo video](https://www.youtube.com/watch?v=iJgRLGE2dqY) on YouTube.

## Installation

1. Download `bambu_parser.fal` from the [Releases](../../releases) page
2. Copy to Flipper Zero SD card: `/ext/apps_data/nfc/plugins/`. You can write to the card directly or via [qFlipper](https://flipper.net/pages/downloads)
3. Restart the NFC app.

## Usage

1. Scan a Bambu Lab spool with the NFC app (or load a saved dump)
    - You can skip the key matching step on the next screen once the Bambu tag is read. This step is not needed.
2. The "Bambu Lab Spool" section will appear showing:
   - Material type and detailed variant
   - Hex code read from the tag
   - Bambu color name from the lookup table
   - Filament code
   - Production date
   - Temperature settings (hotend min/max, drying temp/hours)
   - Physical properties (weight, diameter, spool width, length)

## Build from Source

1. Install uFBT:

   ```bash
   python3 -m pip install ufbt SCons ansi
   ```

2. Clone the repository:
   ```bash
   git clone https://github.com/uzyn/flipper-bambu.git
   cd flipper-bambu
   ```

3. Build the plugin:
   ```bash
   ufbt
   ```
   Output: `dist/bambu_parser.fal`

4. Copy `dist/bambu_parser.fal` to Flipper Zero SD card: `/ext/apps_data/nfc/plugins/`


## Running Tests

```bash
make test
```

## Filament Data

The plugin parses the hex color value stored on the RFID tag. Bambu color names and filament codes are resolved from the bundled lookup table in `plugin/bambu_filaments.h`, sourced from the community-maintained [Bambu-Lab-RFID-Library](https://github.com/queengooborg/Bambu-Lab-RFID-Library). Bambu Lab also publishes product color hex tables on store pages, but RFID/AMS-reported tag colors may differ from store swatches.

## Credits

- Filament database sourced from [queengooborg/Bambu-Lab-RFID-Library](https://github.com/queengooborg/Bambu-Lab-RFID-Library)
- Tag format research from [Bambu-Research-Group/RFID-Tag-Guide](https://github.com/Bambu-Research-Group/RFID-Tag-Guide)

## License

GPL-3.0 ⋅ U-Zyn Chua [https://uzyn.com](https://uzyn.com)
