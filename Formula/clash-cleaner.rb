class ClashCleaner < Formula
  desc "Remove invalid VLESS UUID proxies from Clash/Mihomo YAML configs"
  homepage "https://github.com/iwen-conf/clash-cleaner"
  url "https://github.com/iwen-conf/clash-cleaner/archive/refs/tags/v0.2.0.tar.gz"
  sha256 "305b2c68d9b8da8807ae9ae8fa8bd08d65bcc150312ab7cb3e6f4ad925a63cca"
  license "MIT"
  head "https://github.com/iwen-conf/clash-cleaner.git", branch: "main"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    config = testpath/"config.yaml"
    config.write <<~YAML
      proxies:
      - { name: bad, type: vless, uuid: not-a-uuid }
      proxy-groups:
      - name: All
        type: select
        proxies:
        - bad
    YAML

    output = shell_output("#{bin}/clash-cleaner --dry-run #{config}")
    assert_match "bad", output
    assert_match "invalid VLESS proxy", output
  end
end
