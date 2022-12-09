$LOAD_PATH.unshift "lib"
require "m"
require "allocation_stats"

def benchmark_allocations burn: 1, &block
  stats = AllocationStats.new(burn: burn).trace(&block)

  columns = if ENV["DETAIL"]
    [:sourcefile, :sourceline, :class_plus]
  else
    [:class_plus]
  end

  puts stats.allocations(alias_paths: true).group_by(*columns).sort_by_size.to_text
end

benchmark_allocations do
  10.times do
    M::Runner.new(["test/examples/minitest_5_example_test.rb:19"]).run
  end
end
