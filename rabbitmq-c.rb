class RabbitmqC < Formula
  desc "RabbitMQ C client"
  homepage "https://github.com/alanxz/rabbitmq-c"
  url "https://github.com/alanxz/rabbitmq-c/archive/v0.5.2.tar.gz"
  sha256 "418726e830567c296292fd37325d8eeea7b8973c143c4b50b8acf694244ff6a7"
  head "https://github.com/alanxz/rabbitmq-c.git"

  option "without-tools", "Build without command-line tools"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"
  depends_on "popt" if build.with? "tools"

  def install
    args = std_cmake_args
    args << "-DBUILD_EXAMPLES=OFF"
    args << "-DBUILD_TESTS=OFF"
    args << "-DBUILD_API_DOCS=OFF"

    if build.with? "tools"
      args << "-DBUILD_TOOLS=ON"
    else
      args << "-DBUILD_TOOLS=OFF"
    end

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    system bin/"amqp-get", "--help"
  end
end
