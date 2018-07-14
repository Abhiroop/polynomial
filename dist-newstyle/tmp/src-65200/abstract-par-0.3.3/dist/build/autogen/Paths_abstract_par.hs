{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_abstract_par (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,3,3] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/abstract-par-0.3.3-b32117b98196c90b2c014530c12150796e3c9c470b15bfc79b481b951129d9f2/bin"
libdir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/abstract-par-0.3.3-b32117b98196c90b2c014530c12150796e3c9c470b15bfc79b481b951129d9f2/lib"
dynlibdir  = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/abstract-par-0.3.3-b32117b98196c90b2c014530c12150796e3c9c470b15bfc79b481b951129d9f2/lib"
datadir    = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/abstract-par-0.3.3-b32117b98196c90b2c014530c12150796e3c9c470b15bfc79b481b951129d9f2/share"
libexecdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/abstract-par-0.3.3-b32117b98196c90b2c014530c12150796e3c9c470b15bfc79b481b951129d9f2/libexec"
sysconfdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/abstract-par-0.3.3-b32117b98196c90b2c014530c12150796e3c9c470b15bfc79b481b951129d9f2/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "abstract_par_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "abstract_par_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "abstract_par_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "abstract_par_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "abstract_par_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "abstract_par_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
