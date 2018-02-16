require 'rails_helper'

describe "RowSorting.beginning" do
  it "finds first non-nil element in row" do
    row = [nil, nil, 3, 4, nil]
    expect(RowSorting.beginning(row)).to eq({index: 2, value: 3})
  end
end

describe "RowSorting.end" do
  it "finds last non-nil element in row" do
    row = [nil, nil, 3, 4, nil]
    expect(RowSorting.end(row)).to eq({index: 3, value: 4})
  end
end

describe "RowSorting.compare" do
  it "returns 0 for equivalent rows" do
    a = [1, 2, 3, 4, 5, 6, 7]
    b = [1, 2, 3, 4, 5, 6, 7]

    empty_a = [nil, nil, nil, nil, nil, nil, nil]
    empty_b = [nil, nil, nil, nil, nil, nil, nil]

    expect(RowSorting.compare(a, b)).to eq(0)
    expect(RowSorting.compare(empty_a, empty_b)).to eq(0)
  end

  it "places row with larger first element after other row" do
    a = [1, 2, 3, 4, 5, 6, 7]
    b = [2, 3, 4, 5, 6, 7, 8]

    expect(RowSorting.compare(a, b)).to eq(RowSorting::A_BEFORE_B)
    expect(RowSorting.compare(b, a)).to eq(RowSorting::B_BEFORE_A)
  end

  it "places empty row before all other rows" do
    a = [1, 2, 3, 4, 5, 6, 7]
    b = [nil, nil, nil, nil, nil, nil, nil]

    expect(RowSorting.compare(a, b)).to eq(RowSorting::B_BEFORE_A)
    expect(RowSorting.compare(b, a)).to eq(RowSorting::A_BEFORE_B)
  end

  it "compares by the first pair of non-equal numbers" do
    a = [2, 3, 4, 5, 6, 7, 8]
    b = [2, 7, 8, 9, 10, 11, 12]

    expect(RowSorting.compare(a, b)).to eq(RowSorting::A_BEFORE_B)
    expect(RowSorting.compare(b, a)).to eq(RowSorting::B_BEFORE_A)
  end

  it "skips any pairs where either value is nil" do
    a = [nil, nil, nil, 6, 7, 8, 10]
    b = [2, 7, 8, 9, 10, 11, 12]

    expect(RowSorting.compare(a, b)).to eq(RowSorting::A_BEFORE_B)
    expect(RowSorting.compare(b, a)).to eq(RowSorting::B_BEFORE_A)
  end

  it "returns nil when rows have no overlap" do
    a = [nil, nil, nil, 6, 7, 8, 10]
    b = [3, 8, 9, nil, nil, nil, nil]

    c = [nil, nil, nil, nil, 11, 12, 13]
    d = [4, 9, 10, 11, nil, nil, nil]

    e = [nil, 4, 5, nil, nil, nil, nil]

    expect(RowSorting.compare(a, b)).to eq(nil)
    expect(RowSorting.compare(b, a)).to eq(nil)

    expect(RowSorting.compare(c, d)).to eq(nil)
    expect(RowSorting.compare(d, c)).to eq(nil)

    expect(RowSorting.compare(e, a)).to eq(nil)
    expect(RowSorting.compare(a, e)).to eq(nil)
  end

  it "places rows correctly when they have no overlap" do
    a = [nil, nil, nil, 6, 7, 8, 10]
    b = [3, 8, 9, nil, nil, nil, nil]

    c = [nil, nil, nil, nil, 11, 12, 13]
    d = [4, 9, 10, 11, nil, nil, nil]

    e = [nil, 4, 5, nil, nil, nil, nil]

    expect(RowSorting.compare(a, b, false)).to eq(RowSorting::A_BEFORE_B)
    expect(RowSorting.compare(b, a, false)).to eq(RowSorting::B_BEFORE_A)

    expect(RowSorting.compare(c, d, false)).to eq(RowSorting::A_BEFORE_B)
    expect(RowSorting.compare(d, c, false)).to eq(RowSorting::B_BEFORE_A)

    expect(RowSorting.compare(e, a, false)).to eq(RowSorting::A_BEFORE_B)
    expect(RowSorting.compare(a, e, false)).to eq(RowSorting::B_BEFORE_A)
  end
end

describe "RowSorting.sort" do
  it "sorts tables without nils" do
    a = [1, 2, 3, 4, 5, 6, 7]
    b = [2, 3, 4, 5, 6, 7, 8]
    c = [2, 7, 8, 9, 10, 11, 12]

    sorted = [
      a, b, c
    ]
    test_table = [
      c,
      a,
      b,
    ].reverse

    result = RowSorting.sort(test_table) do |item|
      item
    end

    expect(result).to eq(sorted)
  end

  it "sorts rows that do not overlap for every comparison" do
    a = [1, 2, 3, 4, 5, 6, 7]
    b = [2, 3, 4, 5, 6, 7, 8]
    c = [nil, 4, 5, nil, nil, nil, nil]
    d = [2, 7, 8, 9, 10, 11, 12]
    e = [3, 8, 9, nil, nil, nil, nil]
    f = [4, 9, 10, 11, nil, nil, nil]
    g = [nil, nil, nil, 12, 13, 14, 15]

    sorted = [
      a, b, c, d, e, f, g
    ]
    test_table = [
      d,
      c,
      f,
      b,
      a,
      g,
      e,
    ]

    result = RowSorting.sort(test_table) do |item|
      item
    end

    expect(result).to eq(sorted)
  end

  it "" do
    a = [nil, nil, nil, nil, nil, nil, nil]
    b = [1, 2, 3, 4, 5, 6, 7]
    c = [2, 3, 4, 5, 6, 7, 8]
    d = [nil, 4, 5, nil, nil, nil, nil]
    e = [nil, nil, nil, 6, 7, 8, 10]
    f = [2, 7, 8, 9, 10, 11, 12]
    g = [3, 8, 9, nil, nil, nil, nil]
    h = [nil, nil, nil, nil, 11, 12, 13]
    i = [4, 9, 10, 11, nil, nil, nil]

    sorted = [
      a, b, c, d, e, f, g, h, i,
    ]
    test_table = [
      c,
      f,
      g,
      a,
      h,
      i,
      e,
      b,
      d,
    ]

    result = RowSorting.sort(test_table) do |item|
      item
    end

    expect(result).to eq(sorted)
  end
end
