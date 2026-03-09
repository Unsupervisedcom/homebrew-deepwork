class Deepwork < Formula
  include Language::Python::Virtualenv

  desc "Framework for enabling AI agents to perform complex, multi-step work tasks"
  homepage "https://github.com/Unsupervisedcom/deepwork"
  url "https://files.pythonhosted.org/packages/5c/e2/76b92a4b8685fe79ce9840aecd357e06471d0e200811fb78e9a2e9522cb8/deepwork-0.9.6.tar.gz"
  sha256 "9a6a564b115b9365995d3ce2f42b4723e8d82dcf86da27d5135e6575f8a5dc27"
  license "BSL-1.1"

  depends_on "python@3.11"
  depends_on "uv"

  def install
    # Create venv with pip included
    system "python3.11", "-m", "venv", libexec
    # Install deepwork and all dependencies
    system libexec/"bin/pip", "install", "--no-cache-dir", buildpath
    # Link the binary
    (bin/"deepwork").write_env_script libexec/"bin/deepwork", PATH: "#{libexec}/bin:$PATH"
  end

  def caveats
    <<~EOS
      DeepWork includes `uv` for managing Python environments.
      AI agents can create project-specific virtual environments:
        uv venv .venv
        uv pip install <package>
    EOS
  end

  test do
    system bin/"deepwork", "--version"
    system "uv", "--version"
  end
end
