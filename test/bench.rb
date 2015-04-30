require 'benchmark/ips'

Benchmark.ips do |bench|
  bench.report("running m on a file that doesn't exist") do
    `ruby -Ilib ./bin/m failwhale 2>/dev/null`
  end

  bench.report("running m on an empty file") do
    `ruby -Ilib ./bin/m test/examples/empty_example_test.rb 2>/dev/null`
  end

  bench.report("running m on an entire file with minitest5") do
    `appraisal minitest5 ruby -Ilib ./bin/m test/examples/minitest_5_example_test.rb 2>/dev/null`
  end

  bench.report("running m on an entire file with minitest4") do
    `appraisal minitest4 ruby -Ilib ./bin/m test/examples/minitest_4_example_test.rb 2>/dev/null`
  end

  bench.report("running m on a specific test with minitest4") do
    `appraisal minitest4 ruby -Ilib ./bin/m test/examples/minitest_4_example_test.rb:19 2>/dev/null`
  end

  bench.report("running m on a specific test with minitest5") do
    `appraisal minitest5 ruby -Ilib ./bin/m test/examples/minitest_5_example_test.rb:19 2>/dev/null`
  end
end
