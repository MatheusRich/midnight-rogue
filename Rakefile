require "rake/testtask"

desc "Opens a ruby console"
task :console do
  system("bundle exec irb -I. -r lib/midnight_rogue.rb")
end
task c: :console

desc "Outputs TODOS and FIXME comments"
task :notes do
  cmd = "grep -rni --exclude=Rakefile -e '#TODO' -e '# TODO' -e '#FIXME' -e '# FIXME' ."
  system(cmd)
end

Rake::TestTask.new do |t|
  t.pattern = "test/**/*_test.rb"
  t.warning = false
  t.description = "Runs all tests"
end
