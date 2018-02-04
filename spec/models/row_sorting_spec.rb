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

    expect(RowSorting.compare(a, b)).to eq(-1)
    expect(RowSorting.compare(b, a)).to eq(1)
  end

  it "places empty row before all other rows" do
    a = [1, 2, 3, 4, 5, 6, 7]
    b = [nil, nil, nil, nil, nil, nil, nil]

    expect(RowSorting.compare(a, b)).to eq(1)
    expect(RowSorting.compare(b, a)).to eq(-1)
  end

  it "compares by the first pair of non-equal numbers" do
    a = [2, 3, 4, 5, 6, 7, 8]
    b = [2, 7, 8, 9, 10, 11, 12]

    expect(RowSorting.compare(a, b)).to eq(-1)
    expect(RowSorting.compare(b, a)).to eq(1)
  end

  it "skips any pairs where either value is nil" do
    a = [nil, nil, nil, 6, 7, 8, 10]
    b = [2, 7, 8, 9, 10, 11, 12]

    expect(RowSorting.compare(a, b)).to eq(-1)
    expect(RowSorting.compare(b, a)).to eq(1)
  end

  it "places rows correctly when they have no overlap" do
    a = [nil, nil, nil, 6, 7, 8, 10]
    b = [3, 8, 9, nil, nil, nil, nil]

    c = [nil, nil, nil, nil, 11, 12, 13]
    d = [4, 9, 10, 11, nil, nil, nil]

    e = [nil, 4, 5, nil, nil, nil, nil]

    expect(RowSorting.compare(a, b)).to eq(-1)
    expect(RowSorting.compare(b, a)).to eq(1)

    expect(RowSorting.compare(c, d)).to eq(-1)
    expect(RowSorting.compare(d, c)).to eq(1)

    expect(RowSorting.compare(e, a)).to eq(-1)
    expect(RowSorting.compare(a, e)).to eq(1)
  end
end
