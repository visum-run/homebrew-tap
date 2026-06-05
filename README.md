# ReverseContact Homebrew Tap

Homebrew formulas for ReverseContact tools.

## Install the `rc` CLI

```bash
brew tap visum-run/tap git@github.com:visum-run/homebrew-tap.git
brew install visum-run/tap/rc
```

No token needed: the binaries are public archives served from
`app.reversecontact.com/cli/*` (only this tap repository itself is still
private, hence the explicit git URL in `brew tap`).

Alternative without Homebrew:

```bash
curl -fsSL https://app.reversecontact.com/cli/install.sh | sh
```

Then:

```bash
rc auth login
rc enrich person --email someone@example.com
```

## Releasing a new version

1. Tag `cli/vX.Y.Z` on `visum-run/reversecontact`. The release workflow builds
   the binaries and publishes the archives, `SHA256SUMS`, and `manifest.json`.
2. Fetch `https://app.reversecontact.com/cli/vX.Y.Z/SHA256SUMS`.
3. Update `version`, the four `url` lines, and the four `sha256` values in
   `Formula/rc.rb`.
4. Commit and push.

When this tap goes public, `brew tap visum-run/tap` (without the git URL) will
be enough.
