---
name: windows-bluetooth-audio-triage
description: Diagnose a Windows Bluetooth speaker that is stuttering or cutting out. Use when the current output device must be confirmed before a low-risk reset.
argument-hint: "[current device name]"
allowed-tools: Read, Grep, Bash
---

# Windows Bluetooth Audio Triage

## When to use

Use for a Windows Bluetooth speaker/headset that stutters, cuts out, or has an incorrect active endpoint. Do not use it to delete pairings, change drivers, or alter system-wide settings without a user request.

## Inputs / context

1. Ask or confirm what is actually playing now. Treat historical device names as clues only.
2. Gather `Get-PnpDevice -Class Bluetooth`, `Get-PnpDevice -Class AudioEndpoint`, and `Get-Service bthserv,Audiosrv`.
3. Note duplicate names and their `Status`; find the active endpoint before selecting a PnP instance.

## Procedure

1. Confirm the current audio endpoint and its status. A numbered endpoint such as `耳机 (2- <device>)` can be current while an unnumbered duplicate is an old `Unknown` entry.
2. Restart the audio and Bluetooth services:
   `Restart-Service -Name 'Audiosrv' -Force`
   `Restart-Service -Name 'bthserv' -Force`
   Re-query both services and require `Running`.
3. Reset only the selected device's Bluetooth PnP instance with `Status -eq 'OK'`: disable it, then enable it, and re-query the Bluetooth and AudioEndpoint classes.
4. If the user changed Wi-Fi as mitigation, verify it read-only with `netsh wlan show interfaces`; report SSID, `Band`, and `Channel` rather than assuming the intended band took effect.
5. Require a 1–2 minute playback test. Report “connection/endpoint returned to OK; playback pending” if no test result is available.
6. If it still stutters after a verified reset, inspect the Bluetooth adapter's USB placement, USB 3.0/2.4 GHz interference, driver, and microphone applications. For JBL-style devices, choose the normal stereo endpoint rather than Hands-Free and close apps that may open the microphone. Do not tell the user to separate internal Wi-Fi/Bluetooth hardware; placement advice applies to an external USB adapter.

## Efficiency plan

- Run the three enumeration commands before any reset; this avoids resetting the wrong historical device.
- Cache the selected instance ID only for the current incident. Do not reuse it across reconnects or different devices.
- Stop after the first targeted reset until playback is tested; do not repeat service restarts without new evidence.

## Pitfalls and fixes

- `Disable-PnpDevice` returns `常规故障` for a Hands-Free endpoint: re-query status; use Sound settings or Device Manager instead of claiming it was reset.
- `Restart-Service` / device reset is denied or reports `Cannot open ... service`: do not infer success from a later `Running` status; obtain the required permission, rerun, and record the actual result.
- Duplicate `OK` and `Unknown` entries: act only on the `OK` Bluetooth instance matched to the current endpoint.
- Reset succeeds but no playback result: outcome is partial, not fixed.

## Verification checklist

- `bthserv` and `Audiosrv` are `Running` after restart.
- Selected Bluetooth device and current AudioEndpoint are `OK` after reset.
- The user confirms at least 1–2 minutes of playback without stutter before closure.
