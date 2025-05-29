# Tari Address Generator

A browser‑based tool for creating and restoring Tari wallet addresses in multiple human‑friendly encodings. Runs completely client‑side and ships in both **online** and **offline** variants.

## Features

* **Generate new addresses** – cryptographically secure key‑pairs in seconds
* **Restore from seed words** – recover an existing address from a 24‑word mnemonic phrase
* **Payment‑ID support** – create integrated addresses with optional payment IDs (≤ 256 bytes)
* **Multiple networks** – MainNet, NextNet and Esmeralda out of the box
* **Multiple formats** – outputs in **Base‑58** and **Emoji** (the keys themselves are shown in hex)
* **Real‑time updates** – address preview updates live as you type
* **Standards compliant** – follows the RFC‑0155 *TariAddress* specification
* 🔒 **Offline support** – a fully self‑contained bundle with **zero** external dependencies

## Quick Start

```bash
# serve locally  (recommended – avoids file:// WASM/CORS restrictions)
python -m http.server 8000
open http://localhost:8000/address.html
```

*Opening `address.html` directly from the file‑system (`file://`) works in most browsers*

For air‑gapped use, build (or download) **`address.bundle.html`** – a single HTML file that embeds all JavaScript + WASM assets and can be opened anywhere, even completely offline.

## Prerequisites

| Tool                      | Purpose                                      |
| ------------------------- | -------------------------------------------- |
| **Node.js ≥ 18** & npm    | required by the bundler script               |
| **Bash**, `curl`, `sed`   | used inside *js\_bundler.sh*                 |
| **Any static web‑server** | e.g. `python -m http.server`, `vite preview` |

## Building the offline bundle

```bash
chmod +x js_bundler.sh   # one‑time
./js_bundler.sh
```

The script fetches the JS, writes the two JS files you need for ```address.html```.

## Supported networks

| Network   | Prefix | Emoji Prefix |
| --------- | :----: | :----------: |
| MainNet   |    T   |      🐢      |
| NextNet   |    t   |       ⏩      |
| Esmeralda |    e   |      💎      |

(The *Prefix* column shows the **first Base‑58 character** of the resulting address.)

## Browser support

The generator itself is ES2020‑compliant. The embedded **Argon2** WASM build requires:

* Chrome 79+, Edge 79+, Firefox 68+
* **Safari 14+** (earlier versions ship a partial WebAssembly implementation)

## Security

This code has **not** undergone a formal security audit. Use at your own risk and test thoroughly before handling significant value.

## Licence

Released under the **BSD 3‑Clause Licence** – see [`LICENSE.txt`](./LICENSE.txt) for full terms.

All third‑party dependencies retain their original licences:

| Library                                                    | Licence          |
| ---------------------------------------------------------- | ---------------- |
| Noble crypto, BIP‑39 word‑lists, Base‑58, ChaCha20, CRC‑32 | MIT              |
| Argon2 (WASM)                                              | Apache‑2.0 / CC0 |

## Contributing

Pull requests and issues are welcome!
Please follow the [Tari Code of Conduct](https://github.com/tari-project/tari/blob/development/CODE_OF_CONDUCT.md) and keep discussions constructive.

## Links

* [Tari Project](https://github.com/tari-project/tari)
* [RFC‑0155 · TariAddress](https://github.com/tari-project/tari/blob/development/RFC/src/RFC-0155_TariAddress.md)
* [Damm checksum algorithm](https://en.wikipedia.org/wiki/Damm_algorithm)

---

*Enjoy your fully functional Tari Address Generator! 🚀*