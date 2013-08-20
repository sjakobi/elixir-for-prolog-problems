defmodule ArithmeticProblems do

  # 2.01
  # is_prime will quickly return false if n has small factors.
  def is_prime(n) when is_integer(n) and n > 0 do
    case n do
      1 ->
        false
      2 ->
        true
      3 ->
        true
      _ ->
        :math.sqrt(n) |>
        trunc |>
        (fn(x) -> 2..x end).() |>
        Stream.filter(fn(x) -> rem(n, x) == 0 end) |>
        Stream.take(1) |>
        Enum.empty?
    end
  end

  # 2.02
  # primitive yet working
  def prime_factors(n) when is_integer(n) and n > 0 do
    do_prime_factors(n, 2, [])
  end

  defp do_prime_factors(1, _, factors), do: Enum.reverse(factors)
  defp do_prime_factors(n, c, factors) do
    if rem(n, c) == 0 do
      do_prime_factors(div(n, c), c, [c | factors])
    else
      do_prime_factors(n, c+1, factors)
    end
  end

end
