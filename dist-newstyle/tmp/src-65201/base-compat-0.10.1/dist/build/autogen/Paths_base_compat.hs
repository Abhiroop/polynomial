{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_base_compat (
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
version = Version [0,10,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/base-compat-0.10.1-3d32467c7cbb0d66f2f49d47b2a314ae600f3adf244ecf00db293bd47ea228d7/bin"
libdir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/base-compat-0.10.1-3d32467c7cbb0d66f2f49d47b2a314ae600f3adf244ecf00db293bd47ea228d7/lib"
dynlibdir  = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/base-compat-0.10.1-3d32467c7cbb0d66f2f49d47b2a314ae600f3adf244ecf00db293bd47ea228d7/lib"
datadir    = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/base-compat-0.10.1-3d32467c7cbb0d66f2f49d47b2a314ae600f3adf244ecf00db293bd47ea228d7/share"
libexecdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/base-compat-0.10.1-3d32467c7cbb0d66f2f49d47b2a314ae600f3adf244ecf00db293bd47ea228d7/libexec"
sysconfdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/base-compat-0.10.1-3d32467c7cbb0d66f2f49d47b2a314ae600f3adf244ecf00db293bd47ea228d7/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "base_compat_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "base_compat_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "base_compat_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "base_compat_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "base_compat_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "base_compat_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
