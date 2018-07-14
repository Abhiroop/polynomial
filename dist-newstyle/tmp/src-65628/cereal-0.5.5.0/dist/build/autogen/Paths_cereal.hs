{-# LANGUAGE CPP #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -fno-warn-implicit-prelude #-}
module Paths_cereal (
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
version = Version [0,5,5,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/cereal-0.5.5.0-d4d2adc97f9ed3487f92e18e97d707da2a7da4cf8bd6a15fbaf8ef5ae86d0db5/bin"
libdir     = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/cereal-0.5.5.0-d4d2adc97f9ed3487f92e18e97d707da2a7da4cf8bd6a15fbaf8ef5ae86d0db5/lib"
dynlibdir  = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/cereal-0.5.5.0-d4d2adc97f9ed3487f92e18e97d707da2a7da4cf8bd6a15fbaf8ef5ae86d0db5/lib"
datadir    = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/cereal-0.5.5.0-d4d2adc97f9ed3487f92e18e97d707da2a7da4cf8bd6a15fbaf8ef5ae86d0db5/share"
libexecdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/cereal-0.5.5.0-d4d2adc97f9ed3487f92e18e97d707da2a7da4cf8bd6a15fbaf8ef5ae86d0db5/libexec"
sysconfdir = "/Users/abhiroop/.cabal/store/ghc-8.5.20180708/cereal-0.5.5.0-d4d2adc97f9ed3487f92e18e97d707da2a7da4cf8bd6a15fbaf8ef5ae86d0db5/etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "cereal_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "cereal_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "cereal_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "cereal_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "cereal_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "cereal_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "/" ++ name)
