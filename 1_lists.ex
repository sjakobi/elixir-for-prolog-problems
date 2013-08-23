defmodule ListProblems do

  # 1.01
  def last([]), do: nil
  def last([h]), do: h
  def last([_|t]), do: last(t)
  
  # 1.02
  def last_but_one([]), do: nil
  def last_but_one([_]), do: nil
  def last_but_one([h,_]), do: h
  def last_but_one([_|t]), do: last_but_one(t)

  # 1.03
  def element_at([], _), do: nil
  def element_at([ h | _ ], 0), do: h
  def element_at([ _ | t ], k) when k > 0, do: element_at(t, k-1)

  # 1.04
  def length_([]), do: 0
  def length_([ _ | t ]), do: 1 + length_(t)

  # 1.05
  def reverse(list), do: Enum.reduce(list, [], [ &1 | &2 ])

  # 1.06
  def palindrome(list), do: list == reverse(list)

  # 1.07
  def flatten([]), do: []
  def flatten([[h | t] | tt]), do: flatten(flatten([h | t]) ++ tt)
  def flatten([h | t]), do: [h | flatten(t)]

  # 1.08
  def compress(list), do: compress([], list)
  def compress(res, []), do: reverse(res)
  def compress([x | t1], [x| t2]), do: compress([x | t1], t2)
  def compress(res, [h|t]), do: compress([h | res], t)

  # 1.09
  def pack(list), do: pack([], list)
  def pack(res, []), do: reverse(res)
  def pack([[x | t1] | t2], [x | t3]), do: pack([[ x | [x | t1]] | t2 ], t3)
  def pack(res, [h | t]), do: pack([[h] | res], t)

  # 1.10
  def encode(list) do
    pack(list) |>
    Enum.map(&{length(&1), element_at(&1, 0)})
  end

  # 1.11
  def encode_mod(list) do
    pack(list) |>
    Enum.map(fn [h | t] -> if t == [] do
        h
      else
        {length(t)+1, h}
      end
    end)
  end
  
  # 1.12: decode a list encoded by encode_mod/1 or encode_direct/1
  def decode(list), do: Enum.map(list, &_decomp/1) |> _flatten([])
    def _decomp({n, x}) when n > 1, do: duplicate(x, n)
    def _decomp(x), do: x

    def _flatten([], res), do: reverse(res)
    def _flatten([[x] | t1], res), do: _flatten(t1, [x|res])
    def _flatten([[h|t1] | t2], res), do: _flatten([t1 | t2], [h | res])
    def _flatten([h | t], res), do: _flatten(t, [h | res])

  # alternative version
  def decode_2(list) do
    list |>
    Enum.map(&decomp/1) |>
    concat
  end

  defp decomp({n, x})
  when is_integer(n) and n > 1 do
    duplicate(x, n)
  end

  defp decomp(x), do: [x]

  def concat(list) do
    Enum.reduce(list, [], fn(entry, acc) -> acc ++ entry end)
  end

  # 1.13
  def encode_direct(list), do: encode_direct([], list)
  def encode_direct(res, []), do: reverse(res)
  def encode_direct([x | t1], [x | t2]), do: encode_direct([{2, x} | t1], t2)
  def encode_direct([{n, x} | t1], [x | t2]), do: encode_direct([{n+1, x} | t1], t2)
  def encode_direct(res, [h | t]), do: encode_direct([h | res], t)

  # 1.14
  def dupli(x), do: Enum.reduce(x, [], &(&2 ++ duplicate(&1, 2)))

  # 1.15
  def dupli(x, n) when n >= 0 and is_integer(n) do
    Enum.reduce(x, [], &(&2 ++ duplicate(&1, n)))
  end
  
  # 1.16
  def drop(list, n) when is_integer(n) and n > 0, do: drop(list, n, n, [])

  defp drop([], _n, _cur, res), do: reverse(res)
  defp drop([_ | t], n, 1, res), do: drop(t, n, n, res)
  defp drop([h | t], n, cur, res), do: drop(t, n,  cur-1, [h | res])

  # 1.17
  def split(list, n) when is_integer(n), do: do_split(list, n, [])

  defp do_split(list, n, res) when n < 0 do
    do_split(list, length_(list) + n, res)
  end

  defp do_split(list, 0, res), do: { reverse(res), list }
  defp do_split([], _, res), do: { reverse(res), [] }
  defp do_split([h | t], n, res), do: do_split(t, n-1, [h | res])

  # 1.18
  def slice(list, start, stop)
      when is_integer(start) and is_integer(stop) and start > 0 and start <= stop do
    do_slice(list, start, stop, [])
  end

  defp do_slice(_, _, 0, res), do: reverse(res)
  defp do_slice([], _, _, res), do: reverse(res)
  defp do_slice([h|t], 1, stop, res), do: do_slice(t, 1, stop-1, [h|res])
  defp do_slice([_|t], start, stop, res), do: do_slice(t, start-1, stop-1, res)
  
  # 1.19
  def rotate(list, n) when is_integer(n) do 
    { a, b } = split(list, n)
    b ++ a
  end

  # 1.20
  def remove_at(list, n) when is_integer(n) and n >= 0 do
    { a, [x|b] } = split(list, n)
    { x, a ++ b }
  end
  
  # 1.21
  def insert_at(elem, list, n) when is_integer(n) do
    { a, b } = split(list, n)
    a ++ [elem | b]
  end
  
  # 1.22
  # the easy way
  def range(start, stop), do: start..stop |> Enum.to_list

  def duplicate(x, n) when n >= 0 and is_integer(n), do: duplicate(x, n, [])
  def duplicate(_, 0, res), do: res
  def duplicate(x, n, res), do: duplicate(x, n-1, [x | res])
end
