class Deepwork < Formula
  include Language::Python::Virtualenv

  desc "Framework for enabling AI agents to perform complex, multi-step work tasks"
  homepage "https://github.com/Unsupervisedcom/deepwork"
  url "https://files.pythonhosted.org/packages/56/e0/99631d7cd1ee904a7732442e6c77550a98dbd6cd007d1ded0951479f027b/deepwork-0.7.0a1.tar.gz"
  sha256 "c703aee8441767170cb475c843f8097b5201bc63c393035a31bc07030db87b29"
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
