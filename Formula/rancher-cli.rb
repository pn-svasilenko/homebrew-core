class RancherCli < Formula
  desc "The Rancher CLI is a unified tool to manage your Rancher server"
  homepage "https://github.com/rancher/cli"
  url "https://github.com/rancher/cli/archive/v0.6.8.tar.gz"
  sha256 "2a3b6b83d9e39f9ed090f342c40a1213c97713f87d8dab06249e169e7a4b7fc0"

  bottle do
    cellar :any_skip_relocation
    sha256 "2a3b6b83d9e39f9ed090f342c40a1213c97713f87d8dab06249e169e7a4b7fc0" => :high_sierra
    sha256 "25524f27dd0b9de57f3852994813ad9ff2b751b6602692dedc4396597c6aa8f3" => :sierra
    sha256 "6152818bc0906b12304aad3396428781052d3aedebef9031c58786520d5b61f9" => :el_capitan
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/rancher/cli/").install Dir["*"]
    system "go", "build", "-ldflags",
           "-w -X github.com/rancher/cli/version.VERSION=#{version}",
           "-o", "#{bin}/rancher",
           "-v", "github.com/rancher/cli/"
  end

  test do
    system bin/"rancher", "help"
  end
end
