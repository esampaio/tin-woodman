#!/usr/bin/env rake

require './tin-woodman'
require 'resque'
require 'resque/tasks'

task :default do
  system "rake -T"
end

desc "Starts 6 workers"
task :run do
  puts "Starting 6 workers..."
  system "BACKGROUND=yes TERM_CHILD=1 COUNT=6 QUEUE=* rake resque:workers"
  puts "Workers started!"
end

desc "Enqueues an id or a range of ids to be downloaded"
task :enqueue, [:id_start, :id_end] do |t, args|
  puts "Enqueueing #{(args.id_start..(args.id_end || args.id_start)).count} tasks..."
  (args.id_start..(args.id_end || args.id_start)).each do |id|
    Resque.enqueue(Ginfes, id)
  end
  puts "Done!"
end
