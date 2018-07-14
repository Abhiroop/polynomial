{-# LANGUAGE MagicHash #-}
{-# LANGUAGE UnboxedTuples #-}

module Main where

import Debug.Trace

-- [1,5,6,3,4,5,6,7,8,9,9,2,3,1,2,3,4,5,1,2,8,3,2,3,4,2,8,6,7,4,2,1,2]
-- x^32 + 5 * x^31 + 6 * x^30 + 3 * x^29........2 * x^2 + x + 2

import GHC.Exts

import Criterion.Main

splitEvery _ [] = []
splitEvery n list = first : (splitEvery n rest)
  where
    (first, rest) = splitAt n list

evalPoly :: Float -> [Float] -> Float
evalPoly value coeffs = go coeffs (length coeffs - 1)
  where
    go [] _ = 0
    go (x:xs) len = (x * (value ^ len)) + go xs (len - 1)

sizeOfVec :: Int
sizeOfVec = 4

evalPolyVec :: Float -> [Float] -> Float
evalPolyVec value coeffs = go (splitEvery sizeOfVec coeffs) (length coeffs)
  where
    go [[x]] _    = x
    go (x:xs) len =
      let [(F# a), (F# b), (F# c), (F# d)] = x
          (F# val)                         = value
          packed_coeff                     = packFloatX4# (# a, b, c, d #)
          vec_val                          = broadcastFloatX4# val
          step_length                      = len - sizeOfVec
      in (go' packed_coeff vec_val step_length) + (go xs step_length)
      where
        go' pc _ 0 =
          let (# a, b, c, d #) = unpackFloatX4# pc
          in ((F# a) * value ^ 3) +
             ((F# b) * value ^ 2) +
             ((F# c) * value) +
             (F# d)
        go' pc v l =
          let t = (timesFloatX4# pc v)
          in go' t v (l - 1)

-- evalPolyVec' :: Float -> [Float] -> Float
-- evalPolyVec' value coeffs =
--   let (F# val) = value
--       vec_val  = broadcastFloatX4# val
--   in go (splitEvery sizeOfVec coeffs) (length coeffs) vec_val
--   where
--     go [[x]] _ _   = x
--     go (x:xs) len vec_v =
--       let [(F# a), (F# b), (F# c), (F# d)] = x
--           packed_coeff                     = packFloatX4# (# a, b, c, d #)
--           step_length                      = len - sizeOfVec
--       in (go' packed_coeff vec_v step_length) + (go xs step_length vec_v)
--       where
--         go' pc _ 0 =
--           let (# a, b, c, d #) = unpackFloatX4# pc
--           in ((F# a) * value ^ 3) +
--              ((F# b) * value ^ 2) +
--              ((F# c) * value) +
--              (F# d)
--         go' pc v l =
--           let t = (timesFloatX4# pc v)
--               (# m, n, o, p #) = unpackFloatX4# v
--           in trace ("foo" ++ show (F# m, F# n, F# o,F# p)) go' t v (l - 1)

-- evalPoly :: Double -> [Double] -> Double
-- evalPoly value coeffs = go coeffs (length coeffs - 1)
--   where go [] _ = 0
--         go (x : xs) len = (x * (value ^ len)) + go xs (len - 1)
-- sizeOfVec :: Int
-- sizeOfVec = 2
-- evalPolyVec :: Double -> [Double] -> Double
-- evalPolyVec value coeffs = go (splitEvery sizeOfVec coeffs) (length coeffs)
--   where go [[x]] _ = x
--         go (x : xs) len
--           = let [(D# a), (D# b)]                 = x
--                 (D# val)                         = value
--                 packed_coeff                     = packDoubleX2# (# a,b #)
--                 vec_val                          = broadcastDoubleX2# val
--                 step_length                      = len - sizeOfVec
--              in (go' packed_coeff vec_val step_length) + (go xs step_length)
--                 where
--                   go' pc _ 0 = let (# a,b #) = unpackDoubleX2# pc
--                                 in ((D# a) * value) + (D# b)
--                   go' pc v l = let t = (timesDoubleX2# pc v)
--                                    (# a,b #) = unpackDoubleX2# pc
--                                    (# m,n #) = unpackDoubleX2# v
--                                  in go' t v (l - 1)

main = defaultMain [
  bgroup "poly" [ bench "4"  $ whnf (evalPolyVec 0.2) [1,1,1,1,1]
                , bench "16" $ whnf (evalPolyVec 0.2) [1,4,2,3,4,1,5,6,7,8,8,9,1,3,1,5,6]
                , bench "32" $ whnf (evalPolyVec 0.2) [1,5,6,3,4,5,6,7,8,9,9,2,3,1,2,3,4,5,1,2,8,3,2,3,4,2,8,6,7,4,2,1,2]
               ]
  ]

