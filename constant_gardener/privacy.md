# Privacy Policy — Constant Gardener

**Effective date:** 2026-05-20

Constant Gardener is built privacy-first. The short version:

- There is no Constant Gardener server. We don't run a backend, we don't have user accounts, and we don't collect data about you.
- We don't use analytics SDKs, ad networks, or tracking frameworks of any kind.
- Your garden — plants, photos, notes, locations — lives on your device and (if you choose) in your private iCloud.
- A few features let you talk to outside services. Those calls only happen when you ask for them, and they go directly from your device using API keys you provide. The rest of this page explains exactly what each one does.

---

## What stays on your device (and your iCloud)

Everything you create in Constant Gardener — plants, photos, locations, garden areas, reminders, tags, notes — is stored locally in the app. If you sign in to iCloud and CloudKit sync is enabled, the same data is synced to **your private iCloud container**. That's Apple's infrastructure under [Apple's privacy terms](https://www.apple.com/legal/privacy/); we, the developer, have no access to it.

If you share your garden with another household member using CloudKit Sharing, the data is shared between your iCloud accounts via Apple's CloudKit. Again: Apple's infrastructure, not ours.

## What gets sent off your device

The app makes external network calls in five situations. Each one is triggered by an explicit action you take, not in the background.

### 1. Plant identification (Pl@ntNet)

When you tap "Identify" in the plant scanner, the photo you captured is sent to **Pl@ntNet** (`my-api.plantnet.org`) using a Pl@ntNet API key you've entered in Settings. The request contains the photo and your key. It does not contain your name, your location, your device ID, or any other identifier.

Pl@ntNet's handling of submitted images is governed by their own terms. See [Pl@ntNet's policy](https://plantnet.org/en/privacy-policy/).

### 2. AI assistant features (Anthropic, OpenAI, or Google)

When you use AI features — plant care guide, taxonomy enrichment, task suggestions, holiday checklist, etc. — a text prompt is sent to whichever AI provider you've configured in Settings, using an API key you've entered. The prompt contains:

- Your country (from your device's region setting), hemisphere, timezone, and preferred language
- Plant names, botanical names, varieties, and tags you've entered
- Plant status (current / past / wishlist) and counts of locations (e.g. "2 in pots, 1 in greenhouse")
- **Any notes you've written about plants.** If you write personal information into a plant's notes field, that text will be included in the prompt.
- Tag names and existing reminder titles, where relevant to the feature

The prompts **do not** include:

- Your precise location (no GPS coordinates)
- Plant photos
- Anything about other apps, your contacts, your calendar, etc.

The data is sent directly from your device to the AI provider you selected, using your API key. Constant Gardener does not proxy these requests and does not log them.

Each provider has its own retention and training policy. Review theirs before using these features:

- [Anthropic (Claude) privacy policy](https://www.anthropic.com/legal/privacy)
- [OpenAI privacy policy](https://openai.com/policies/privacy-policy/)
- [Google AI privacy policy](https://policies.google.com/privacy)

If you don't want to use AI features at all, leave the API keys blank in Settings. The app fully works without them.

### 3. Weather warnings (Apple WeatherKit)

If weather warnings are enabled, the app uses **Apple WeatherKit** to fetch a local forecast. WeatherKit needs your device's GPS coordinates to return the right forecast. This is a direct call from your device to Apple's servers, governed by [Apple's privacy policy](https://www.apple.com/legal/privacy/). The developer never sees your coordinates.

You can disable weather warnings entirely in Settings.

### 4. Plant thumbnails (Wikipedia)

When the app needs a fallback thumbnail for a plant that doesn't have a user-added photo, it queries the public Wikipedia API using the plant's common or botanical name. The request contains only the plant name string — no user identifiers. Cached thumbnails are stored locally on your device.

You can disable dynamic thumbnails in Settings if you'd prefer the app never make these calls.

### 5. Satellite map tiles (Apple Maps)

The garden map uses MapKit, which loads satellite tiles from Apple's servers as you pan and zoom. This is standard MapKit traffic governed by [Apple's policy](https://www.apple.com/legal/privacy/).

---

## What we collect, in App Store nutrition-label terms

For App Store transparency labels, the app declares the following:

- **Photos or Videos** — when you use the plant scanner, your photo is transmitted to Pl@ntNet. Not linked to your identity (no identifiers are sent), not used for tracking, used only for app functionality.
- **Other User Content** — when you use AI features, text you've entered about plants (including notes) is transmitted to your chosen AI provider. Not linked to your identity, not used for tracking, used only for app functionality.

No other data categories are collected.

## Tracking

The app does not track you. No advertising identifiers, no cross-app correlation, no third-party tracking SDKs. The App Store privacy manifest (`PrivacyInfo.xcprivacy`) reflects this: `NSPrivacyTracking` is set to `false`.

## Your API keys

API keys you enter in Settings (Pl@ntNet, Anthropic, OpenAI, Google) are stored locally on your device through the standard iOS user defaults mechanism and synced via your private iCloud if iCloud is enabled. They are never sent to the developer.

## Children

The app is not directed at children under 13 and does not knowingly collect any data from anyone, regardless of age.

## Changes to this policy

If this policy changes in a material way, the change will be noted in the App Store release notes for the version that introduces it, and the **Effective date** at the top of this page will be updated. You can review the change history in the [GitHub repository](https://github.com/thomasp85/data_imaginist/blob/main/constant_gardener/privacy.md) for this file.

## Contact

Privacy questions: **thomasp85@gmail.com**
