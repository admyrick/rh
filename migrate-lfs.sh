# 1. Install Git LFS if not installed (macOS/Linux)
if ! command -v git-lfs &> /dev/null
then
    echo "Git LFS not found. Installing..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install git-lfs
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt update && sudo apt install -y git-lfs
    fi
fi

# Initialize Git LFS
git lfs install

# 2. Track large files (customize patterns if needed)
git lfs track "*.apk"
git lfs track "*.zip"
git lfs track "*.iso"
git add .gitattributes
git commit -m "Set up Git LFS tracking for large files" || true

# 3. Convert existing large files in history to LFS
echo "Rewriting repo to migrate large files to Git LFS..."
git lfs migrate import --include="*.apk,*.zip,*.iso"

# 4. Add and commit any other files
git add .
git commit -m "Migrate large files to Git LFS" || true

# 5. Push everything to GitHub
git push origin main --force
