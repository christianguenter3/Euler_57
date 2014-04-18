require 'test/unit'

def get_iteration(iteration)     
   1 + Rational(1 / Rational( 2 + expand(iteration - 1)))  
end

def expand(i)
  return 0 if i == 0
  Rational(1 / Rational(2 + expand(i - 1)))
end

def gen_seq(limit)
  limit.times do |i|
    yield get_iteration(i + 1)
  end
end

def find_solution
  res = 0
  gen_seq(1000) do |x|
    res += 1 if x.numerator.to_s.length > x.denominator.to_s.length
  end
  res
end

class TestEuler57 < Test::Unit::TestCase
  TEST_CASES = { 1 => Rational("3/2"),
                 2 => Rational("7/5"),
                 3 => Rational("17/12"),
                 4 => Rational("41/29"),
                 7 => Rational("577/408"),
                 8 => Rational("1393/985") }

  def test_get_iteration
    TEST_CASES.each{|input, output| assert(get_iteration(input) == output)}
  end

  def test_gen_seq   
    res = [] 
    gen_seq(3){|x| res << x}
    assert( res == [Rational("3/2"), Rational("7/5"), Rational("17/12")])
  end

  def test_find_solution
    assert_equal(153, find_solution)
  end
end