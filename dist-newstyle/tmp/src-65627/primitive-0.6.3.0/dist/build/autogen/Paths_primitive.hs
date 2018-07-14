{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_primitive (
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
version = Version [0,6,3,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/primitive-0.6.3.0-b34aa9882832be94519afb4516522c61f49effc1ccdeb36d7c54a2fd8c3a8d58/bin"
libdir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/primitive-0.6.3.0-b34aa9882832be94519afb4516522c61f49effc1ccdeb36d7c54a2fd8c3a8d58/lib"
dynlibdir  = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/primitive-0.6.3.0-b34aa9882832be94519afb4516522c61f49effc1ccdeb36d7c54a2fd8c3a8d58/lib"
datadir    = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/primitive-0.6.3.0-b34aa9882832be94519afb4516522c61f49effc1ccdeb36d7c54a2fd8c3a8d58/share"
libexecdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/primitive-0.6.3.0-b34aa9882832be94519afb4516522c61f49effc1ccdeb36d7c54a2fd8c3a8d58/libexec"
sysconfdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/primitive-0.6.3.0-b34aa9882832be94519afb4516522c61f49effc1ccdeb36d7c54a2fd8c3a8d58/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "primitive_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "primitive_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "primitive_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "primitive_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "primitive_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "primitive_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
