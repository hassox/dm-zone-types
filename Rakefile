# --------------------------------------------------
# Tests
# --------------------------------------------------
namespace(:test) do

  desc "run framework compatibility tests"
  task(:all) do
    paths = Dir['test/**/test_*.rb'] - ['test/test_helper.rb']

    paths.each do |path|
      cmd = "ruby -rubygems -I.:lib #{path}"
      puts(cmd) if ENV['VERBOSE']
      system(cmd)
    end
  end

  desc "Run all tests on multiple ruby versions (requires rvm)"
  task(:portability) do
    versions = %w(  1.8.6  1.8.7  1.9  1.9.2  jruby  )
    versions.each do |version|
      system <<-BASH
        bash -c 'source ~/.rvm/scripts/rvm;
                 rvm use #{version};
                 echo "--------- #{version} ----------\n";
                 rake -s test:all'
      BASH
    end
  end
end

