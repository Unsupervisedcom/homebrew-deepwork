class Deepwork < Formula
  include Language::Python::Virtualenv

  desc "Framework for enabling AI agents to perform complex, multi-step work tasks"
  homepage "https://github.com/Unsupervisedcom/deepwork"
  url "https://files.pythonhosted.org/packages/c9/a5/04f220678799de4607bc86755b8d4daec9fe6e544374626158d4e138714e/deepwork-0.9.0.tar.gz"
  sha256 "2d79c8c4409e2069339ebfb90215356b61bcc7fa1d3a5d617d2268690731a683"
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
