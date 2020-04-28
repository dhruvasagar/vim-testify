# VIM Testify v0.2.1 [![CircleCI](https://circleci.com/gh/dhruvasagar/vim-testify.svg?style=svg)](https://circleci.com/gh/dhruvasagar/vim-testify)

A very basic unit testing framework for viml

## Using Testify

`Testify` leverages vim script exception handling to define assertions which
will capture error information and enable unit testing within vim's
environment, where your plugin is expected to work.

Writing tests couldn't be simpler, because you do so, in plain vimscript
without any syntactic sugar coating.

Here is what it looks like :

* Successful Test
    ```vim
    function! s:TestFunction()
      call testify#assert#equals(1, 1)
      call testify#assert#not_equals(1, 2)
    endfunction
    call testify#it('Test should pass', function('s:TestFunction'))
    ```

    You can place that code in a vim file anywhere, however I encourage and
    support placing them in a subdirectory 't' under your plugin directory.
    This will be configurable in the future.

    You can invoke `:TestifyFile` on that file to execute the tests and it will
    output the results of the tests, which will look something like this :
    ```testify
    √ Test should pass
    * Test Summary
    * ------------
    * All tests successful
    * Tests=1
    * Result: PASS
    ```
* Failed Test
    ```vim
    function! s:TestFunction()
      call testify#assert#equals(1, 2)
    endfunction
    call testify#it('Test should fail', function('s:TestFunction'))
    ```

    The output for that would look like :
    ```testify
    ✗ Test should fail
        Expected "1" to equal "2"
          <SNR>228_TestFunction:1
    * Test Summary
    * ------------
    * Tests=1
    * Fails=1
    * Result: FAIL
    ```

You can use the following commands :
* `:TestifyNearest` : This allows you to be able to run and focus on an
                      individual test. This works by searching for the next
                      occurrence of `testify#it` and call only that test.
                      NOTE: This will also reposition the cursor to the line
                      containing the next occurrence of `testify#it`.
* `:TestifySuite`   : This allows you to execute all test files recursively
                      within the `t` subdirectory under the current working
                      directory effectively executing all test cases.
* `:TestifyLast`    : This can be used to execute the most recently executed
                      test, be it `:TestifyNearest`, `:TestifyFile` or
                      `:TestifySuite`.

Currently there are 3 test logging methods supported, this can be controlled
by setting option `g:testify#logger#type`.

* `echo`  : Uses vim's echo and outputs the tests log on the standard vim
            command line.
* `shell` : Uses `!echo` to output the logs to the shell, this is default
            when invoked during vim startup using `vim +TestifySuite` and
            is useful for working with a continuous integration setup.

            NOTE: When this is invoked during vim startup, testify exits vim
            after running the tests with an appropriate exit code based on
            whether the tests passed or not. This is used by continous
            integration applications to judge whether or not the tests were
            successful.
* `buffer`: Uses a preview buffer to show the test logs. This is the default
            when using Testify from within VIM.

## Installation

1. For installation with a popular plugin manager such as vundle, vim-plug,
   neobundle, etc. add the repository `dhruvasagar/vim-testify` to your
   ~/.vimrc with the appropriate plugin command.
2. For pathogen, just clone / submodule this repository within your bundle
   directory.
3. For manual installation (highly discouraged), copy all files into your
   ~/.vim directory.

## Contributing
- Fork it
- Commit your changes and give your commit message some love
- Push to your fork on github
- Open a Pull Request

Alternatively open an issue if you find any or need help.
