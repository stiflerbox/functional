module TestComb where

import ShowExpr
import Comb
import TestExpr

-- Проверяем правильность основных правил перевода
test1, test2 :: Expression
test1 = comb plus
test2 = eval (Application (Application test1 (Constant 3)) (Constant 5))