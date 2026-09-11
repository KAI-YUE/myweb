# Personal website: source and release copies

Open `/mnt/ssd/Prev/Projects/websites/myweb/` as the editor workspace.
This is the current editable Hugo source project, connected to
`https://github.com/KAI-YUE/myweb.git`.

## Which copy is which?

| Path | Role | How to use it |
| --- | --- | --- |
| `/mnt/ssd/Prev/Projects/websites/myweb/` | Current source; local edits happen here | Edit `content/`, `config.toml`, and site assets here. Source changes are not automatically published. |
| `/mnt/ssd/Prev/Projects/websites/myweb/public/` | Generated release output; separate Git repository for `KAI-YUE/website` | Review generated files here before committing and pushing the release. Do not hand-edit the HTML. |
| `/mnt/ssd/Prev/Projects/websites/website/` | Older duplicate of the generated-output repository | Not the output destination of the current source project's deploy script. |
| `/mnt/ssd/Prev/Projects/hugo/myweb/` | Older source checkout with missing Git objects | Do not use as the editing or release base. |

## Current snapshot — September 10, 2026

- The current source project contains uncommitted website refresh edits.
- Its `public/` repository is clean at commit `fb2ffb2` (`update`, December 12, 2023).
- The refresh has not been built or deployed. `public/` still contains the older generated site.

`public/` is the release-output location, not a guarantee that its contents are
up to date, reviewed, or already live. After a build, it may contain uncommitted
generated changes too. A clean Git checkout only means it matches its local commit.
This snapshot will become historical; inspect both repositories for current state:

```bash
git status --short
git -C public status --short
git -C public log -1 --oneline
```

## Build and deployment relationship

```text
myweb source → Hugo build → myweb/public → GitHub KAI-YUE/website → Netlify (likely)
```

The configured site URL is `https://kaiyue.netlify.app`.
The Netlify repository connection has not been confirmed in the Netlify dashboard.
The local deployment script suggests that Netlify consumes `KAI-YUE/website`;
confirm the linked repository and production branch before releasing.

The existing `deploy.sh` immediately runs `hugo -D`, enters `public/`, and
commits and pushes the generated output. It is a publishing script, not a local
preview command. `-D` includes draft content. The script does not stop on a failed
command and does not pause for review, so do not use it to check a draft or preview
changes. It also does not commit or push the source repository.

For a reviewed release, treat these as separate steps:

1. Finish and review the source edits in this project.
2. Build and preview when authorized; inspect the resulting `public/` changes.
3. Commit and push source changes to `KAI-YUE/myweb` for source history.
4. Commit and push approved generated output from `public/` to `KAI-YUE/website`.
5. Confirm the production deploy and inspect the live site in Netlify.

Committing source alone does not update the generated-output repository.
Pushing generated output may trigger a public deployment once the Netlify
connection is configured.
