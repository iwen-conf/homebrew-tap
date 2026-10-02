class AiCodeIndex < Formula
  desc "Local code index bootstrapper for AI coding agents"
  homepage "https://github.com/iwen-conf/ai-code-index"
  url "https://github.com/iwen-conf/ai-code-index/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "64a3d81c4439b2d547ef0db6228c084319879274c19dd50b83ad4b07ac235f39"
  license "MIT"

  depends_on "go" => :build
  depends_on "ast-grep"
  depends_on "ripgrep"
  depends_on "universal-ctags"

  def install
    system "go", "build", *std_go_args(
      output:  bin/"ai-code-index",
      ldflags: "-s -w -X main.version=#{version}",
    )
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/ai-code-index version")
    system bin/"ai-code-index", "init", "--root", testpath
    assert_path_exists testpath/".ai-code-index/search.sh"
  end
end
