rspec-preloader
===============

Life is too short to be waiting for your tests to load.
---

So you like TDD, but waiting for your specs to load is sucking the fun out of the process? We've got you covered.

rspec-preloader loads your `spec_helper.rb` so that your tests can be started almost instantly. No more waiting for your gems and your whole environment to load.

Installing
---
No surprises:
```
  gem install rspec-preloader
```

Or in your Gemfile
```
  gem 'rspec-preloader'
```

Watched folders (git repositories)
---
Is your project spread across multiple folders?
By default the only watched folder is the one where you start the preloader, but there is a way.
Create a .rspec_preloader set relative paths to the other folders.
```
../local_gem_installation
../some_other_git_folder
```


Prereqs
---
Rspec and a git repo.

Usage
---

So you're test driving some cool class? Great! Once you write your first test, let's make sure that bad boy is red.
```
  $rspec-preloader spec/models/some_cool_class_spec.rb
```
This will run `rspec spec/models/some_cool_class_spec.rb` and wait for additional input.

Now write some code to make the test green, go back to your shell and press Up and Enter.

This will instantly run `rspec spec/models/some_cool_class_spec.rb` again.

Now refactor, and rerun as many times as you want.

Once you're done, Control-D or `exit` out of the preloader.

If you want to run rspec with any other arguments, you can give them to the preloader readline or when calling the command.

rspec-preloader will pass your input to rspec as is, so you can use any input rspec would accept, including specific line numbers or formatting options.
Only files from `app/` and `lib/` will be reloaded. If you modify spec helpers or spec support files, you should probably restart the preloader.

How it works
---
This is what happens under the hood :
- require `spec/spec_helper.rb`, and waits for input.
- fork a process and run the tests in that process
- wait for the next command
- fork
- find which ruby files in `app/` and `lib/` have been modified using git
- load them
- run rspec in the forked process with the given input
- start over

Issues
---
Some frameworks like Grape don't like having client code reloaded a bunch or time.
When working with these, your specs might be red and magically go back to green when you restart the preloader.
Hopefully, I haven't yet faced the case where a spec is green with the preloader and red without it, but you never know.

If you find any other issue, open it on Github, I'd be really happy to read about it and find a fix.

Contributing
---
Contributions welcome! Just fork it and send a pull request.

This gem is under the MIT license by the way.

