# ReverseContact Homebrew Tap

Homebrew formulas for ReverseContact tools.

## Install the `rc` CLI

The release assets currently live in a private repository, so Homebrew needs a
GitHub token that can read `visum-run/reversecontact`:

```bash
export HOMEBREW_GITHUB_API_TOKEN="$(gh auth token)"
brew tap visum-run/tap git@github.com:visum-run/homebrew-tap.git
brew install visum-run/tap/rc
```

Then:

```bash
rc auth login
rc enrich person --email someone@example.com
```

## Releasing a new version

1. Tag `cli/vX.Y.Z` on `visum-run/reversecontact` (triggers the CLI release workflow).
2. Download `SHA256SUMS` from the GitHub Release.
3. Update `version`, the four `url` lines, and the four `sha256` values in `Formula/rc.rb`.
4. Commit and push.

When the project moves to public releases, remove the
`GitHubPrivateReleaseDownloadStrategy` class and the `using:` arguments, and the
token requirement disappears.
