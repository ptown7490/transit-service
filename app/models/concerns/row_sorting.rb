# This module provides
module RowSorting

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
        result = 1
      elsif head_b[:index].nil?
        result = -1
      else
        if head_a[:index] > tail_b[:index] # row_a starts after row_b ends
          if head_a[:value] <= tail_b[:value]
            result = 1
          else
            result = -1
          end
        elsif head_b[:index] > tail_a[:index] # row_b starts after row_a ends
          if head_b[:value] <= tail_a[:value]
            result = -1
          else
            result = 1
          end
        elsif head_a[:index] == head_b[:index]
          if head_b[:value] > head_a[:value]
            result = 1
          elsif head_b[:value] < head_a[:value]
            result = -1
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
