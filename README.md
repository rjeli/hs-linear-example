I saw [this post on HN](https://news.ycombinator.com/item?id=23574072) and wanted to try it out, but installing nightly GHC was harder than expected. Here's how to avoid building from source, tested on Debian 10:

```
# grabbed from the latest commit to ghc master on gitlab. may need to change for other distro.
# artifact evidently expires in a month
cd ~/Downloads # or wherever
curl -LO https://gitlab.haskell.org/ghc/ghc/-/jobs/371731/artifacts/raw/ghc-x86_64-deb10-linux.tar.xz
mkdir -p ~/ghc-nightlies/
tar -xf ghc-x86_64-deb10-linux.tar.xz -C ~/ghc-nightlies
cd ~/ghc-nightlies/ghc-8.11.0.20200619/
mkdir pfx
./configure --prefix=$PWD/pfx
make install
export PATH=$HOME/ghc-nightlies/ghc-8.11.0.20200619/pfx/bin:$PATH
cd ~/repos/hs-linear-example # or wherever you checked this out
ghc Main.hs # cool, it compiled, now read Main.hs to see the cool linear type stuff
```
