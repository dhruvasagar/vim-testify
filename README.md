# VIM Testify v0.0.2

A very basic unit testing framework for viml

## Using Testify

Testify leverages vimscript exception handling to define assertions which will
capture error information and enable unit testing within vim's environment,
where your plugin is expected to work.

Writing tests couldn't be simpler, because you do so, in plain vimscript
without any syntactic sugar coating.

Here are a few examples :

1. Successful Test

    ```vim
    function! s:TestFunction()
      call testify#assert#equals(1, 1)
      call testify#assert#not_equals(1, 2)
    endfunction
    call testify#it('Test should pass', function('s:TestFunction'))
    ```

    You can place that code in a vim file anywhere, however I encourage and
    support placing them in a subdirectory 't' under your plugin directory. (This
    will be configurable in the future.).

    You can invoke `:TestifyFile` on that file to execute the tests and it will
    output the results of the tests, which will look something like this :

    ```
    √ Test should pass
    ```
2. Failed Test

    ```vim
    function! s:TestFunction()
      call testify#assert#equals(1, 2)
    endfunction
    call testify#it('Test should fail', function('s:TestFunction'))
    ```

    The output for that would look like :

    ```
    ✗ Test should fail
        Expected 1 to equal 2
    ```

You can also invoke `:TestifyLast` to execute the most recent executed test,
or `:TestifySuite` to execute all test files recursively within the `t`
subdirectory under the current working directory.

Currently there are 2 testing output methods supported, one is `echo` and the
other `buffer`. You can configure it by setting option
`g:testify#logger#output` to `echo` or `buffer`. Echo would simply
echo the output of all tests on the standard vim command line, however buffer
will do so in a temporary file shown in a preview window.

## Installation

1. For installation with vundle / vim-plug / neobundle add the repository
   `dhruvasagar/vim-testify` to your ~/.vimrc with the appropriate plugin
   command.
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
