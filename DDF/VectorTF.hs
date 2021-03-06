{-# LANGUAGE NoImplicitPrelude, NoMonomorphismRestriction #-}

module DDF.VectorTF where

import qualified DDF.Double as Double
import qualified DDF.Meta.VectorTF as M
import qualified Prelude as M

class Double.Double r => VectorTF r where
  zero :: r h (M.VectorTF t f)
  basis :: r h (t -> M.VectorTF t f)
  plus :: r h (f -> f -> M.VectorTF t f)
  mult :: r h (M.Double -> f -> M.VectorTF t f)
  vtfMatch :: r h (a -> (t -> a) -> (f -> f -> a) -> (M.Double -> f -> a) -> M.VectorTF t f -> a)

vtfMatch4 = Double.app4 vtfMatch
vtfMatch5 = Double.app5 vtfMatch
plus2 = Double.app2 plus
mult1 = Double.app mult
mult2 = Double.app2 mult