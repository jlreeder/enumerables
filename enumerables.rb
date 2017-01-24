require 'byebug'
class Array

  def my_each(&prc)
    post = 0

    while post < self.length
      prc.call(self[post])
      post += 1
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

  # def self.numout(input)
  #   if input.class != Array
  #     input
  #   else
  #     idx = 0
  #     input.length.times do
  #       try_again = input[idx]
  #       idx += 1
  #       Array.numout(try_again)
  #     end
  #
  #   end
  # end
  #
  # def self.flat_array(ary)
  #   if ary.class != Array
  #     [ary]
  #   else
  #     flatten = []
  #     idx = 0
  #     ary.length.times do
  #       try_again = ary[idx]
  #       idx += 1
  #       flatten << Array.numout(try_again)
  #     end
  #     flatten
  #   end
  # end

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

    (0...max_array).to_a.my_each do |idx|
      row = []
      args.my_each { |sub_ary| row << sub_ary[idx] }
      array << row
    end

    array
  end

end
