package com.thoughtworks.DDF.List

import com.thoughtworks.DDF.Product.Prod

trait ScanRight[Info[_], Repr[_]] extends Prod[Info, Repr] with ListMin[Info, Repr] {
  def scanRight[A, B](implicit ai: Info[A], bi: Info[B]): Repr[(A => B => B) => B => scala.List[A] => scala.List[B]]

  final def scanRight_[A, B]: Repr[A => B => B] => Repr[B => scala.List[A] => scala.List[B]] = f =>
    app(scanRight(domInfo(reprInfo(f)), rngInfo(rngInfo(reprInfo(f)))))(f)

  final def scanRight__[A, B]: Repr[A => B => B] => Repr[B] => Repr[scala.List[A] => scala.List[B]] = f =>
    app(scanRight_(f))

  final def scanRight___[A, B]: Repr[A => B => B] => Repr[B] => Repr[scala.List[A]] => Repr[scala.List[B]] = f => x =>
    app(scanRight__(f)(x))
}