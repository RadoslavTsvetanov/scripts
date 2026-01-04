#!/bin/bash

# Git Branch + Worktree Creator
# Usage: ./create-branch-worktree.sh <branch-name> [worktree-path]
#
# Creates a new branch and a worktree for it, with checks to ensure
# the branch doesn't already exist locally or remotely.

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
error() {
    echo -e "${RED}✗ Error: $1${NC}" >&2
    exit 1
}

success() {
    echo -e "${GREEN}✓ $1${NC}"
}

info() {
    echo -e "${YELLOW}ℹ $1${NC}"
}

# Check if we're in a git repository
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    error "Not in a git repository"
fi

# Check arguments
if [ $# -lt 1 ]; then
    error "Usage: $0 <branch-name> [worktree-path]"
fi

BRANCH_NAME="$1"
REPO_ROOT=$(git rev-parse --show-toplevel)
REPO_NAME=$(basename "$REPO_ROOT")

# Default worktree path: ../repo-name-branch-name
if [ -n "$2" ]; then
    WORKTREE_PATH="$2"
else
    WORKTREE_PATH="${REPO_ROOT}/../${REPO_NAME}-${BRANCH_NAME}"
fi

info "Branch name: $BRANCH_NAME"
info "Worktree path: $WORKTREE_PATH"
echo ""

# Check if branch exists locally
if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
    error "Branch '$BRANCH_NAME' already exists locally"
fi

success "Branch doesn't exist locally"

# Fetch latest from remote to ensure we have up-to-date refs
info "Fetching from remote..."
git fetch --all --quiet

# Check if branch exists on any remote
REMOTE_BRANCHES=$(git branch -r | grep -E "/$BRANCH_NAME$" || true)

if [ -n "$REMOTE_BRANCHES" ]; then
    echo -e "${RED}Branch '$BRANCH_NAME' exists on remote(s):${NC}"
    echo "$REMOTE_BRANCHES"
    error "Cannot create branch that already exists remotely"
fi

success "Branch doesn't exist on any remote"

# Check if worktree path already exists
if [ -e "$WORKTREE_PATH" ]; then
    error "Path '$WORKTREE_PATH' already exists"
fi

success "Worktree path is available"
echo ""

# Create the branch and worktree
info "Creating branch '$BRANCH_NAME'..."
git branch "$BRANCH_NAME"
success "Branch created"

info "Creating worktree at '$WORKTREE_PATH'..."
git worktree add "$WORKTREE_PATH" "$BRANCH_NAME"

echo ""
success "Done! Branch and worktree created successfully"
echo ""
echo "To start working:"
echo "  cd $WORKTREE_PATH"
echo ""
echo "To remove the worktree later:"
echo "  git worktree remove $WORKTREE_PATH"
echo "  git branch -d $BRANCH_NAME  # (optional, to delete the branch)"
