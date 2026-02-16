class Deepwork < Formula
  include Language::Python::Virtualenv

  desc "Framework for enabling AI agents to perform complex, multi-step work tasks"
  homepage "https://github.com/Unsupervisedcom/deepwork"
  url "https://files.pythonhosted.org/packages/a1/22/a76c7d03b1c11e45d9a9d00454e36b8fecffc5e3fe482226dd3cad58b3a3/deepwork-0.8.0.tar.gz"
  sha256 "99efce3301767d1b998956b8efb10de806a588abd5c3f313b17af73dc427331b"
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
