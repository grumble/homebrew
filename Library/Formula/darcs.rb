require "language/haskell"

class Darcs < Formula
  include Language::Haskell::Cabal

  desc "Distributed version control system that tracks changes, via Haskell"
  homepage "http://darcs.net/"
  url "http://darcs.net/releases/darcs-2.10.1.tar.gz"
  mirror "https://mirrors.kernel.org/debian/pool/main/d/darcs/darcs_2.10.1.orig.tar.gz"
  sha256 "f1ef65b43780e7593ca1afdae5ecf44ed91d62cc1be360693a52c5ff7b57ee94"

  bottle do
    sha256 "66086e078cdb111cf517313997a29044d8f3c16e45bdcdc06ad438a37d6d0c32" => :yosemite
    sha256 "6c1161e09c005bab52e63faec61610076c3c4393e850229e2117c94a0e78f4d4" => :mavericks
    sha256 "c97c89b0b0d04e067476a807d308ef3ee24296a420d13a0be16b8822b919d8ab" => :mountain_lion
  end

  depends_on "ghc" => :build
  depends_on "cabal-install" => :build
  depends_on "gmp"

  setup_ghc_compilers

  def install
    install_cabal_package
  end

  test do
    mkdir "my_repo" do
      system "darcs", "init"
      (Pathname.pwd/"foo").write "hello homebrew!"
      system "darcs", "add", "foo"
      system "darcs", "record", "-am", "add foo", "--author=homebrew"
    end
    system "darcs", "get", "my_repo", "my_repo_clone"
    Dir.chdir "my_repo_clone" do
      assert (Pathname.pwd/"foo").read.include? "hello homebrew!"
    end
  end
end
