{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_Only (
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
version = Version [0,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/Only-0.1-d06fba363c1b8c886c0ee248380fd926a20f9bfcd495496990afe8877e64a02a/bin"
libdir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/Only-0.1-d06fba363c1b8c886c0ee248380fd926a20f9bfcd495496990afe8877e64a02a/lib"
dynlibdir  = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/Only-0.1-d06fba363c1b8c886c0ee248380fd926a20f9bfcd495496990afe8877e64a02a/lib"
datadir    = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/Only-0.1-d06fba363c1b8c886c0ee248380fd926a20f9bfcd495496990afe8877e64a02a/share"
libexecdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/Only-0.1-d06fba363c1b8c886c0ee248380fd926a20f9bfcd495496990afe8877e64a02a/libexec"
sysconfdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/Only-0.1-d06fba363c1b8c886c0ee248380fd926a20f9bfcd495496990afe8877e64a02a/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "Only_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "Only_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "Only_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "Only_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "Only_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "Only_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
