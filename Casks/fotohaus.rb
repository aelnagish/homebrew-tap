cask "fotohaus" do
  version "1.0.0"
  sha256 "70f156cbac7ff5019092b8e1e8d983393ff86f1691272716b41d409325ede22c"

  url "https://github.com/aelnagish/Fotohaus/releases/download/v#{version}/Fotohaus-#{version}-arm64.dmg"
  name "Fotohaus"
  desc "Private photo organizer with on-device faces, search and editing"
  homepage "https://aelnagish.github.io/Fotohaus/"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: ">= :sonoma"

  app "Fotohaus.app"
  binary "#{appdir}/Fotohaus.app/Contents/MacOS/fotohaus-cli"

  # Fotohaus is not notarized yet. Clearing the download quarantine flag lets it
  # open without the "damaged" warning, the same step INSTALL.md describes.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/Fotohaus.app"]
  end

  zap trash: [
    "~/Library/Application Support/Fotohaus",
    "~/Library/Caches/Fotohaus",
    "~/Library/Preferences/app.fotohaus.Fotohaus.plist",
    "~/Library/Saved Application State/app.fotohaus.Fotohaus.savedState",
  ]
end
