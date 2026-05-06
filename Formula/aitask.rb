class Aitask < Formula
  desc "AI Agent project orchestrator CLI"
  homepage "https://github.com/iwen-conf/aitask-cli"
  url "https://github.com/iwen-conf/aitask-cli/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "e0cb82c91b3742368a6b062451cd97a37fbf4ee9c73912176c47fba9b05d518c"
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
