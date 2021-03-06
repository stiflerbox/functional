﻿module Comb where
{-
  Функции для перевода выражений в комбинаторную форму.
  abstr - функция абстрагирования от переменной;
  comb - функция перевода в комбинаторную форму
-}

import ShowExpr -- Выражения и их текстовое представление

-- Основные комбинаторы
s, k, i :: Expression
s = Function "S"
k = Function "K"
i = Function "I"

-- Функция абстрагирования от переменной. Вторым аргументом функции
-- является выражение, уже находящееся в комбинаторной форме
abstr :: String -> Expression -> Expression
abstr _ c@(Constant _) = Application k c
abstr _ f@(Function _) = Application k f
abstr x v@(Variable y) | x == y = i
                       | otherwise = Application k v
abstr x (Application e1 e2) = Application (Application s a1) a2
    where a1 = abstr x e1
          a2 = abstr x e2

-- Преобразование произвольного выражения в комбинаторную форму
comb :: Expression -> Expression
comb (Lambda x e) = abstr x $ comb e
comb (Application e1 e2) = Application (comb e1) (comb e2)
comb e = e

-- Правила применения комбинаторов (редукций)
eval :: Expression -> Expression
eval (Application e1 e2) = let func = eval e1; arg = eval e2 in
    case  func of
        (Function "I") -> arg
        (Application (Function "K") x) -> x
        (Application (Application (Function "S") f) g) -> eval (Application (Application f arg) (Application g arg))
        (Application (Function "+") (Constant n)) -> case arg of
            Constant m -> Constant (n + m)
            otherwise -> (Application func arg)
        otherwise -> (Application func arg)
eval e = e

-- comb plus = (S (S (K S) (S (S (K S) (S (K K) (K +))) (S (K K) I))) (K I))