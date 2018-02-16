# This module provides a compare method to allow rows to be sorted such that
# every 'column' will be sorted ascending
module RowSorting
  A_BEFORE_B = -1
  B_BEFORE_A = 1

  def self.sort(input)
    sorted = []
    pool = input.clone.reverse
    discards = []

    if pool.count > 0
      element = pool[0]
      pool.delete_at(0)
      sorted << element
    end

    while pool.count > 0 do
      r_index = nil
      l_index = nil

      # take out next element from pool
      element = pool[0]
      pool.delete_at(0)

      # find place in result that new element must precede
      for i in 0..(sorted.count - 1)
        comp = self.compare((yield element), (yield sorted[i]))
        if comp == A_BEFORE_B
          r_index = i
          break
        end
      end

      # find place in result that new element must succeed
      i = sorted.count - 1
      until i < 0 do
        comp = self.compare((yield element), (yield sorted[i]))
        if comp == B_BEFORE_A
          l_index = i
          break
        end
        i -= 1
      end

      if ! r_index.nil? && ! l_index.nil?
        if r_index == l_index + 1
          sorted.insert(r_index, element) # push new element in front of index
        else
          discards << element
        end
      elsif r_index.nil?
        if self.compare((yield element), (yield sorted.last)) == B_BEFORE_A
          sorted << element
        else
          discards << element
        end
      elsif l_index.nil?
        if self.compare((yield element), (yield sorted[0])) == A_BEFORE_B
          sorted.insert(0, element)
        else
          discards << element
        end
      end
    end

    ## go through discards
    while discards.count > 0
      element = discards[0]
      discards.delete_at(0)

      ## TODO: implement
    end

    sorted
  end

  def self.compare(row_a, row_b)
    result = nil

    if row_a == row_b
      result = 0
    else
      head_a = self.beginning(row_a)
      head_b = self.beginning(row_b)

      tail_a = self.end(row_a)
      tail_b = self.end(row_b)


      if head_a[:index].nil? && head_b[:index].nil?
        result = 0
      elsif head_a[:index].nil?
        result = A_BEFORE_B
      elsif head_b[:index].nil?
        result = B_BEFORE_A
      else
        if head_a[:index] > tail_b[:index] # row_a starts after row_b ends
          result = nil
        elsif head_b[:index] > tail_a[:index] # row_b starts after row_a ends
          result = nil
        elsif head_a[:index] == head_b[:index]
          if head_b[:value] > head_a[:value]
            result = A_BEFORE_B
          elsif head_b[:value] < head_a[:value]
            result = B_BEFORE_A
          elsif head_a[:value] == head_b[:value]
            result = self.compare(row_a[1, row_a.count-1], row_b[1, row_b.count-1])
          end
        else
          result = self.compare(row_a[1, row_a.count-1], row_b[1, row_b.count-1])
        end
      end
    end

    result
  end

  def self.beginning(row)
    default = { index: nil, value: nil }

    row.each_with_index do |el, i|
      if ! el.nil?
        return {index: i, value: el}
      end
    end

    default
  end

  def self.end(row)
    default = { index: nil, value: nil }

    i = row.count - 1
    while i >= 0
      if ! row[i].nil?
        return {index: i, value: row[i]}
      end
      i -= 1
    end

    default
  end

end
