class AiCodeIndex < Formula
  desc "Local code index bootstrapper for AI coding agents"
  homepage "https://github.com/iwen-conf/ai-code-index"
  url "https://github.com/iwen-conf/ai-code-index/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "af4da7a11864b44a5b6d31f88703ff8b56cc14a5c39afc0c3155b062484d5d52"
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
