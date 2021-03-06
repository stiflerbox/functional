{-
  Построение бесконечного списка простых чисел способом "решета Эратосфена"
-}
module Primes where

primes :: [Integer]
primes = sieve [2..]  -- просеивание списка натуральных чисел, начиная с 2.
    where
        -- Функция просевания берет первый элемент из списка, из хвоста отсеивает все элементы,
        -- делящиеся нацело на него, и рекурсивно применяет просеивание к результату фильтрации.
        sieve :: [Integer] -> [Integer]
        sieve (x:xs) = x : sieve (filter ((/=0).(`mod` x)) xs)

-- Пример: список "близнецов"
twins = filter (\(x,y) -> y-x == 2) $ zip primes (tail primes)