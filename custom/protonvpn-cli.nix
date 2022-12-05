{ lib
, python3
, fetchFromGitHub
, python39Packages
}:


python3.pkgs.buildPythonApplication rec {
  pname = "protonvpn-cli";
  version = "3.13.0";
  format = "setuptools";

  disabled = python3.pkgs.pythonOlder "3.5";

  src = fetchFromGitHub {
    owner = "protonvpn";
    repo = "linux-cli";
    rev = "refs/tags/${version}";
    sha256 = "sha256-KhfogC23i7THe6YZJ6Sy1+q83vZupHsS69NurHCeo8I=";
  };

  propagatedBuildInputs = [
    python39Packages.protonvpn-nm-lib
    python39Packages.pythondialog
  ];

  # Project has a dummy test
  doCheck = false;

  meta = with lib; {
    description = "Linux command-line client for ProtonVPN";
    homepage = "https://github.com/protonvpn/linux-cli";
    maintainers = with maintainers; [ wolfangaukang ];
    license = licenses.gpl3Plus;
    platforms = platforms.linux;
    mainProgram = "protonvpn-cli";
  };
}
