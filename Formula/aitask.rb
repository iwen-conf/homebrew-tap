class Aitask < Formula
  desc "AI Agent project orchestrator CLI"
  homepage "https://github.com/iwen-conf/aitask-cli"
  url "https://github.com/iwen-conf/aitask-cli/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "5b4726340d15c1cf48f689f00b53fc46816f453a9908087eaf9ad329c9a454ad"
  license "MIT"
  head "https://github.com/iwen-conf/aitask-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=v#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags, output: bin/"aitask"), "./cmd/aitask"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/aitask --version")
  end
end
