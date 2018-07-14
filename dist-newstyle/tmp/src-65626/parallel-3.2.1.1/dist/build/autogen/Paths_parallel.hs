{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_parallel (
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
version = Version [3,2,1,1] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/parallel-3.2.1.1-7884ccb0385fd0c640082f2f52231b945fb7a002d54ef89590d18aea76a8876b/bin"
libdir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/parallel-3.2.1.1-7884ccb0385fd0c640082f2f52231b945fb7a002d54ef89590d18aea76a8876b/lib"
dynlibdir  = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/parallel-3.2.1.1-7884ccb0385fd0c640082f2f52231b945fb7a002d54ef89590d18aea76a8876b/lib"
datadir    = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/parallel-3.2.1.1-7884ccb0385fd0c640082f2f52231b945fb7a002d54ef89590d18aea76a8876b/share"
libexecdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/parallel-3.2.1.1-7884ccb0385fd0c640082f2f52231b945fb7a002d54ef89590d18aea76a8876b/libexec"
sysconfdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/parallel-3.2.1.1-7884ccb0385fd0c640082f2f52231b945fb7a002d54ef89590d18aea76a8876b/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "parallel_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "parallel_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "parallel_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "parallel_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "parallel_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "parallel_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
