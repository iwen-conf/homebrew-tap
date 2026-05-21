class Aitask < Formula
  desc "AI Agent project orchestrator CLI suite"
  homepage "https://github.com/iwen-conf/aitask-cli"
  url "https://github.com/iwen-conf/aitask-cli/archive/refs/tags/v0.4.0.tar.gz"
  sha256 "cba682ffeeb04e70b885ac4daf4c62a21efebea8adfa52e6bd19e21f43cbd5d4"
  license "MIT"
  head "https://github.com/iwen-conf/aitask-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X main.version=v#{version}"
    {
      "aitask" => "./aitask",
      "aitask-watch" => "./aitask-watch",
      "aitask-worker" => "./aitask-worker",
      "aitask-agent-watch" => "./aitask-agent-watch",
    }.each do |binary, main|
      system "go", "build", *std_go_args(ldflags: ldflags, output: bin/binary), main
    end
  end

  test do
    %w[
      aitask
      aitask-watch
      aitask-worker
      aitask-agent-watch
    ].each do |binary|
      assert_match version.to_s, shell_output("#{bin}/#{binary} --version")
    end
  end
end
