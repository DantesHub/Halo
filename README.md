# Halo

1. brew install swiftlint
2. <img width="951" alt="CleanShot 2023-08-29 at 17 49 09@2x" src="https://github.com/BeemoAI/Halo/assets/51376601/a4bcefe8-5bf7-46b3-b6d3-0442e945ba4b">
3. Paste in the following:
# Type a script or drag a script file from your workspace to insert its path.
if [[ "$(uname -m)" == arm64 ]]; then
    export PATH="/opt/homebrew/bin:$PATH"
fi

if which swiftlint > /dev/null; then
  swiftlint
else
  echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
fi

