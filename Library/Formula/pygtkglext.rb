require 'formula'

class Pygtkglext < Formula
  homepage 'http://projects.gnome.org/gtkglext/download.html#pygtkglext'
  url 'http://downloads.sourceforge.net/gtkglext/pygtkglext-1.1.0.tar.gz'
  sha1 '2ae3e87e8cdfc3318d8ff0e33b344377cb3df7cb'

  depends_on 'pkg-config' => :build
  depends_on 'pygtk'
  depends_on 'gtkglext'
  depends_on 'pygobject'

  def install
    ENV['PYGTK_CODEGEN'] = which 'pygobject-codegen-2.0'
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make install"
  end

  def test
    # Test importing the modules
    mktemp do
      (Pathname.pwd+'test.py').write <<-EOS.undent
        import pygtk
        pygtk.require('2.0')
        import gtk.gtkgl
      EOS
      system "python test.py"
    end
  end
end
