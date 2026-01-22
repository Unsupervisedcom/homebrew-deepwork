class Deepwork < Formula
  include Language::Python::Virtualenv

  desc "Framework for enabling AI agents to perform complex, multi-step work tasks"
  homepage "https://github.com/Unsupervisedcom/deepwork"
  url "https://files.pythonhosted.org/packages/f9/dd/f0d7f6aaa535869401cc1de714ec88f7a025f43bb32a1cc352c073ff4a2c/deepwork-0.3.1.tar.gz"
  sha256 "04bee2459d992ea424328bfb6883c241b58637a19a9650ca2f561f492c718287"
  license "BSL-1.1"

  depends_on "python@3.11"

  def install
    # Create venv with pip included
    system "python3.11", "-m", "venv", libexec
    # Install deepwork and all dependencies
    system libexec/"bin/pip", "install", "--no-cache-dir", buildpath
    # Link the binary
    (bin/"deepwork").write_env_script libexec/"bin/deepwork", PATH: "#{libexec}/bin:$PATH"
  end

  test do
    system bin/"deepwork", "--version"
  end
end
