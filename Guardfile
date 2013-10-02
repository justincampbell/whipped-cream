guard :rspec, all_on_start: true, all_after_pass: true, env: { skip_coverage: true } do
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')  { "spec" }
end

guard :cane do
  watch(/.*\.rb/)
end
