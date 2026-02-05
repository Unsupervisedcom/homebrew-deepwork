class Deepwork < Formula
  include Language::Python::Virtualenv

  desc "Framework for enabling AI agents to perform complex, multi-step work tasks"
  homepage "https://github.com/Unsupervisedcom/deepwork"
  url "https://files.pythonhosted.org/packages/2f/b8/ecc5e4a70080d27e6e9ae6d6aced0671f904e4d78fddea92d756d8f28c85/deepwork-0.7.0a2.tar.gz"
  sha256 "863be82cc56d4e8c0193d7f838053aa63c42e35aa429727c9298264d1e8fb02d"
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
