defmodule ArithmeticProblems do

  # 2.01
  # is_prime will quickly return false if n has small factors.
  def is_prime(n) when is_integer(n) and n > 2 do
    2..(n-1) |>
    Stream.filter(fn(x) -> rem(n, x) == 0 end) |>
    Stream.take(1) |>
    Enum.empty?()
  end

end
