class CheckPermissions < Formula
    desc "A CLI tool to scan Info.plist files and report the permissions requested by each file."
    homepage "https://github.com/ezefranca/check-permissions"
    url "https://github.com/ezefranca/check-permissions/archive/refs/tags/0.0.3.tar.gz"
    sha256 "a2bba81780470796f79d5a6c595f658885b15778c856a59a50be8edc561b3a50"
    license "MIT"
  
    depends_on "swift" => :build
  
    def install
      system "make", "build"
      system "make", "PREFIX=#{prefix}", "install_bin"
    end
  
    test do
      system "#{bin}/check-permissions", "--help"
    end
  end  