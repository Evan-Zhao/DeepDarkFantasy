{-# LANGUAGE
  NoImplicitPrelude,
  MultiParamTypeClasses,
  FlexibleInstances,
  NoMonomorphismRestriction
#-}

module DDF.WithDiff where
import DDF.Lang
import qualified Prelude as M
import DDF.Diff ()

class Monoid r w => WithDiff r w where
  withDiff :: r h ((w -> x) -> w -> DiffType x w)

withDiff1 = app withDiff
selfWithDiff :: (DBI r, WithDiff r w) => r h (w -> DiffType w w)
selfWithDiff = withDiff1 id

instance Lang repr => ProdCon (WithDiff repr) l r where prodCon = Sub Dict

instance Lang r => WithDiff r () where
  withDiff = const1 id

instance Lang r => WithDiff r M.Double where
  withDiff = lam2 $ \con d -> dual1 $ mkProd2 d (app con doubleOne)

instance Lang r => WithDiff r M.Float where
  withDiff = lam2 $ \con d -> dual1 $ mkProd2 d (app con floatOne)

instance (Lang repr, WithDiff repr l, WithDiff repr r) => WithDiff repr (l, r) where
  withDiff = lam $ \con -> bimap2 (withDiff1 (lam $ \l -> app con (mkProd2 l zero))) (withDiff1 (lam $ \r -> app con (mkProd2 zero r)))
