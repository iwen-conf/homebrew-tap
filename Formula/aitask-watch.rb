class AitaskWatch < Formula
  desc "Standalone NDJSON event daemon for AITask agents"
  homepage "https://github.com/iwen-conf/aitask-watch"
  url "https://github.com/iwen-conf/aitask-watch/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "2c8fadf0a7db57afbb422a031bec6f73de3c80d0c6b678f936c040f47b8c0c7e"
  license "MIT"
  head "https://github.com/iwen-conf/aitask-watch.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"aitask-watch"), "./cmd/aitask-watch"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aitask-watch --version")
  end
end
