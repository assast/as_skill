#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  publish_skill_to_git.sh \
    --repo <git-url> \
    --src <skill-dir> \
    --dest <dest-path-in-repo> \
    --mode <dir|contents> \
    --name <git-author-name> \
    --email <git-author-email> \
    --message <commit-message> \
    [--delete]

Notes:
- --mode dir      : copy the directory itself into --dest (dest becomes a parent).
                   Example: src=/a/api_docs_generator, dest=./  => repo/api_docs_generator/...
- --mode contents : copy the directory *contents* into --dest.
                   Example: src=/a/api_docs_generator, dest=./  => repo/SKILL.md ...
- Default is overwrite/add; with --delete it will delete files in dest not present in src.
USAGE
}

REPO=""
SRC=""
DEST=""
MODE=""
AUTHOR_NAME=""
AUTHOR_EMAIL=""
COMMIT_MSG=""
DO_DELETE=0

while [[ $# -gt 0 ]]; do
  case "$1" in
    --repo) REPO="$2"; shift 2;;
    --src) SRC="$2"; shift 2;;
    --dest) DEST="$2"; shift 2;;
    --mode) MODE="$2"; shift 2;;
    --name) AUTHOR_NAME="$2"; shift 2;;
    --email) AUTHOR_EMAIL="$2"; shift 2;;
    --message) COMMIT_MSG="$2"; shift 2;;
    --delete) DO_DELETE=1; shift 1;;
    -h|--help) usage; exit 0;;
    *) echo "Unknown arg: $1" >&2; usage; exit 2;;
  esac
done

[[ -n "$REPO" && -n "$SRC" && -n "$DEST" && -n "$MODE" && -n "$AUTHOR_NAME" && -n "$AUTHOR_EMAIL" && -n "$COMMIT_MSG" ]] || {
  echo "Missing required args" >&2
  usage
  exit 2
}

if [[ ! -d "$SRC" ]]; then
  echo "SRC not found or not a directory: $SRC" >&2
  exit 1
fi

TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT

REPO_DIR="$TMP/repo"
git clone "$REPO" "$REPO_DIR"

cd "$REPO_DIR"
git config user.name "$AUTHOR_NAME"
git config user.email "$AUTHOR_EMAIL"

mkdir -p "$DEST"

RSYNC_DELETE=()
if [[ "$DO_DELETE" -eq 1 ]]; then
  RSYNC_DELETE+=(--delete)
fi

# Normalize src basename
BASENAME="$(basename "$SRC")"

if [[ "$MODE" == "dir" ]]; then
  # copy src directory as a child of DEST
  mkdir -p "$DEST/$BASENAME"
  rsync -a "${RSYNC_DELETE[@]}" "$SRC/" "$DEST/$BASENAME/"
elif [[ "$MODE" == "contents" ]]; then
  rsync -a "${RSYNC_DELETE[@]}" "$SRC/" "$DEST/"
else
  echo "Invalid MODE: $MODE (expected dir|contents)" >&2
  exit 2
fi

git add -A
if git diff --cached --quiet; then
  echo "No changes to commit."
  exit 0
fi

git commit -m "$COMMIT_MSG"
git push

# Summaries
echo "commit=$(git rev-parse HEAD)"
echo "repo=$REPO"
