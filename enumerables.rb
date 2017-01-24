require 'byebug'
class Array
  def my_each(&prc)
    self.length.times do |i|
      prc.call(self[i])
    end

    self
  end

  def my_select(&prc)
    answer = []

    my_each { |el| answer << el if prc.call(el) }

    answer
  end

  def my_reject(&prc)
    answer = []

    my_each { |el| answer << el unless prc.call(el) }

    answer
  end

  def my_any?(&prc)
    my_each { |el| return true if prc.call(el) }
    false
  end

  def my_all?(&prc)
    my_each { |el| return false unless prc.call(el) }
    true
  end

  def my_flatten
    answer = []

    my_each do |el|
      answer += el.class != Array ? [el] : el.my_flatten
    end

    answer
  end

  def my_zip(*args)
    args.unshift(self)
    max_array = args.map(&:length).max
    array = Array.new

    self.length.times do |idx|
      row = []
      args.my_each { |sub_ary| row << sub_ary[idx] }
      array << row
    end

    array
  end

end
