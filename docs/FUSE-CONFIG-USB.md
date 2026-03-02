# Load FUSE at boot (Web UI mount) via CONFIG USB

The Web UI **Mount** feature needs the `fuse` kernel module on the host. On Home Assistant OS you can load it at every boot using the official **CONFIG USB** (no udev needed — use the **modules** folder).

Ref: [HA OS configuration](https://developers.home-assistant.io/docs/operating-system/configuration)

## Steps

1. **Prepare the USB**
   - Format a USB stick as **FAT32**, **EXT4**, or **NTFS**.
   - Name the partition or drive **CONFIG** (all capitals).

2. **Add the module config**
   - On the CONFIG USB create this path:
     - **modules** (folder)
     - **modules/fuse.conf** (file)
   - Put a single line in `fuse.conf`:
     ```
     fuse
     ```
   - Use **Unix (LF)** line endings. (On Windows use Notepad++ or VS Code and set EOL to LF.)

3. **Apply it**
   - **Option A:** Insert the USB before booting the device; the OS reads CONFIG at startup and copies `modules/*` into `/etc/modules-load.d/`, so `fuse` loads at boot.
   - **Option B:** Insert the USB while HA is running, then from a **host** shell (e.g. Terminal & SSH add-on with host access) run:
     ```bash
     ha os import
     ```
     or:
     ```bash
     systemctl restart hassos-config
     ```
     Then reboot so the module is loaded on next boot.

4. **Done**
   - After the first import the config is on the OS; you can remove the USB.
   - Web UI **Mount** should work after the next boot.

## Alternative: CONFIG on boot partition

Instead of a separate USB, you can create a **CONFIG** folder on the **boot** partition of your HA device and put the same **modules/fuse.conf** inside it. Same behavior: the OS merges it into `/etc/modules-load.d/` at import.

## One-off (until reboot)

From a host shell:

```bash
modprobe fuse
```

This does not survive reboot unless you also add the CONFIG USB (or boot-partition CONFIG) as above.
