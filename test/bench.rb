require 'benchmark'

Benchmark.bmbm do |bench|
  TIMES = 100
  bench.report("running m on a file that doesn't exist, #{TIMES} times") do
    TIMES.times do
      `ruby -Ilib ./bin/m failwhale 2>/dev/null`
    end
  end
end
