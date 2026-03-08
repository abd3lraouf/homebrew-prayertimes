cask "prayertimes" do
  version "2.3.1"
  sha256 "4a728871db6a5ca9c940763e122fef83f6bae988b5a29de3433c1caec3fe7dbd"

  url "https://github.com/abd3lraouf/PrayerTimes/releases/download/v#{version}/PrayerTimes-#{version}.dmg"
  name "PrayerTimes"
  desc "Menu bar app for Islamic prayer times with Hijri calendar"
  homepage "https://github.com/abd3lraouf/PrayerTimes"

  livecheck do
    url :url
    strategy :github_latest
  end

  app "PrayerTimes.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-r", "-d", "com.apple.quarantine", "#{appdir}/PrayerTimes.app"],
                   sudo: false
    system_command "/usr/bin/open",
                   args: ["#{appdir}/PrayerTimes.app"],
                   sudo: false
  end

  uninstall quit:       "com.abd3lraouf.PrayerTimes",
            login_item: "PrayerTimes"

  uninstall_postflight do
    # Reset location permission so macOS re-prompts on next install
    system_command "/usr/bin/tccutil",
                   args: ["reset", "LocationServices", "com.abd3lraouf.PrayerTimes"],
                   sudo: false
    # Flush cfprefsd cached preferences domain
    system_command "/usr/bin/defaults",
                   args: ["delete", "com.abd3lraouf.PrayerTimes"],
                   sudo: false
  end

  zap trash: [
    "~/Library/Containers/com.abd3lraouf.PrayerTimes",
    "~/Library/Preferences/com.abd3lraouf.PrayerTimes.plist",
    "~/Library/Saved Application State/com.abd3lraouf.PrayerTimes.savedState",
    "~/Library/HTTPStorages/com.abd3lraouf.PrayerTimes",
    "~/Library/Caches/com.abd3lraouf.PrayerTimes",
  ]
end

